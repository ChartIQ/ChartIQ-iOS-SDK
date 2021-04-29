//
//  SettingsViewController.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - TableCellViewModel Protocol

protocol TableCellViewModelProtocol: class {
  var title: String { get set }
}

// MARK: - Intervals ViewController

class SettingsViewController: BaseViewController {

  // MARK: - TableSection Enum

  enum TableSection: Int, CaseIterable {
    case first = 0, second, third, total
  }

  // MARK: - IBOutlets

  @IBOutlet private var tableView: UITableView!

  // MARK: - Internal Properties

  internal var chartIQView: ChartIQView!
  internal var isPresented: Bool = false
  internal var isShowChartStyle: Bool = true

  // MARK: - Private Properties

  private var cancelBarButtonItem: UIBarButtonItem?
  private var settings: [TableSection: [TableCellViewModelProtocol]] = [:]
  private var selectedChartStyle: ChartStyleModel?
  private var selectedLanguage: LanguageModel?
  private let locManager = LocalizationManager.shared()

  // MARK: - ViewController Lifecycle Methods

  override func viewDidLoad() {
    super.viewDidLoad()

    updateSettingViewModels()
  }

  override func languageDidChange() {
    navigationItem.title = locManager.localize(Const.Settings.screenTitle)
    cancelBarButtonItem?.title = locManager.localize(Const.General.cancelTitle)
    updateSettingViewModels()
  }

  // MARK: - Setup Methods

  override func setupUI() {
    navigationItem.title = locManager.localize(Const.Settings.screenTitle)
    tableView.backgroundColor = .ghostWhiteСhineseBlackColor

    if isPresented {
      cancelBarButtonItem = UIBarButtonItem(title: locManager.localize(Const.General.cancelTitle),
                                            style: .plain,
                                            target: self,
                                            action: #selector(cancelButtonTapped))
      navigationItem.leftBarButtonItem = cancelBarButtonItem
    }
  }

  override func setupSettings() {
    tableView.register(nibName: Const.DisclosureTableCell.cellNibName, cellId: Const.DisclosureTableCell.cellId)
    tableView.register(nibName: Const.ToggleTableCell.cellNibName, cellId: Const.ToggleTableCell.cellId)
    tableView.delegate = self
    tableView.dataSource = self
  }

  // MARK: - Actions Methods

  @objc private func cancelButtonTapped() {
    dismiss(animated: true, completion: nil)
  }

  // MARK: - Private Methods

  private func updateSettingViewModels() {
    selectedChartStyle = ChartStyleModel(chartType: chartIQView.chartType,
                                         chartAggregationType: chartIQView.chartAggregationType)
    selectedLanguage = locManager.currentLanguage
    let chartStyleTitle = selectedChartStyle?.displayName ?? ""
    let isLogScale = chartIQView.chartScale == .log ? true : false
    let isInvertYAxis = chartIQView.isInvertYAxis
    let isExtendHours = chartIQView.isExtendedHours
    let language = locManager.currentLanguage

    if isShowChartStyle {
      settings[.first] = [
        DisclosureTableCellViewModel(title: locManager.localize(Const.Settings.chartStyleTitle),
                                     detailTitle: locManager.localize(chartStyleTitle))
      ]
    }

    settings[.second] = [
      ToggleTableCellViewModel(title: locManager.localize(Const.Settings.logScaleTitle),
                               isToggleOn: isLogScale),
      ToggleTableCellViewModel(title: locManager.localize(Const.Settings.invertYAxisTitle),
                               isToggleOn: isInvertYAxis),
      ToggleTableCellViewModel(title: locManager.localize(Const.Settings.extendHoursTitle),
                               isToggleOn: isExtendHours)
    ]

    settings[.third] = [
      DisclosureTableCellViewModel(title: locManager.localize(Const.Settings.languageTitle),
                                   detailTitle: language.displayName)
    ]

    tableView.reloadData()
  }

  private func updateChartStyle() {
    let indexPath = IndexPath(item: 0, section: TableSection.first.rawValue)
    let visibleSection = getDynamicVisibleSection(from: indexPath.section)
    let visibleIndexPath = IndexPath(item: 0, section: visibleSection)
    guard let tableSection = TableSection(rawValue: indexPath.section),
          let disclosureCellViewModel = settings[tableSection]?[indexPath.row] as? DisclosureTableCellViewModel,
          let chartStyle = selectedChartStyle else { return }
    disclosureCellViewModel.detailTitle = locManager.localize(chartStyle.displayName)
    if let chartType = chartStyle.chartType {
      chartIQView.setChartType(chartType)
    } else if let chartAggregationType = chartStyle.chartAggregationType {
      chartIQView.setAggregationType(chartAggregationType)
    }
    tableView.reloadRows(at: [visibleIndexPath], with: .fade)
  }

  private func updateToggleCell(isToggleOn: Bool, atIndex index: Int) {
    let indexPath = IndexPath(item: index, section: TableSection.second.rawValue)
    guard let tableSection = TableSection(rawValue: indexPath.section),
      let toggleCellViewModel = settings[tableSection]?[indexPath.row] as? ToggleTableCellViewModel else { return }
    toggleCellViewModel.isToggleOn = isToggleOn
    if indexPath.row == 0 {
      chartIQView.setScale(isToggleOn ? .log : .linear)
    } else if indexPath.row == 1 {
      chartIQView.setInvertYAxis(isToggleOn)
    } else if indexPath.row == 2 {
      chartIQView.setExtendHours(isToggleOn)
    }
  }

  private func updateLanguage() {
    let indexPath = IndexPath(item: 0, section: TableSection.third.rawValue)
    let visibleSection = getDynamicVisibleSection(from: indexPath.section)
    let visibleIndexPath = IndexPath(item: 0, section: visibleSection)
    guard let tableSection = TableSection(rawValue: indexPath.section),
      let disclosureCellViewModel = settings[tableSection]?[indexPath.row] as? DisclosureTableCellViewModel,
      let language = selectedLanguage else { return }
    disclosureCellViewModel.detailTitle = language.displayName
    locManager.setLanguage(language)
    tableView.reloadRows(at: [visibleIndexPath], with: .fade)
  }

  // MARK: - Show Controllers Private Methods

  private func showChartStyleViewController() {
    guard let controller = UIStoryboard.chartStyleViewController() else { return }
    controller.selectedChartStyle = selectedChartStyle
    controller.didSelectChartStyle = { [weak self] chartStyle in
      guard let self = self else { return }
      self.selectedChartStyle = chartStyle
      self.updateChartStyle()
    }
    navigationController?.pushViewController(controller, animated: true)
  }

  private func showLanguagesViewController() {
    guard let controller = UIStoryboard.languagesViewController() else { return }
    controller.selectedLanguage = selectedLanguage
    controller.didSelectLanguage = { [weak self] language in
      guard let self = self else { return }
      self.selectedLanguage = language
      self.updateLanguage()
    }
    navigationController?.pushViewController(controller, animated: true)
  }

  // MARK: - Private UITableView Helper Methods

  private func getDynamicTableSectionsCount() -> Int {
    return isShowChartStyle ? TableSection.total.rawValue : 2
  }

  private func getDynamicTableSection(from section: Int) -> Int {
    return isShowChartStyle ? section : section + 1
  }

  private func getDynamicVisibleSection(from section: Int) -> Int {
    let currentSection = section - 1
    let safeCurrentSection = currentSection < 0 ? 0 : currentSection
    return isShowChartStyle ? section : safeCurrentSection
  }

  private func getTableCell(from settingViewModel: TableCellViewModelProtocol,
                            at indexPath: IndexPath) -> UITableViewCell {
    if let disclosureCellViewModel = settingViewModel as? DisclosureTableCellViewModel {
      guard let disclosureCell = tableView.dequeueReusableCell(withIdentifier: Const.DisclosureTableCell.cellId,
                                                               for: indexPath) as? DisclosureTableCell else {
                                                                return UITableViewCell()
      }
      disclosureCell.setupCell(withViewModel: disclosureCellViewModel)
      return disclosureCell
    }
    if let toggleCellViewModel = settingViewModel as? ToggleTableCellViewModel {
      guard let toggleCell = tableView.dequeueReusableCell(withIdentifier: Const.ToggleTableCell.cellId,
                                                           for: indexPath) as? ToggleTableCell else {
                                                            return UITableViewCell()
      }
      toggleCell.setupCell(withViewModel: toggleCellViewModel)
      toggleCell.toggleDidChange = { [weak self] isToogleOn in
        self?.updateToggleCell(isToggleOn: isToogleOn, atIndex: indexPath.row)
      }
      return toggleCell
    }
    return UITableViewCell()
  }
}

// MARK: - UITableViewDataSource

extension SettingsViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return getDynamicTableSectionsCount()
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let dynamicSection = getDynamicTableSection(from: section)
    guard let tableSection = TableSection(rawValue: dynamicSection) else { return 0 }
    return settings[tableSection]?.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let dynamicSection = getDynamicTableSection(from: indexPath.section)
    guard let tableSection = TableSection(rawValue: dynamicSection),
      let settingViewModel = settings[tableSection]?[indexPath.row] else { return UITableViewCell() }
    return getTableCell(from: settingViewModel, at: indexPath)
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    let dynamicSection = getDynamicTableSection(from: section)
    guard let tableSection = TableSection(rawValue: dynamicSection) else { return nil }
    switch tableSection {
    case .first:
      return locManager.localize(Const.Settings.chartConfigHeaderTitle)
    case .second:
      return locManager.localize(Const.Settings.chartPreferencesHeaderTitle)
    case .third:
      return locManager.localize(Const.Settings.languagePreferencesHeaderTitle)
    default:
      return nil
    }
  }
}

// MARK: - UITableViewDelegate

extension SettingsViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let dynamicSection = getDynamicTableSection(from: indexPath.section)
    guard let tableSection = TableSection(rawValue: dynamicSection) else { return }
    if tableSection == .first {
      showChartStyleViewController()
    } else if tableSection == .third {
      showLanguagesViewController()
    }
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return Const.BaseTableCell.cellHeight
  }
}
