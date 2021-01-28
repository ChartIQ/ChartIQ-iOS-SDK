//
//  DeviationsViewController.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - Deviations ViewController

class DeviationsViewController: BaseViewController {

  // MARK: - TableSection Enum

  enum TableSection: Int, CaseIterable {
    case first = 0, second, third, total
  }

  // MARK: - IBOutlets

  @IBOutlet private var tableView: UITableView!

  // MARK: - Internal Properties

  internal var chartIQView: ChartIQView?
  internal var deviationModels: [DeviationModel] = []
  internal var didSaveFibSettings: (([[String: Any]]) -> Void)?

  // MARK: - Private Properties

  private let locManager = LocalizationManager.shared()
  private var deviationViewModels: [TableSection: [TableCellViewModelProtocol]] = [:]

  // MARK: - ViewController Lifecycle Methods

  override func viewDidLoad() {
    super.viewDidLoad()

    updateFibSettingsViewModels()
  }

  override func languageDidChange() {
    navigationItem.title = locManager.localize(Const.DeviationsViewController.screenTitle)
  }

  // MARK: - Setup Methods

  override func setupUI() {
    navigationItem.title = locManager.localize(Const.DeviationsViewController.screenTitle)
    tableView.backgroundColor = .ghostWhiteСhineseBlackColor
  }

  override func setupSettings() {
    tableView.register(nibName: Const.TextColorTableCell.cellNibName, cellId: Const.TextColorTableCell.cellId)
    tableView.register(nibName: Const.ToggleTableCell.cellNibName, cellId: Const.ToggleTableCell.cellId)
    tableView.register(nibName: Const.LineTableCell.cellNibName, cellId: Const.LineTableCell.cellId)
    tableView.delegate = self
    tableView.dataSource = self
  }

  // MARK: - Private Methods

  private func updateFibSettingsViewModels() {
    var firstDeviationViewModels: [TableCellViewModelProtocol] = []
    var secondDeviationViewModels: [TableCellViewModelProtocol] = []
    var thirdDeviationViewModels: [TableCellViewModelProtocol] = []

    for deviationModel in deviationModels {
      if deviationModel.lineLevel == .first {
        let lineSelectedViewModel = ToggleTableCellViewModel(title: Const.DrawToolsService.showLine1Title,
                                                             isToggleOn: deviationModel.isLineSelected)
        let lineColorViewModel = ColorTableCellViewModel(title: Const.DrawToolsService.line1ColorTitle,
                                                         color: deviationModel.lineColor)
        let lineViewModel = LineTableCellViewModel(title: Const.DrawToolsService.line1TypeTitle,
                                                   lineModel: deviationModel.lineModel)
        firstDeviationViewModels = [lineSelectedViewModel, lineColorViewModel, lineViewModel]
      } else if deviationModel.lineLevel == .second {
        let lineSelectedViewModel = ToggleTableCellViewModel(title: Const.DrawToolsService.showLine2Title,
                                                             isToggleOn: deviationModel.isLineSelected)
        let lineColorViewModel = ColorTableCellViewModel(title: Const.DrawToolsService.line2ColorTitle,
                                                         color: deviationModel.lineColor)
        let lineViewModel = LineTableCellViewModel(title: Const.DrawToolsService.line2TypeTitle,
                                                   lineModel: deviationModel.lineModel)
        secondDeviationViewModels = [lineSelectedViewModel, lineColorViewModel, lineViewModel]
      } else if deviationModel.lineLevel == .third {
        let lineSelectedViewModel = ToggleTableCellViewModel(title: Const.DrawToolsService.showLine3Title,
                                                             isToggleOn: deviationModel.isLineSelected)
        let lineColorViewModel = ColorTableCellViewModel(title: Const.DrawToolsService.line3ColorTitle,
                                                         color: deviationModel.lineColor)
        let lineViewModel = LineTableCellViewModel(title: Const.DrawToolsService.line3TypeTitle,
                                                   lineModel: deviationModel.lineModel)
        thirdDeviationViewModels = [lineSelectedViewModel, lineColorViewModel, lineViewModel]
      }
    }

    deviationViewModels = [
      .first: firstDeviationViewModels,
      .second: secondDeviationViewModels,
      .third: thirdDeviationViewModels
    ]
    tableView.reloadData()
  }

  // MARK: - Private Update Parameter Methods

  private func updateSelectedItem(with viewModel: TableCellViewModelProtocol,
                                  at indexPath: IndexPath) {
    if let colorViewModel = viewModel as? ColorTableCellViewModel {
      let colorPickerViewItem = PickerViewItem(selectedColor: colorViewModel.color, selectedLine: nil)
      presentFullScreenPickerController(with: .color, pickerViewItem: colorPickerViewItem, at: indexPath)
    } else if let lineViewModel = viewModel as? LineTableCellViewModel {
      let linePickerViewItem = PickerViewItem(selectedColor: nil, selectedLine: lineViewModel.lineModel)
      presentFullScreenPickerController(with: .line, pickerViewItem: linePickerViewItem, at: indexPath)
    }
  }

  // MARK: - Private Update Drawing Parameter Methods

  private func updateSelectedToggle(with toggleViewModel: ToggleTableCellViewModel,
                                    isToggleOn: Bool,
                                    at indexPath: IndexPath) {
    guard let tableSection = TableSection(rawValue: indexPath.section) else { return }
    var showLinesKey = ChartIQDrawingParameterType.active1
    switch tableSection {
    case .first:
      showLinesKey = .active1
    case .second:
      showLinesKey = .active2
    case .third:
      showLinesKey = .active3
    case .total:
      break
    }
    toggleViewModel.isToggleOn = isToggleOn
    chartIQView?.setDrawingParameter(showLinesKey, value: isToggleOn)
  }

  private func updateSelectedColorParameters(selectedColor: UIColor,
                                             colorViewModel: ColorTableCellViewModel,
                                             at indexPath: IndexPath) {
    guard let tableSection = TableSection(rawValue: indexPath.section) else { return }
    var colorKey = ChartIQDrawingParameterType.color1
    switch tableSection {
    case .first:
      colorKey = .color1
    case .second:
      colorKey = .color2
    case .third:
      colorKey = .color3
    case .total:
      break
    }
    colorViewModel.color = selectedColor
    let colorHexString = selectedColor.toHexString()
    chartIQView?.setDrawingParameter(colorKey, value: colorHexString)
    tableView.reloadData()
  }

  private func updateSelectedLineParameters(selectedLine: LineModel,
                                            lineViewModel: LineTableCellViewModel,
                                            at indexPath: IndexPath) {
    guard let tableSection = TableSection(rawValue: indexPath.section) else { return }
    var lineWidthKey = ChartIQDrawingParameterType.lineWidth1, patternKey = ChartIQDrawingParameterType.pattern1
    switch tableSection {
    case .first:
      lineWidthKey = .lineWidth1
      patternKey = .pattern1
    case .second:
      lineWidthKey = .lineWidth2
      patternKey = .pattern2
    case .third:
      lineWidthKey = .lineWidth3
      patternKey = .pattern3
    case .total:
      break
    }
    lineViewModel.lineModel = selectedLine
    chartIQView?.setDrawingParameter(patternKey, value: selectedLine.lineType.stringValue)
    chartIQView?.setDrawingParameter(lineWidthKey, value: selectedLine.lineWidth)
    tableView.reloadData()
  }

  // MARK: - Present Controllers Private Methods

  private func presentFullScreenPickerController(with pickerType: FullScreenPickerType,
                                                 pickerViewItem: PickerViewItem,
                                                 at indexPath: IndexPath) {
    guard let controller = UIStoryboard.fullScreenPickerViewController() else { return }
    controller.selectedPickerViewItem = pickerViewItem
    controller.pickerType = pickerType
    controller.didSelectPickerViewItem = { [weak self] item in
      guard let self = self else { return }
      guard let tableSection = TableSection(rawValue: indexPath.section),
            let deviationViewModel = self.deviationViewModels[tableSection]?[indexPath.row] else { return }
      if let selectedColor = item.selectedColor, let colorViewModel = deviationViewModel as? ColorTableCellViewModel {
        self.updateSelectedColorParameters(selectedColor: selectedColor, colorViewModel: colorViewModel, at: indexPath)
      } else if let selectedLine = item.selectedLine,
                let lineViewModel = deviationViewModel as? LineTableCellViewModel {
        self.updateSelectedLineParameters(selectedLine: selectedLine, lineViewModel: lineViewModel, at: indexPath)
      }
    }
    let navigationController = NavigationController(rootViewController: controller)
    present(navigationController, animated: true, completion: nil)
  }

  // MARK: - Private UITableView Helper Methods

  private func getTableCell(from viewModel: TableCellViewModelProtocol,
                            at indexPath: IndexPath) -> UITableViewCell {
    if let colorViewModel = viewModel as? ColorTableCellViewModel,
       let textColorCell = tableView.dequeueReusableCell(withIdentifier: Const.TextColorTableCell.cellId,
                                                         for: indexPath) as? TextColorTableCell {
      textColorCell.setupCell(withViewModel: colorViewModel)
      textColorCell.didSelectColorButtonTapped = { [weak self] in
        self?.updateSelectedItem(with: colorViewModel, at: indexPath)
      }
      return textColorCell
    }
    if let lineViewModel = viewModel as? LineTableCellViewModel,
       let lineCell = tableView.dequeueReusableCell(withIdentifier: Const.LineTableCell.cellId,
                                                    for: indexPath) as? LineTableCell {
      lineCell.setupCell(withViewModel: lineViewModel)
      lineCell.didSelectLineButtonTapped = { [weak self] in
        self?.updateSelectedItem(with: lineViewModel, at: indexPath)
      }
      return lineCell
    }
    if let toggleViewModel = viewModel as? ToggleTableCellViewModel,
       let toggleCell = tableView.dequeueReusableCell(withIdentifier: Const.ToggleTableCell.cellId,
                                                      for: indexPath) as? ToggleTableCell {
      toggleCell.setupCell(withViewModel: toggleViewModel)
      toggleCell.toggleDidChange = { [weak self] isToggleOn in
        self?.updateSelectedToggle(with: toggleViewModel, isToggleOn: isToggleOn, at: indexPath)
      }
      return toggleCell
    }
    return UITableViewCell()
  }
}

// MARK: - UITableViewDataSource

extension DeviationsViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return TableSection.total.rawValue
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let tableSection = TableSection(rawValue: section) else { return 0 }
    return deviationViewModels[tableSection]?.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let tableSection = TableSection(rawValue: indexPath.section),
          let deviationViewModel = deviationViewModels[tableSection]?[indexPath.row] else { return UITableViewCell() }
    return getTableCell(from: deviationViewModel, at: indexPath)
  }
}

// MARK: - UITableViewDelegate

extension DeviationsViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return Const.BaseTableCell.cellHeight
  }
}
