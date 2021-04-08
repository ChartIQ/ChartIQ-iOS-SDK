//
//  FibSettingsViewController.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - FibSettings ViewController

class FibSettingsViewController: BaseViewController {

  // MARK: - TableSection Enum

  enum TableSection: Int, CaseIterable {
    case first = 0, second, total
  }

  // MARK: - IBOutlets

  @IBOutlet private var tableView: UITableView!

  // MARK: - Internal Properties

  internal var selectedDrawTool: DrawToolViewModel?
  internal var fibSettings: [[String: Any]] = []
  internal var didSaveFibSettings: (([[String: Any]]) -> Void)?

  // MARK: - Private Properties

  private var saveBarButtonItem: UIBarButtonItem?
  private let locManager = LocalizationManager.shared()
  private var fibSettingsViewModels: [TableSection: [TableCellViewModelProtocol]] = [:]
  private var isAllowNegative: Bool = true

  // MARK: - ViewController Lifecycle Methods

  override func viewDidLoad() {
    super.viewDidLoad()

    prepareFibSettings()
    updateFibSettingsViewModels()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    tableView.scrollToRow(at: IndexPath(row: 0, section: 1), at: .bottom, animated: true)
  }

  override func languageDidChange() {
    navigationItem.title = locManager.localize(Const.FibSettingsViewController.screenTitle)
    saveBarButtonItem?.title = locManager.localize(Const.General.saveTitle)
  }

  // MARK: - Setup Methods

  override func setupUI() {
    navigationItem.title = locManager.localize(Const.FibSettingsViewController.screenTitle)
    tableView.backgroundColor = .ghostWhiteСhineseBlackColor
    saveBarButtonItem = UIBarButtonItem(title: locManager.localize(Const.General.saveTitle),
                                        style: .done,
                                        target: self,
                                        action: #selector(saveButtonTapped))
    navigationItem.rightBarButtonItem = saveBarButtonItem
  }

  override func setupSettings() {
    tableView.register(nibName: Const.BaseTableCell.cellNibName, cellId: Const.BaseTableCell.cellId)
    tableView.register(nibName: Const.FibInputTableCell.cellNibName, cellId: Const.FibInputTableCell.cellId)
    tableView.delegate = self
    tableView.dataSource = self

    addKeyboardObservers()
  }

  // MARK: - Actions Methods

  @objc private func saveButtonTapped() {
    saveParameters()
  }

  // MARK: - Private Methods

  private func prepareFibSettings() {
    guard selectedDrawTool?.drawingTool == .fibArc else { return }
    fibSettings = fibSettings.filter({ ($0[ChartIQConst.DrawingParameter.levelKey] as? Double ?? -1) >= 0 })
    isAllowNegative = false
  }

  private func updateFibSettingsViewModels() {
    var baseViewModels: [TableCellViewModelProtocol] = []
    for fibSetting in fibSettings {
      if let levelDouble = fibSetting[ChartIQConst.DrawingParameter.levelKey] as? Double {
        let levelTitle = String(levelDouble) + "\(Const.General.perCentSymbol)"
        let baseViewModel = BaseTableCellViewModel(title: levelTitle)
        baseViewModels.append(baseViewModel)
      }
    }
    fibSettingsViewModels = [
      .first: baseViewModels,
      .second: [
        FibInputTableCellViewModel(title: "",
                                   placeholder: Const.FibSettingsViewController.fibInputPlaceholderTitle,
                                   buttonTitle: Const.FibSettingsViewController.fibInputAddButtonTitle,
                                   isAllowNegative: isAllowNegative)
      ]
    ]
    tableView.reloadData()
    tableView.scrollToRow(at: IndexPath(row: 0, section: 1), at: .bottom, animated: true)
  }

  private func updateParameter(display: Bool, at indexPath: IndexPath) {
    var fibSetting = fibSettings[indexPath.row]
    fibSetting[ChartIQConst.DrawingParameter.displayKey] = display
    fibSettings.replace(object: fibSetting, atIndex: indexPath.row)
  }

  private func addNewParameter(level: String) {
    var fibSetting: [String: Any] = [:]
    fibSetting[ChartIQConst.DrawingParameter.levelKey] = Double(level)
    fibSetting[ChartIQConst.DrawingParameter.displayKey] = true
    fibSettings.append(fibSetting)
  }

  private func saveParameters() {
    view.endEditing(true)
    view.startActivityIndicator()
    didSaveFibSettings?(fibSettings)
    view.stopActivityIndicator()
    navigationController?.popViewController(animated: true)
  }

  private func getFibParamterSelectedStatus(at indexPath: IndexPath) -> Bool {
    let fibSetting = fibSettings[indexPath.row]
    var isFibSelected = false
    if let isSelected = fibSetting[ChartIQConst.DrawingParameter.displayKey] as? Bool {
      isFibSelected = isSelected
    }
    return isFibSelected
  }

  // MARK: - Private UITableView Helper Methods

  private func getTableCell(from viewModel: TableCellViewModelProtocol,
                            at indexPath: IndexPath) -> UITableViewCell {
    if let baseViewModel = viewModel as? BaseTableCellViewModel,
       let baseCell = tableView.dequeueReusableCell(withIdentifier: Const.BaseTableCell.cellId,
                                                    for: indexPath) as? BaseTableCell {
      baseCell.setupCell(withViewModel: baseViewModel)
      return baseCell
    }
    if let fibInputViewModel = viewModel as? FibInputTableCellViewModel,
       let fibInputCell = tableView.dequeueReusableCell(withIdentifier: Const.FibInputTableCell.cellId,
                                                        for: indexPath) as? FibInputTableCell {
      fibInputCell.setupCell(withViewModel: fibInputViewModel)
      fibInputCell.didSelectAddButtonTapped = { [weak self] enteredText in
        guard let self = self else { return }
        self.addNewParameter(level: enteredText)
        self.updateFibSettingsViewModels()
      }
      return fibInputCell
    }
    return UITableViewCell()
  }
}

// MARK: - UITableViewDataSource

extension FibSettingsViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return TableSection.total.rawValue
  }

  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard let tableSection = TableSection(rawValue: indexPath.section), tableSection == .first else { return }
    let isFibSelected = getFibParamterSelectedStatus(at: indexPath)
    if isFibSelected {
      tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
    } else {
      tableView.deselectRow(at: indexPath, animated: false)
    }
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let tableSection = TableSection(rawValue: section) else { return 0 }
    return fibSettingsViewModels[tableSection]?.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let tableSection = TableSection(rawValue: indexPath.section),
          let studyViewModel = fibSettingsViewModels[tableSection]?[indexPath.row] else { return UITableViewCell() }
    return getTableCell(from: studyViewModel, at: indexPath)
  }
}

// MARK: - UITableViewDelegate

extension FibSettingsViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let tableSection = TableSection(rawValue: indexPath.section), tableSection == .first else { return }
    view.endEditing(true)
    if let cell = tableView.cellForRow(at: indexPath) { cell.accessoryType = .checkmark }
    updateParameter(display: true, at: indexPath)
  }

  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    guard let tableSection = TableSection(rawValue: indexPath.section), tableSection == .first else { return }
    view.endEditing(true)
    if let cell = tableView.cellForRow(at: indexPath) { cell.accessoryType = .none }
    updateParameter(display: false, at: indexPath)
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return Const.BaseTableCell.cellHeight
  }
}

// MARK: - UIViewControllerKeyboardProtocol

extension FibSettingsViewController: UIViewControllerKeyboardProtocol {

  var scrollView: UIScrollView! {
    return tableView
  }
}
