//
//  StudyDetailViewController.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - StudyDetail ViewController

class StudyDetailViewController: BaseViewController {

  // MARK: - TableSection Enum

  enum TableSection: Int, CaseIterable {
    case first = 0, second, total
  }

  // MARK: - IBOutlets

  @IBOutlet private var tableView: UITableView!

  // MARK: - Internal Properties

  internal var study: ChartIQStudy!
  internal var inputParameters: [[String: Any]] = [[:]]
  internal var outputParameters: [[String: Any]] = [[:]]
  internal var paramParameters: [[String: Any]] = [[:]]
  internal var didRemoveStudy: ((ChartIQStudy) -> Void)?
  internal var didSaveStudy: ((ChartIQStudy) -> Void)?

  // MARK: - Private Properties

  private var saveBarButtonItem: UIBarButtonItem?
  private var studyViewModels: [TableSection: [TableCellViewModelProtocol]] = [:]
  private var selectedCellIndex = 0
  private let studiesService = StudiesService()
  private let locManager = LocalizationManager.shared()

  // MARK: - ViewController Lifecycle Methods

  override func viewDidLoad() {
    super.viewDidLoad()

    updateStudyViewModels()
  }

  override func languageDidChange() {
    saveBarButtonItem?.title = locManager.localize(Const.General.saveTitle)
    updateStudyViewModels()
  }

  // MARK: - Setup Methods

  override func setupUI() {
    navigationItem.title = locManager.localize(study.name)
    tableView.backgroundColor = .ghostWhiteСhineseBlackColor
    saveBarButtonItem = UIBarButtonItem(title: locManager.localize(Const.General.saveTitle),
                                        style: .done,
                                        target: self,
                                        action: #selector(saveButtonTapped))
    navigationItem.rightBarButtonItem = saveBarButtonItem
  }

  override func setupSettings() {
    tableView.register(nibName: Const.ButtonTableCell.cellNibName, cellId: Const.ButtonTableCell.cellId)
    tableView.register(nibName: Const.TextTableCell.cellNibName, cellId: Const.TextTableCell.cellId)
    tableView.register(nibName: Const.TextColorTableCell.cellNibName, cellId: Const.TextColorTableCell.cellId)
    tableView.register(nibName: Const.ToggleTableCell.cellNibName, cellId: Const.ToggleTableCell.cellId)
    tableView.register(nibName: Const.SelectTableCell.cellNibName, cellId: Const.SelectTableCell.cellId)
    tableView.delegate = self
    tableView.dataSource = self

    addKeyboardObservers()
  }

  // MARK: - Actions Methods

  @objc private func saveButtonTapped() {
    saveStudy()
  }

  // MARK: - Private Methods

  private func updateStudyViewModels() {
    var parameterViewModels: [TableCellViewModelProtocol] = []
    let parameters: [[String: Any]] = inputParameters + outputParameters + paramParameters
    for parameter in parameters {
      if let viewModel = studiesService.getStudyViewModel(from: parameter, isDarkTheme: isUserInterfaceStyleDark) {
        parameterViewModels.append(viewModel)
      }
    }
    studyViewModels = [
      .first: parameterViewModels,
      .second: [
        ButtonTableCellViewModel(title: locManager.localize(Const.StudyDetail.resetDefaultsButtonTitle),
                                 titleColor: .mountainMeadowColor),
        ButtonTableCellViewModel(title: locManager.localize(Const.StudyDetail.removeStudyButtonTitle),
                                 titleColor: .coralRedColor)
      ]
    ]
    tableView.reloadData()
  }

  private func saveStudyParameters() {
    var inputs: [String: Any] = [:]
    var outputs: [String: Any] = [:]
    var parameters: [String: Any] = [:]
    for inputParameter in inputParameters {
      if let name = inputParameter[ChartIQConst.StudyParameter.nameKey] as? String,
        let value = inputParameter[ChartIQConst.StudyParameter.valueKey] {
        inputs[name] = value
      }
    }
    for outputParameter in outputParameters {
      if let name = outputParameter[ChartIQConst.StudyParameter.nameKey] as? String,
        let color = outputParameter[ChartIQConst.StudyParameter.colorKey] {
        outputs[name] = color
      }
    }
    for paramParameter in paramParameters {
      if let type = paramParameter[ChartIQConst.StudyParameter.typeKey] as? String,
        type == ChartIQConst.StudyParameter.checkboxKey {
        if var name = paramParameter[ChartIQConst.StudyParameter.nameKey] as? String,
          let value = paramParameter[ChartIQConst.StudyParameter.valueKey] {
          name += ChartIQConst.StudyParameter.enabledAdditionalKey
          parameters[name] = value
        }
      } else {
        if var name = paramParameter[ChartIQConst.StudyParameter.nameKey] as? String,
          let textValue = paramParameter[ChartIQConst.StudyParameter.valueKey] {
          name += ChartIQConst.StudyParameter.valueAdditionalKey
          parameters[name] = textValue
        }
        if var name = paramParameter[ChartIQConst.StudyParameter.nameKey] as? String,
          let colorValue = paramParameter[ChartIQConst.StudyParameter.colorKey] {
          name += ChartIQConst.StudyParameter.colorAdditionalKey
          parameters[name] = colorValue
        }
      }
    }
    study.inputs = inputs
    study.outputs = outputs
    study.parameters = parameters
  }

  private func resetStudyParameters() {
    for (index, var inputParameter) in inputParameters.enumerated() {
      if let defaultValue = inputParameter[ChartIQConst.StudyParameter.defaultInputKey] {
        inputParameter[ChartIQConst.StudyParameter.valueKey] = defaultValue
      }
      inputParameters[index] = inputParameter
    }
    for (index, var outputParameter) in outputParameters.enumerated() {
      if let defaultColor = outputParameter[ChartIQConst.StudyParameter.defaultOutputKey] {
        outputParameter[ChartIQConst.StudyParameter.colorKey] = defaultColor
      }
      outputParameters[index] = outputParameter
    }
    for (index, var paramParameter) in paramParameters.enumerated() {
      if let type = paramParameter[ChartIQConst.StudyParameter.typeKey] as? String,
        type == ChartIQConst.StudyParameter.checkboxKey {
        if let defaultValue = paramParameter[ChartIQConst.StudyParameter.defaultValueKey] {
          paramParameter[ChartIQConst.StudyParameter.valueKey] = defaultValue
        }
      } else {
        if let defaultValue = paramParameter[ChartIQConst.StudyParameter.defaultValueKey] {
          paramParameter[ChartIQConst.StudyParameter.valueKey] = defaultValue
        }
        if let defaultColor = paramParameter[ChartIQConst.StudyParameter.defaultColorKey] {
          paramParameter[ChartIQConst.StudyParameter.colorKey] = defaultColor
        }
      }
      paramParameters[index] = paramParameter
    }
  }

  private func updateInputParameters(name: String, value: Any) {
    for (index, var inputParameter) in inputParameters.enumerated()
      where inputParameter[ChartIQConst.StudyParameter.nameKey] as? String == name {
        inputParameter[ChartIQConst.StudyParameter.valueKey] = value
        inputParameters[index] = inputParameter
        break
    }
  }

  private func updateOutputParameters(name: String, value: Any) {
    for (index, var outputParameter) in outputParameters.enumerated()
      where outputParameter[ChartIQConst.StudyParameter.nameKey] as? String == name {
        outputParameter[ChartIQConst.StudyParameter.colorKey] = value
        outputParameters[index] = outputParameter
        break
    }
  }

  private func updateParamParameters(name: String, valueKey: String, value: Any) {
    for (index, var paramParameter) in paramParameters.enumerated()
      where paramParameter[ChartIQConst.StudyParameter.nameKey] as? String == name {
        paramParameter[valueKey] = value
        paramParameters[index] = paramParameter
        break
    }
  }

  private func updateSelectedColor(with viewModel: TableCellViewModelProtocol,
                                   at indexPath: IndexPath) {
    selectedCellIndex = indexPath.row
    if let textColorViewModel = viewModel as? TextColorTableCellViewModel {
      presentFullScreenPickerController(parameterName: textColorViewModel.title,
                                        parameterColor: textColorViewModel.color)
    } else if let colorViewModel = viewModel as? ColorTableCellViewModel {
      presentFullScreenPickerController(parameterName: colorViewModel.title,
                                        parameterColor: colorViewModel.color)
    }
  }

  private func updateSelectedText(with viewModel: TableCellViewModelProtocol,
                                  from textField: UITextField) {
    if let textViewModel = viewModel as? TextTableCellViewModel {
      let value = textField.text ?? ""
      textViewModel.text = value
      updateInputParameters(name: textViewModel.title, value: value)
    } else if let numberViewModel = viewModel as? NumberTableCellViewModel {
      let value = Double(textField.text ?? "0") ?? 0.0
      numberViewModel.number = value
      updateInputParameters(name: numberViewModel.title, value: value)
    } else if let textColorViewModel = viewModel as? TextColorTableCellViewModel {
      let value = Int(textField.text ?? "0") ?? 0
      textColorViewModel.number = value
      updateParamParameters(name: textColorViewModel.title, valueKey: ChartIQConst.StudyParameter.valueKey, value: value)
    }
  }

  private func updateSelectedToggle(with toggleViewModel: ToggleTableCellViewModel, isToggleOn: Bool) {
    toggleViewModel.isToggleOn = isToggleOn
    updateParamParameters(name: toggleViewModel.title, valueKey: ChartIQConst.StudyParameter.valueKey, value: isToggleOn)
    updateInputParameters(name: toggleViewModel.title, value: isToggleOn)
  }

  private func resetToDefaults() {
    view.endEditing(true)
    view.startActivityIndicator()
    resetStudyParameters()
    updateStudyViewModels()
    view.stopActivityIndicator()
  }

  private func removeStudy() {
    view.endEditing(true)
    view.startActivityIndicator()
    didRemoveStudy?(study)
    view.stopActivityIndicator()
    navigationController?.popViewController(animated: true)
  }

  private func saveStudy() {
    view.endEditing(true)
    view.startActivityIndicator()
    saveStudyParameters()
    didSaveStudy?(study)
    view.stopActivityIndicator()
    navigationController?.popViewController(animated: true)
  }

  // MARK: - Private Alert Methods

  private func presentResetDefaultsConfirmationAlert() {
    let resetTitle = locManager.localize(Const.StudyDetail.resetDefaultsAlertTitle)
    let resetMessage = locManager.localize(Const.StudyDetail.resetDefaultsAlertMessage)
    let resetAction = UIAlertAction(title: locManager.localize(Const.General.resetTitle),
                                    style: .destructive) { _ in
      self.resetToDefaults()
    }
    showAlert(title: resetTitle, message: resetMessage, actions: [resetAction])
  }

  private func presentRemoveStudyConfirmationAlert() {
    let removeTitle = locManager.localize(Const.StudyDetail.removeStudyAlertTitle)
    let removeMessage = locManager.localize(Const.StudyDetail.removeStudyAlertMessage)
    let removeAction = UIAlertAction(title: locManager.localize(Const.General.removeTitle),
                                     style: .destructive) { _ in
      self.removeStudy()
    }
    showAlert(title: removeTitle, message: removeMessage, actions: [removeAction])
  }

  // MARK: - Show Controllers Private Methods

  private func showSelectOptionsController(parameterName: String) {
    guard let controller = UIStoryboard.selectOptionViewController() else { return }
    for parameter in inputParameters {
      if parameter[ChartIQConst.StudyParameter.nameKey] as? String == parameterName,
        let options = parameter[ChartIQConst.StudyParameter.optionsKey] as? [String: String] {
        var selectedOption = ""
        if let value = parameter[ChartIQConst.StudyParameter.valueKey] {
          let stringValue = String(describing: value)
          if let option = options.first(where: { $0.key == stringValue }) {
            selectedOption = option.value
          }
        }
        controller.options = options.map { $0.value }.sorted(by: <)
        controller.selectedOption = selectedOption
        controller.didSelectOption = { [weak self] option in
            guard let self = self else { return }
            let found = options.first(where: { $0.value == option })
            self.updateInputParameters(name: parameterName, value: found?.key ?? option)
            self.updateStudyViewModels()
        }
        break
      }
    }
    view.endEditing(true)
    navigationController?.pushViewController(controller, animated: true)
  }

  // MARK: - Present Controllers Private Methods

  private func presentFullScreenPickerController(parameterName: String, parameterColor: UIColor) {
    guard let controller = UIStoryboard.fullScreenPickerViewController() else { return }
    controller.selectedPickerViewItem = PickerViewItem(selectedColor: parameterColor, selectedLine: nil)
    controller.didSelectPickerViewItem = { [weak self] item in
      guard let self = self, let selectedColor = item.selectedColor else { return }
      if self.selectedCellIndex > (self.inputParameters.count + self.outputParameters.count) {
        self.updateParamParameters(name: parameterName,
                                   valueKey: ChartIQConst.StudyParameter.colorKey,
                                   value: selectedColor.toHexString())
      } else {
        self.updateOutputParameters(name: parameterName, value: selectedColor.toHexString())
      }
      self.updateStudyViewModels()
    }
    let navigationController = NavigationController(rootViewController: controller)
    view.endEditing(true)
    present(navigationController, animated: true, completion: nil)
  }

  // MARK: - Private UITableView Helper Methods

  private func getTableCell(from viewModel: TableCellViewModelProtocol,
                            at indexPath: IndexPath) -> UITableViewCell {
    if let buttonViewModel = viewModel as? ButtonTableCellViewModel,
      let buttonCell = tableView.dequeueReusableCell(withIdentifier: Const.ButtonTableCell.cellId,
                                                     for: indexPath) as? ButtonTableCell {
      buttonCell.setupCell(withViewModel: buttonViewModel)
      return buttonCell
    }
    if (viewModel is TextTableCellViewModel) || (viewModel is NumberTableCellViewModel),
      let textCell = tableView.dequeueReusableCell(withIdentifier: Const.TextTableCell.cellId,
                                                   for: indexPath) as? TextTableCell {
      textCell.setupCell(withViewModel: viewModel)
      textCell.didTextFieldEndEditing = { [weak self] textField in
        self?.updateSelectedText(with: viewModel, from: textField)
      }
      return textCell
    }
    if (viewModel is TextColorTableCellViewModel) || (viewModel is ColorTableCellViewModel),
      let textColorCell = tableView.dequeueReusableCell(withIdentifier: Const.TextColorTableCell.cellId,
                                                        for: indexPath) as? TextColorTableCell {
      textColorCell.setupCell(withViewModel: viewModel)
      textColorCell.didTextFieldEndEditing = { [weak self] textField in
        self?.updateSelectedText(with: viewModel, from: textField)
      }
      textColorCell.didSelectColorButtonTapped = { [weak self] in
        self?.updateSelectedColor(with: viewModel, at: indexPath)
      }
      return textColorCell
    }
    if let toggleViewModel = viewModel as? ToggleTableCellViewModel,
      let toggleCell = tableView.dequeueReusableCell(withIdentifier: Const.ToggleTableCell.cellId,
                                                     for: indexPath) as? ToggleTableCell {
      toggleCell.setupCell(withViewModel: toggleViewModel)
      toggleCell.toggleDidChange = { [weak self] isToggleOn in
        self?.updateSelectedToggle(with: toggleViewModel, isToggleOn: isToggleOn)
      }
      return toggleCell
    }
    if let selectViewModel = viewModel as? SelectTableCellViewModel,
      let selectCell = tableView.dequeueReusableCell(withIdentifier: Const.SelectTableCell.cellId,
                                                     for: indexPath) as? SelectTableCell {
      selectCell.setupCell(withViewModel: selectViewModel)
      selectCell.didSelectButtonTapped = { [weak self] in
        self?.showSelectOptionsController(parameterName: selectViewModel.title)
      }
      return selectCell
    }
    return UITableViewCell()
  }
}

// MARK: - UITableViewDataSource

extension StudyDetailViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return TableSection.total.rawValue
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let tableSection = TableSection(rawValue: section) else { return 0 }
    return studyViewModels[tableSection]?.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let tableSection = TableSection(rawValue: indexPath.section),
      let studyViewModel = studyViewModels[tableSection]?[indexPath.row] else { return UITableViewCell() }
    return getTableCell(from: studyViewModel, at: indexPath)
  }
}

// MARK: - UITableViewDelegate

extension StudyDetailViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    view.endEditing(true)
    guard let tableSection = TableSection(rawValue: indexPath.section), tableSection == .second else { return }
    indexPath.row == 0 ? presentResetDefaultsConfirmationAlert() : presentRemoveStudyConfirmationAlert()
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return Const.BaseTableCell.cellHeight
  }
}

// MARK: - UIViewControllerKeyboardProtocol

extension StudyDetailViewController: UIViewControllerKeyboardProtocol {

  var scrollView: UIScrollView! {
    return tableView
  }
}
