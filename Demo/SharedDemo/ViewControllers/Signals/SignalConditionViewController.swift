//
//  SignalConditionViewController.swift
//  ChartIQDemo
//
//  Copyright 2012-2022 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - SignalCondition ViewController

class SignalConditionViewController: BaseViewController {

  // MARK: - TableSection Enum

  enum TableSection: Int, CaseIterable {
    case first = 0, second
  }

  // MARK: - IBOutlets

  @IBOutlet private var tableView: UITableView!

  // MARK: - Internal Properties

  internal var chartIQView: ChartIQView!

  internal var study: ChartIQStudy?
  internal var condition: ConditionViewModel?
  internal var isAppearanceSettingsHidden: Bool = false

  internal var didSaveConditon: ((ConditionViewModel) -> Void)?

  // MARK: - Private Properties

  private var cancelBarButtonItem: UIBarButtonItem?
  private var saveBarButtonItem: UIBarButtonItem?
  private var conditionViewModels: [TableSection: [TableCellViewModelProtocol]] = [:]
  private let locManager = LocalizationManager.shared()

  // MARK: - ViewController Lifecycle Methods

  override func viewDidLoad() {
    super.viewDidLoad()

    setupCondition()
    updateConditionViewModels()
  }

  override func languageDidChange() {
    cancelBarButtonItem?.title = locManager.localize(Const.General.cancelTitle)
    saveBarButtonItem?.title = locManager.localize(Const.General.saveTitle)
    updateConditionViewModels()
  }

  // MARK: - Setup Methods

  override func setupUI() {
    navigationItem.title = condition?.conditionName ?? Const.SignalCondition.screenTitle
    tableView.backgroundColor = .ghostWhiteСhineseBlackColor
    saveBarButtonItem = UIBarButtonItem(title: locManager.localize(Const.General.saveTitle),
                                        style: .done,
                                        target: self,
                                        action: #selector(saveButtonTapped))
    navigationItem.rightBarButtonItem = saveBarButtonItem

    if isPresentedModally {
      cancelBarButtonItem = UIBarButtonItem(title: locManager.localize(Const.General.cancelTitle),
                                            style: .plain,
                                            target: self,
                                            action: #selector(cancelButtonTapped))
      navigationItem.leftBarButtonItem = cancelBarButtonItem
    }
  }

  override func setupSettings() {
    tableView.register(nibName: Const.SelectTableCell.cellNibName, cellId: Const.SelectTableCell.cellId)
    tableView.register(nibName: Const.TextTableCell.cellNibName, cellId: Const.TextTableCell.cellId)
    tableView.register(nibName: Const.TextColorTableCell.cellNibName, cellId: Const.TextColorTableCell.cellId)

    tableView.delegate = self
    tableView.dataSource = self

    addKeyboardObservers()
    validateAll()
  }

  // MARK: - Actions Methods

  @objc private func cancelButtonTapped() {
    dismiss(animated: true, completion: nil)
  }

  @objc private func saveButtonTapped() {
    saveCondition()
  }

  // MARK: - Private Methods

  private func setupCondition() {
    guard let study = study, condition == nil else { return }
    var firstIndicatorName: String = ""
    if let outputs = study.outputs, let key = outputs.keys.first {
      firstIndicatorName = key
    }
    let markerOptions = ChartIQMarkerOptions(markerType: .marker,
                                             color: .clear,
                                             shape: .circle,
                                             label: "X",
                                             size: .medium,
                                             position: .aboveCandle)
    condition = ConditionViewModel(firstIndicatorName: firstIndicatorName, markerOptions: markerOptions)
  }

  private func getFirstIndicatorOptions() -> [String] {
    var options: [String] = []
    if let study = study, let outputs = study.outputs {
      options.append(contentsOf: outputs.keys)
    }
    return options
  }

  private func getSecondIndicatorOptions(firstIndicatorName: String?) -> [String] {
    var options: [String] = []
    if let study = study, let outputs = study.outputs, let firstIndicatorName = firstIndicatorName {
      let values = outputs.keys.filter({ $0 != firstIndicatorName })
      options.append(contentsOf: values)
    }
    options.append("Value")
    options.append(contentsOf: ChartIQQuoteField.conditionCases.map({ $0.displayName }))
    return options
  }

  private func updateConditionViewModels() {
    var conditionSettingsViewModels: [TableCellViewModelProtocol] = [
      SelectTableCellViewModel(title: locManager.localize("Indicator 1"),
                               detailTitle: condition?.firstIndicatorName),
      SelectTableCellViewModel(title: locManager.localize("Condition"),
                               detailTitle: condition?.conditionOperator?.displayName ?? "Select Action")
    ]

    if condition?.conditionOperator != nil {
      conditionSettingsViewModels.append(SelectTableCellViewModel(title: locManager.localize("Indicator 2"),
                                                                  detailTitle: condition?.secondIndicatorName))

      if let secondIndicatorName = condition?.secondIndicatorName, secondIndicatorName == "Value" {
        var number = 0.0
        if let secondIndicatorValue = condition?.secondIndicatorValue {
          number = secondIndicatorValue
        } else {
          condition?.secondIndicatorValue = number
        }
        conditionSettingsViewModels.append(NumberTableCellViewModel(title: locManager.localize("Value"),
                                                                    number: number))
      }

      if !isAppearanceSettingsHidden {
        var appearanceSettingsViewModels: [TableCellViewModelProtocol] = [
          SelectTableCellViewModel(title: locManager.localize("Marker Type"),
                                   detailTitle: condition?.markerOptions?.markerType.displayName),
          ColorTableCellViewModel(title: locManager.localize("Color"),
                                  color: condition?.markerOptions?.color ?? .clear)
        ]

        if condition?.markerOptions?.markerType == .marker {
          let markerSettingsViewModels: [TableCellViewModelProtocol] = [
              SelectTableCellViewModel(title: locManager.localize("Shape"),
                                       detailTitle: condition?.markerOptions?.shape.displayName),
              TextTableCellViewModel(title: locManager.localize("Tag Mark"),
                                     text: condition?.markerOptions?.label),
              SelectTableCellViewModel(title: locManager.localize("Size"),
                                       detailTitle: condition?.markerOptions?.size.displayName),
              SelectTableCellViewModel(title: locManager.localize("Position"),
                                       detailTitle: condition?.markerOptions?.position.displayName)
          ]
          appearanceSettingsViewModels.append(contentsOf: markerSettingsViewModels)
        }

        conditionViewModels = [
          .first: conditionSettingsViewModels,
          .second: appearanceSettingsViewModels
        ]
      } else {
        conditionViewModels = [
          .first: conditionSettingsViewModels
        ]
      }
    } else {
      conditionViewModels = [
        .first: conditionSettingsViewModels
      ]
    }

    tableView.reloadData()
    validateAll()
  }

  private func saveCondition() {
    view.endEditing(true)
    guard let condition = condition else { return }
    view.startActivityIndicator()
    didSaveConditon?(condition)
    view.stopActivityIndicator()
    if isPresentedModally {
      dismiss(animated: true)
    } else {
      navigationController?.popViewController(animated: true)
    }
  }

  private func getOptions(at indexPath: IndexPath) -> (options: [String], selectedOption: String) {
    var options: [String] = []
    var selectedOption: String = ""
    if indexPath.section == 0 {
      if indexPath.row == 0 {
        // First Indicator Option
        options = getFirstIndicatorOptions()
        let key = condition?.firstIndicatorName ?? options.first
        selectedOption = key ?? ""
      } else if indexPath.row == 1 {
        // First Indicator Condition
        options = ChartIQSignalOperator.allCases.map({ $0.displayName })
        selectedOption = condition?.conditionOperator?.displayName ?? ""
      } else if indexPath.row == 2 {
        // Second Indicator Option
        options = getSecondIndicatorOptions(firstIndicatorName: condition?.firstIndicatorName)
        selectedOption = condition?.secondIndicatorName ?? options.first ?? ""
      }
    } else {
      if indexPath.row == 0 {
        options = ChartIQSignalMarkerType.allCases.map({ $0.displayName })
        selectedOption = condition?.markerOptions?.markerType.displayName ?? ""
      } else if indexPath.row == 2 {
        options = ChartIQSignalShape.allCases.map({ $0.displayName })
        selectedOption = condition?.markerOptions?.shape.displayName ?? ""
      } else if indexPath.row == 4 {
        options = ChartIQSignalSize.allCases.map({ $0.displayName })
        selectedOption = condition?.markerOptions?.size.displayName ?? ""
      } else if indexPath.row == 5 {
        options = ChartIQSignalPosition.allCases.map({ $0.displayName })
        selectedOption = condition?.markerOptions?.position.displayName ?? ""
      }
    }
    return (options: options, selectedOption: selectedOption)
  }

  private func updateSelectedOption(with newOption: String, and options: [String], at indexPath: IndexPath) {
    guard let tableSection = TableSection(rawValue: indexPath.section) else { return }
    switch tableSection {
    case .first:
        updateConditionSettings(with: newOption, and: options, at: indexPath.row)
    case .second:
        updateAppearanceSettings(with: newOption, and: options, at: indexPath.row)
    }
    updateConditionViewModels()
  }

  private func updateConditionSettings(with newOption: String, and options: [String], at index: Int) {
    if index == 0 {
      condition?.firstIndicatorName = newOption
      condition?.secondIndicatorName != nil ? updateSecondIndicatorName() : ()
    } else if index == 1 {
      guard let optionIndex = options.firstIndex(of: newOption) else { return }
      condition?.conditionOperator = ChartIQSignalOperator(rawValue: optionIndex)
      updateSecondIndicatorName()
    } else if index == 2 {
      condition?.secondIndicatorName = newOption
    }
  }

  private func updateAppearanceSettings(with newOption: String, and options: [String], at index: Int) {
    guard let optionIndex = options.firstIndex(of: newOption) else { return }
    if index == 0 {
      condition?.markerOptions?.markerType = ChartIQSignalMarkerType(rawValue: optionIndex) ?? .marker
    } else if index == 2 {
      condition?.markerOptions?.shape = ChartIQSignalShape(rawValue: optionIndex) ?? .circle
    } else if index == 4 {
      condition?.markerOptions?.size = ChartIQSignalSize(rawValue: optionIndex) ?? .medium
    } else if index == 5 {
      condition?.markerOptions?.position = ChartIQSignalPosition(rawValue: optionIndex) ?? .aboveCandle
    }
  }

  private func updateSecondIndicatorName() {
    DispatchQueue.main.async {
      let firstIndicatorName = self.condition?.firstIndicatorName
      let secondIndicatorName = self.getSecondIndicatorOptions(firstIndicatorName: firstIndicatorName).first
      self.condition?.secondIndicatorName = secondIndicatorName
      self.updateConditionViewModels()
    }
  }

  private func updateSelectedColor(with color: UIColor) {
    condition?.markerOptions?.color = color
    updateConditionViewModels()
  }

  private func updateSelectedText(with viewModel: TableCellViewModelProtocol, from textField: UITextField) {
    if let textViewModel = viewModel as? TextTableCellViewModel {
      let text = textField.text ?? ""
      textViewModel.text = text
      condition?.markerOptions?.label = text
    } else if let numberViewModel = viewModel as? NumberTableCellViewModel {
      let value = Double(textField.text ?? "0") ?? 0.0
      numberViewModel.number = value
      condition?.secondIndicatorValue = value
    }
  }

  private func validateAll() {
    let isAllFieldsValid = condition?.conditionOperator != nil
    saveBarButtonItem?.isEnabled = isAllFieldsValid
  }

  // MARK: - Show Controllers Private Methods

  private func showSelectOptionsController(indexPath: IndexPath) {
    guard let controller = UIStoryboard.selectOptionViewController() else { return }
    let options = getOptions(at: indexPath)
    controller.options = options.options
    controller.selectedOption = options.selectedOption
    controller.didSelectOption = { [weak self] option in
      guard let newOption = options.options.first(where: { $0 == option }) else { return }
      self?.updateSelectedOption(with: newOption, and: options.options, at: indexPath)
    }
    view.endEditing(true)
    navigationController?.pushViewController(controller, animated: true)
  }

  // MARK: - Present Controllers Private Methods

  private func presentFullScreenPickerController() {
    guard let controller = UIStoryboard.fullScreenPickerViewController() else { return }
    let selectedColor = condition?.markerOptions?.color ?? .clear
    controller.selectedPickerViewItem = PickerViewItem(selectedColor: selectedColor, selectedLine: nil)
    controller.didSelectPickerViewItem = { [weak self] item in
      guard let self = self, let newSelectedColor = item.selectedColor else { return }
      self.updateSelectedColor(with: newSelectedColor)
    }
    let navigationController = NavigationController(rootViewController: controller)
    view.endEditing(true)
    present(navigationController, animated: true, completion: nil)
  }

  // MARK: - Private UITableView Helper Methods

  private func getTableCell(from viewModel: TableCellViewModelProtocol,
                            at indexPath: IndexPath) -> UITableViewCell {
    if let selectViewModel = viewModel as? SelectTableCellViewModel,
       let selectCell = tableView.dequeueReusableCell(withIdentifier: Const.SelectTableCell.cellId,
                                                      for: indexPath) as? SelectTableCell {
      selectCell.setupCell(withViewModel: selectViewModel)
      selectCell.didSelectButtonTapped = { [weak self] in
        self?.showSelectOptionsController(indexPath: indexPath)
      }
      return selectCell
    } else if (viewModel is TextTableCellViewModel) || (viewModel is NumberTableCellViewModel),
       let textCell = tableView.dequeueReusableCell(withIdentifier: Const.TextTableCell.cellId,
                                                    for: indexPath) as? TextTableCell {
      textCell.setupCell(withViewModel: viewModel)
      textCell.didTextFieldEndEditing = { [weak self] textField in
        self?.updateSelectedText(with: viewModel, from: textField)
      }
      return textCell
    } else if let colorViewModel = viewModel as? ColorTableCellViewModel,
       let textColorCell = tableView.dequeueReusableCell(withIdentifier: Const.TextColorTableCell.cellId,
                                                         for: indexPath) as? TextColorTableCell {
      textColorCell.setupCell(withViewModel: colorViewModel)
      textColorCell.didSelectColorButtonTapped = { [weak self] in
        self?.presentFullScreenPickerController()
      }
      return textColorCell
    }
    return UITableViewCell()
  }
}

// MARK: - UITableViewDataSource

extension SignalConditionViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return conditionViewModels.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let tableSection = TableSection(rawValue: section) else { return 0 }
    return conditionViewModels[tableSection]?.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let tableSection = TableSection(rawValue: indexPath.section),
          let viewModel = conditionViewModels[tableSection]?[indexPath.row] else { return UITableViewCell() }
    return getTableCell(from: viewModel, at: indexPath)
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    guard let tableSection = TableSection(rawValue: section) else { return nil }
    switch tableSection {
    case .first:
      return locManager.localize(Const.SignalCondition.conditionSettingsHeaderTitle)
    case .second:
      return locManager.localize(Const.SignalCondition.appearanceSettingsHeaderTitle)
    }
  }
}

// MARK: - UITableViewDelegate

extension SignalConditionViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    view.endEditing(true)
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return Const.BaseTableCell.cellHeight
  }

  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return Const.BaseTableCell.headerHeight
  }
}

// MARK: - UIViewControllerKeyboardProtocol

extension SignalConditionViewController: UIViewControllerKeyboardProtocol {

  var scrollView: UIScrollView! {
    return tableView
  }
}
