//
//  SignalDetailViewController.swift
//  ChartIQDemo
//
//  Copyright 2012-2022 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - SignalDetail ViewController

class SignalDetailViewController: BaseViewController {

  // MARK: - SignalDetailType Enum

  enum SignalDetailType {
    case createSignal
    case editSignal

    var screenTitle: String {
      switch self {
      case .createSignal:
        return Const.SignalDetail.createSignalScreenTitle
      case .editSignal:
        return Const.SignalDetail.editSignalScreenTitle
      }
    }
  }

  // MARK: - TableSection Enum

  enum TableSection: Int, CaseIterable {
    case first = 0, second, third
  }

  // MARK: - IBOutlets

  @IBOutlet private var tableView: UITableView!

  // MARK: - Internal Properties

  internal var signalDetailType: SignalDetailType!
  internal var chartIQView: ChartIQView!
  internal var signal: ChartIQSignal?
  internal var didSaveSignal: ((ChartIQSignal, Bool) -> Void)?

  // MARK: - Private Properties

  private var cancelBarButtonItem: UIBarButtonItem?
  private var saveBarButtonItem: UIBarButtonItem?
  private var signalViewModels: [TableSection: [TableCellViewModelProtocol]] = [:]
  private let locManager = LocalizationManager.shared()

  private var study: ChartIQStudy?
  private var conditions: [ConditionViewModel] = []
  private var signalName: String?
  private var signalDescription: String?
  private var joinerType: ChartIQSignalJoiner = .or
  private var isSaving: Bool = false

  // MARK: - ViewController Lifecycle Methods

  override func viewDidLoad() {
    super.viewDidLoad()

    setupSignal()
    updateSignalViewModels()
  }

  override func languageDidChange() {
    navigationItem.title = locManager.localize(signalDetailType.screenTitle)
    cancelBarButtonItem?.title = locManager.localize(Const.General.cancelTitle)
    saveBarButtonItem?.title = locManager.localize(Const.General.saveTitle)
    updateSignalViewModels()
  }

  deinit {
    removeStudy()
  }

  // MARK: - Setup Methods

  override func setupUI() {
    navigationItem.title = locManager.localize(signalDetailType.screenTitle)
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
    tableView.register(nibName: Const.ButtonTableCell.cellNibName, cellId: Const.ButtonTableCell.cellId)
    tableView.register(nibName: Const.DisclosureTableCell.cellNibName, cellId: Const.DisclosureTableCell.cellId)
    tableView.register(nibName: Const.TextViewTableCell.cellNibName, cellId: Const.TextViewTableCell.cellId)
    tableView.register(nibName: Const.TextTableCell.cellNibName, cellId: Const.TextTableCell.cellId)
    tableView.register(nibName: Const.ConditionTableCell.cellNibName, cellId: Const.ConditionTableCell.cellId)

    tableView.delegate = self
    tableView.dataSource = self

    addKeyboardObservers()
    validateAll()
  }

  // MARK: - Actions Methods

  @objc private func cancelButtonTapped() {
    removeStudy()
    closeScreen()
  }

  @objc private func saveButtonTapped() {
    saveSignal()
  }

  // MARK: - Private Methods

  private func setupSignal() {
    guard let signal = signal else { return }
    study = signal.study
    conditions = signal.conditions.map({
      var secondIndicatorName = $0.rightIndicator
      var secondIndicatorValue: Double?
      if let value = Double($0.rightIndicator) {
        secondIndicatorName = Const.SignalCondition.valueField
        secondIndicatorValue = value
      }
      return ConditionViewModel(firstIndicatorName: $0.leftIndicator,
                                conditionOperator: $0.operator,
                                secondIndicatorName: secondIndicatorName,
                                secondIndicatorValue: secondIndicatorValue,
                                markerOptions: $0.markerOptions,
                                studyParameters: signal.study.nameParams)
    })
    signalName = signal.name
    signalDescription = signal.signalDescription
    joinerType = signal.joiner
  }

  private func updateSignalViewModels() {
    var studiesViewModels: [TableCellViewModelProtocol] = []
    var conditionsViewModels: [TableCellViewModelProtocol] = []
    var descriptionViewModels: [TableCellViewModelProtocol] = []
    if let study = study {
      let studyName = study.name.isEmpty ? study.shortName : study.name
      studiesViewModels = [
        DisclosureTableCellViewModel(title: locManager.localize(studyName))
      ]
      if signalDetailType == .createSignal {
        studiesViewModels.append(ButtonTableCellViewModel(title: locManager.localize(Const.SignalDetail.changeStudyTitle),
                                                          titleColor: .mountainMeadowColor))
      }
      for (index, condition) in conditions.enumerated() {
        let conditionNumber = index + 1
        let conditionTitle = "\(conditionNumber) \(locManager.localize(Const.SignalDetail.conditionTitle))"
        let conditionOperator = condition.conditionOperator?.displayName ?? ""
        var secondIndicator = ""
        if let secondIndicatorName = condition.secondIndicatorShortName,
           secondIndicatorName != Const.SignalCondition.valueField {
          secondIndicator = secondIndicatorName
        } else if let secondIndicatorValue = condition.secondIndicatorValue {
          secondIndicator = String(secondIndicatorValue)
        }
        let conditionDescription = "\(condition.firstIndicatorShortName) \(conditionOperator) \(secondIndicator)"
        var segmentType: ConditionSegmentType = .one
        if index == 0 {
          segmentType = .both
        } else if index == (conditions.count - 1) {
          segmentType = .none
        }
        let conditionViewModel = ConditionTableCellViewModel(title: conditionTitle,
                                                             description: conditionDescription,
                                                             tagMark: condition.markerOptions?.label ?? "",
                                                             color: condition.markerOptions?.color ?? .clear,
                                                             segmentType: segmentType,
                                                             joinerType: joinerType)
        conditionsViewModels.append(conditionViewModel)
      }
      let addCondition = ButtonTableCellViewModel(title: locManager.localize(Const.SignalDetail.addCondtionTitle),
                                                  titleColor: .mountainMeadowColor)
      conditionsViewModels.append(addCondition)
    } else {
      studiesViewModels = [
        ButtonTableCellViewModel(title: locManager.localize(Const.SignalDetail.selectStudyTitle),
                                 titleColor: .mountainMeadowColor)
      ]
    }
    descriptionViewModels = [
      TextViewTableCellViewModel(title: locManager.localize(Const.SignalDetail.descriptionTitle),
                                 text: signalDescription,
                                 placeholder: locManager.localize(Const.SignalDetail.descriptionPlaceholder)),
      TextTableCellViewModel(title: locManager.localize(Const.SignalDetail.nameTitle),
                             text: signalName,
                             placeholder: locManager.localize(Const.SignalDetail.namePlaceholder))
    ]
    signalViewModels = [
      .first: studiesViewModels,
      .second: conditionsViewModels,
      .third: descriptionViewModels
    ]
    tableView.reloadData()
    validateAll()
    view.stopActivityIndicator()
  }

  private func addCondition(condition: ConditionViewModel) {
    view.startActivityIndicator()
    conditions.append(condition)
    updateSignalViewModels()
  }

  private func updateCondition(condition: ConditionViewModel) {
    view.startActivityIndicator()
    guard let conditionIndex = conditions.firstIndex(where: { $0.id == condition.id }) else {
      view.stopActivityIndicator()
      return
    }
    conditions.replace(object: condition, atIndex: conditionIndex)
    updateSignalViewModels()
  }

  private func removeCondition(at indexPath: IndexPath) {
    view.startActivityIndicator()
    guard let tableSection = TableSection(rawValue: indexPath.section) else { return }
    signalViewModels[tableSection]?.remove(at: indexPath.row)
    conditions.remove(at: indexPath.row)
    tableView.deleteRows(at: [indexPath], with: .fade)
    updateSignalViewModels()
  }

  private func saveSignal() {
    view.endEditing(true)
    guard let signal = prepareSignal() else { return }
    view.startActivityIndicator()
    let isEdit = signalDetailType == .editSignal
    didSaveSignal?(signal, isEdit)
    view.stopActivityIndicator()
    isSaving = true
    closeScreen()
  }

  private func prepareSignal() -> ChartIQSignal? {
    guard let signalStudy = study,
          let signalName = signalName else { return nil }
    let signalConditions = prepareSignalConditions()
    return ChartIQSignal(study: signalStudy,
                         conditions: signalConditions,
                         joiner: joinerType,
                         name: signalName,
                         signalDescription: signalDescription)
  }

  private func prepareSignalConditions() -> [ChartIQCondition] {
    let signalConditions: [ChartIQCondition] = conditions.map { viewModel in
      var rightIndicator: String = ""
      if let secondIndicatorName = viewModel.secondIndicatorName,
         secondIndicatorName != Const.SignalCondition.valueField {
        rightIndicator = secondIndicatorName
      } else if let secondIndicatorValue = viewModel.secondIndicatorValue {
        rightIndicator = "\(secondIndicatorValue)"
      }
      return ChartIQCondition(leftIndicator: viewModel.firstIndicatorName,
                              operator: viewModel.conditionOperator ?? .crosses,
                              rightIndicator: rightIndicator,
                              markerOptions: viewModel.markerOptions)
    }
    return signalConditions
  }

  private func updateStudy(newStudy: ChartIQStudy) {
    view.startActivityIndicator()
    if let oldStudy = study {
      chartIQView.removeStudy(oldStudy)
      conditions.removeAll()
    }
    guard let signalStudy = chartIQView.addSignalStudy(newStudy) else {
      view.stopActivityIndicator()
      return
    }
    study = signalStudy
    updateSignalViewModels()
  }

  private func updateStudyParameters(study: ChartIQStudy) {
    view.startActivityIndicator()
    var parameters = [String: String]()
    study.inputs?.forEach({ input in
      parameters[input.key] = String(describing: input.value)
    })
    study.outputs?.forEach({ output in
      parameters[output.key] = String(describing: output.value)
    })
    study.parameters?.forEach({ param in
      parameters[param.key] = String(describing: param.value)
    })
    // TODO: Bottleneck - changes Study name and we can't know the new name of Study.
    debugPrint("BUG: setStudyParameters")
    chartIQView.setStudyParameters(study, parameters: parameters)
    // TODO: Remove comments after fix.
    updateSignalViewModels()
  }

  private func removeStudy() {
    guard signalDetailType == .createSignal, let studyToRemove = study, !isSaving else { return }
    chartIQView.removeStudy(studyToRemove)
    study = nil
    isSaving = false
  }

  private func validateAll() {
    let isAllFieldsValid = study != nil && !conditions.isEmpty && !(signalName ?? "").isEmpty
    saveBarButtonItem?.isEnabled = isAllFieldsValid
  }

  // MARK: - Show Controllers Private Methods

  private func showStudyDetailViewController(with study: ChartIQStudy) {
    guard let controller = UIStoryboard.studyDetailViewController() else { return }
    controller.isAdditionalActionsAllowed = false
    controller.study = study
    // TODO: Bottleneck - returns nil after study updated and changed their name.
    debugPrint("BUG: getStudyParameters")
    let input = chartIQView.getStudyParameters(study, type: .inputs)
    let output = chartIQView.getStudyParameters(study, type: .outputs)
    let parameters = chartIQView.getStudyParameters(study, type: .parameters)
    // TODO: Remove comments after fix.
    controller.inputParameters = input as? [[String: Any]] ?? [[:]]
    controller.outputParameters = output as? [[String: Any]] ?? [[:]]
    controller.paramParameters = parameters as? [[String: Any]] ?? [[:]]
    controller.didSaveStudy = { [weak self] study in
      self?.updateStudyParameters(study: study)
    }
    navigationController?.show(controller, sender: nil)
  }

  private func showSignalConditionViewController(condition: ConditionViewModel, isAppearanceSettingsHidden: Bool) {
    guard let controller = UIStoryboard.signalConditionViewController() else { return }
    controller.study = study
    controller.condition = condition
    controller.isAppearanceSettingsHidden = isAppearanceSettingsHidden
    controller.didSaveConditon = { [weak self] condition in
      self?.updateCondition(condition: condition)
    }
    navigationController?.show(controller, sender: nil)
  }

  // MARK: - Present Controllers Private Methods

  private func presentAllStudiesViewController() {
    guard let controller = UIStoryboard.allStudiesViewController() else { return }
    controller.isMultipleSelectionAllowed = false
    controller.allStudies = chartIQView.getAllStudies()
    controller.didAddStudies = { [weak self] studies in
      guard let self = self, let study = studies.first else { return }
      self.updateStudy(newStudy: study)
    }
    let navigationController = NavigationController(rootViewController: controller)
    present(navigationController, animated: true, completion: nil)
  }

  private func presentSignalConditionViewController(isAppearanceSettingsHidden: Bool) {
    guard let controller = UIStoryboard.signalConditionViewController() else { return }
    controller.study = study
    controller.isAppearanceSettingsHidden = isAppearanceSettingsHidden
    controller.didSaveConditon = { [weak self] condition in
      self?.addCondition(condition: condition)
    }
    let navigationController = NavigationController(rootViewController: controller)
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
    } else if let disclosureViewModel = viewModel as? DisclosureTableCellViewModel,
              let disclosureCell = tableView.dequeueReusableCell(withIdentifier: Const.DisclosureTableCell.cellId,
                                                                 for: indexPath) as? DisclosureTableCell {
      disclosureCell.setupCell(withViewModel: disclosureViewModel)
      return disclosureCell
    } else if let conditionViewModel = viewModel as? ConditionTableCellViewModel,
              let conditionCell = tableView.dequeueReusableCell(withIdentifier: Const.ConditionTableCell.cellId,
                                                                for: indexPath) as? ConditionTableCell {
      conditionCell.setupCell(withViewModel: conditionViewModel)
      conditionCell.didSegmentedControlValueChanged = { [weak self] segmentType in
        self?.joinerType = segmentType
        self?.updateSignalViewModels()
      }
      return conditionCell
    } else if let textViewViewModel = viewModel as? TextViewTableCellViewModel,
              let textViewCell = tableView.dequeueReusableCell(withIdentifier: Const.TextViewTableCell.cellId,
                                                               for: indexPath) as? TextViewTableCell {
      textViewCell.setupCell(withViewModel: textViewViewModel)
      textViewCell.didTextViewBeginEditing = { [weak self] _ in
        self?.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
      }
      textViewCell.didTextViewEndEditing = { [weak self] text in
        self?.signalDescription = text
      }
      return textViewCell
    } else if let textViewModel = viewModel as? TextTableCellViewModel,
              let textCell = tableView.dequeueReusableCell(withIdentifier: Const.TextTableCell.cellId,
                                                           for: indexPath) as? TextTableCell {
      textCell.setupCell(withViewModel: textViewModel)
      textCell.didTextFieldEndEditing = { [weak self] textField in
        self?.signalName = textField.text
        self?.validateAll()
      }
      return textCell
    }
    return UITableViewCell()
  }

  private func getDeleteTableAction(at indexPath: IndexPath) -> UITableViewRowAction {
    let deleteActionTitle = locManager.localize(Const.General.deleteTitle)
    let deleteAction = UITableViewRowAction(style: .destructive,
                                            title: deleteActionTitle) { [weak self] _, indexPath in
      self?.removeCondition(at: indexPath)
    }
    deleteAction.backgroundColor = .coralRedColor
    return deleteAction
  }
}

// MARK: - UITableViewDataSource

extension SignalDetailViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return signalViewModels.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let tableSection = TableSection(rawValue: section) else { return 0 }
    return signalViewModels[tableSection]?.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let tableSection = TableSection(rawValue: indexPath.section),
          let studyViewModel = signalViewModels[tableSection]?[indexPath.row] else { return UITableViewCell() }
    return getTableCell(from: studyViewModel, at: indexPath)
  }
}

// MARK: - UITableViewDelegate

extension SignalDetailViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    view.endEditing(true)
    guard let tableSection = TableSection(rawValue: indexPath.section),
          let viewModel = signalViewModels[tableSection]?[indexPath.row] else { return }
    switch tableSection {
    case .first:
      if viewModel is DisclosureTableCellViewModel, let study = study {
        showStudyDetailViewController(with: study)
      } else if viewModel is ButtonTableCellViewModel {
        presentAllStudiesViewController()
      }
    case .second:
      if let conditionViewModel = viewModel as? ConditionTableCellViewModel {
        var condition = conditions[indexPath.row]
        condition.conditionName = viewModel.title
        var isAppearanceSettingsHidden = conditionViewModel.joinerType == .and
        if conditionViewModel.segmentType == .both {
          isAppearanceSettingsHidden = false
        }
        showSignalConditionViewController(condition: condition,
                                          isAppearanceSettingsHidden: isAppearanceSettingsHidden)
      } else if viewModel is ButtonTableCellViewModel {
        presentSignalConditionViewController(isAppearanceSettingsHidden: joinerType == .and)
      }
    default:
      break
    }
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    guard let tableSection = TableSection(rawValue: indexPath.section),
          let viewModel = signalViewModels[tableSection]?[indexPath.row] else { return .leastNonzeroMagnitude }
    if viewModel is TextViewTableCellViewModel {
      return Const.TextViewTableCell.cellHeight
    } else if let conditionViewModel = viewModel as? ConditionTableCellViewModel {
      if conditionViewModel.segmentType == .none {
        return Const.ConditionTableCell.cellHeight
      } else {
        return Const.ConditionTableCell.extendedCellHeight
      }
    }
    return Const.BaseTableCell.cellHeight
  }

  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    guard let tableSection = TableSection(rawValue: section),
          let viewModels = signalViewModels[tableSection], !viewModels.isEmpty else {
      return CGFloat.leastNonzeroMagnitude
    }
    return Const.BaseTableCell.headerHeight
  }

  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return CGFloat.leastNonzeroMagnitude
  }

  func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
    guard let tableSection = TableSection(rawValue: editActionsForRowAt.section),
          let viewModel = signalViewModels[tableSection]?[editActionsForRowAt.row],
          tableSection == .second, viewModel is ConditionTableCellViewModel else { return nil }
    let deleteTableAction = getDeleteTableAction(at: editActionsForRowAt)
    return [deleteTableAction]
  }
}

// MARK: - UIViewControllerKeyboardProtocol

extension SignalDetailViewController: UIViewControllerKeyboardProtocol {

  var scrollView: UIScrollView! {
    return tableView
  }
}
