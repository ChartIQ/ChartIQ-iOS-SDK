//
//  DrawToolSettingsViewController.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - DrawToolSettings ViewController

class DrawToolSettingsViewController: BaseViewController {

  // MARK: - TableSection Enum

  enum TableSection: Int, CaseIterable {
    case first = 0, total
  }

  // MARK: - IBOutlets

  @IBOutlet private var tableView: UITableView!

  // MARK: - Internal Properties

  internal var chartIQView: ChartIQView?
  internal var selectedDrawTool: DrawToolViewModel?
  internal var didSaveAsTemplate: (() -> Void)?
  internal var didRestoreConfig: (() -> Void)?

  // MARK: - Private Properties

  private let optionsButton = UIButton(type: .custom)
  private var drawToolViewModels: [TableSection: [TableCellViewModelProtocol]] = [:]
  private let locManager = LocalizationManager.shared()
  private let drawToolsService = DrawToolsService()
  private var selectedCellIndex = 0

  // MARK: - ViewController Lifecycle Methods

  override func viewDidLoad() {
    super.viewDidLoad()

    updateDrawToolViewModels()
  }

  // MARK: - Setup Methods

  override func setupUI() {
    let drawToolName = selectedDrawTool?.displayName ?? Const.DrawToolSettings.screenTitle
    navigationItem.title = locManager.localize(drawToolName)

    tableView.backgroundColor = .ghostWhiteСhineseBlackColor

    optionsButton.frame = CGRect(origin: .zero, size: Const.Chart.crosshairButtonSize)
    optionsButton.setImage(UIImage.DrawTools.moreOptionsImage, for: .normal)
    optionsButton.addTarget(self, action: #selector(optionsButtonTapped), for: .touchUpInside)
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: optionsButton)
  }

  override func setupSettings() {
    tableView.register(nibName: Const.FontTableCell.cellNibName, cellId: Const.FontTableCell.cellId)
    tableView.register(nibName: Const.TextColorTableCell.cellNibName, cellId: Const.TextColorTableCell.cellId)
    tableView.register(nibName: Const.ToggleTableCell.cellNibName, cellId: Const.ToggleTableCell.cellId)
    tableView.register(nibName: Const.SelectTableCell.cellNibName, cellId: Const.SelectTableCell.cellId)
    tableView.register(nibName: Const.LineTableCell.cellNibName, cellId: Const.LineTableCell.cellId)

    tableView.delegate = self
    tableView.dataSource = self
  }

  private func updateDrawToolViewModels() {
    guard let chartIQView = chartIQView else { return }
    let parameterViewModels = drawToolsService.getDrawToolTableViewModels(from: chartIQView)
    drawToolViewModels = [
      .first: parameterViewModels
    ]
    tableView.reloadData()
  }

  override func languageDidChange() {
    let drawToolName = selectedDrawTool?.displayName ?? Const.DrawToolSettings.screenTitle
    navigationItem.title = locManager.localize(drawToolName)
  }

  // MARK: - Actions Methods

  @objc private func optionsButtonTapped() {
    showMoreOptionsAlert()
  }

  // MARK: - Private Methods

  private func updateSelectedItem(with viewModel: TableCellViewModelProtocol,
                                  at indexPath: IndexPath) {
    selectedCellIndex = indexPath.row
    if let colorViewModel = viewModel as? ColorTableCellViewModel {
      let colorPickerViewItem = PickerViewItem(selectedColor: colorViewModel.color, selectedLine: nil)
      presentFullScreenPickerController(with: .color, pickerViewItem: colorPickerViewItem)
    } else if let lineViewModel = viewModel as? LineTableCellViewModel {
      let linePickerViewItem = PickerViewItem(selectedColor: nil, selectedLine: lineViewModel.lineModel)
      presentFullScreenPickerController(with: .line, pickerViewItem: linePickerViewItem)
    }
  }

  private func updateSelectedOption(with selectViewModel: SelectTableCellViewModel,
                                    at indexPath: IndexPath) {
    selectedCellIndex = indexPath.row
    var options: [String] = []
    var selectedOption: String?
    if selectViewModel.title == Const.DrawToolsService.fontFamilyTitle {
      for fontFamily in ChartIQFontFamily.allCases {
        options.append(fontFamily.displayName)
        if fontFamily.displayName == selectViewModel.detailTitle {
          selectedOption = fontFamily.displayName
        }
      }
    } else if selectViewModel.title == Const.DrawToolsService.fontSizeTitle {
      for fontSize in ChartIQFontSize.allCases {
        options.append(fontSize.displayName)
        if fontSize.displayName == selectViewModel.detailTitle {
          selectedOption = fontSize.displayName
        }
      }
    }
    showSelectOptionsController(with: options,
                                selectedOption: selectedOption,
                                selectCellViewModel: selectViewModel)
  }

  private func updateSelectedToggle(with toggleViewModel: ToggleTableCellViewModel, isToggleOn: Bool) {
    toggleViewModel.isToggleOn = isToggleOn
  }

  private func updateSelectedColorParameters(selectedColor: UIColor, colorViewModel: ColorTableCellViewModel) {
    colorViewModel.color = selectedColor
    let colorHexString = selectedColor.toHexString()
    if colorViewModel.title == Const.DrawToolsService.fillColorTitle {
      chartIQView?.setDrawingParameter(Const.DrawToolsService.fillColorKey, value: colorHexString)
    } else if colorViewModel.title == Const.DrawToolsService.lineColorTitle {
      chartIQView?.setDrawingParameter(Const.DrawToolsService.lineColorKey, value: colorHexString)
    }
    tableView.reloadData()
  }

  private func updateSelectedOptionParameters(selectedOption: String, selectViewModel: SelectTableCellViewModel) {
    if selectViewModel.title == Const.DrawToolsService.fontFamilyTitle {
      selectViewModel.detailTitle = selectedOption
      chartIQView?.setDrawingParameter("fontFamily", value: selectedOption)
    } else if selectViewModel.title == Const.DrawToolsService.fontSizeTitle {
      selectViewModel.detailTitle = selectedOption
      chartIQView?.setDrawingParameter("fontSize", value: selectedOption)
    }
    tableView.reloadData()
  }

  private func updateSelectedLineParameters(selectedLine: LineModel, lineViewModel: LineTableCellViewModel) {
    lineViewModel.lineModel = selectedLine
    chartIQView?.setDrawingParameter(Const.DrawToolsService.patternKey, value: selectedLine.lineType.stringValue)
    chartIQView?.setDrawingParameter(Const.DrawToolsService.lineWidthKey, value: selectedLine.lineWidth)
    tableView.reloadData()
  }

  private func showMoreOptionsAlert() {
    let saveActionTitle = locManager.localize(Const.DrawToolSettings.saveAsTemplateActionTitle)
    let restoreActionTitle = locManager.localize(Const.DrawToolSettings.restoreConfigActionTitle)
    let saveAction = UIAlertAction(title: saveActionTitle, style: .default) { _ in
      self.showSaveAsTemplateConfirmationAlert()
    }
    let restoreAction = UIAlertAction(title: restoreActionTitle, style: .destructive) { _ in
      self.showRestoreConfigConfirmationAlert()
    }
    showActionSheet(sourceView: optionsButton, actions: [saveAction, restoreAction])
  }

  private func showSaveAsTemplateConfirmationAlert() {
    let saveTitle = locManager.localize(Const.DrawToolSettings.saveAsTemplateAlertTitle)
    let saveMessage = locManager.localize(Const.DrawToolSettings.saveAsTemplateAlertMessage)
    let saveAction = UIAlertAction(title: locManager.localize(Const.General.saveTitle), style: .default) { _ in
      self.didSaveAsTemplate?()
      self.dismiss(animated: true, completion: nil)
    }
    showAlert(title: saveTitle, message: saveMessage, actions: [saveAction])
  }

  private func showRestoreConfigConfirmationAlert() {
    let restoreTitle = locManager.localize(Const.DrawToolSettings.restoreConfigAlertTitle)
    let restoreMessage = locManager.localize(Const.DrawToolSettings.restoreConfigAlertMessage)
    let restoreAction = UIAlertAction(title: locManager.localize(Const.General.restoreTitle),
                                      style: .destructive) { _ in
      self.didRestoreConfig?()
      self.dismiss(animated: true, completion: nil)
    }
    showAlert(title: restoreTitle, message: restoreMessage, actions: [restoreAction])
  }

  private func getTableCell(from viewModel: TableCellViewModelProtocol,
                            at indexPath: IndexPath) -> UITableViewCell {
    if let fontViewModel = viewModel as? FontTableCellViewModel,
      let fontCell = tableView.dequeueReusableCell(withIdentifier: Const.FontTableCell.cellId,
                                                   for: indexPath) as? FontTableCell {
      fontCell.setupCell(withViewModel: fontViewModel)
      return fontCell
    }
    if let colorViewModel = viewModel as? ColorTableCellViewModel,
      let textColorCell = tableView.dequeueReusableCell(withIdentifier: Const.TextColorTableCell.cellId,
                                                        for: indexPath) as? TextColorTableCell {
      textColorCell.setupCell(withViewModel: colorViewModel)
      textColorCell.didSelectColorButtonTapped = { [weak self] in
        guard let self = self else { return }
        self.updateSelectedItem(with: colorViewModel, at: indexPath)
      }
      return textColorCell
    }
    if let lineViewModel = viewModel as? LineTableCellViewModel,
      let lineCell = tableView.dequeueReusableCell(withIdentifier: Const.LineTableCell.cellId,
                                                   for: indexPath) as? LineTableCell {
      lineCell.setupCell(withViewModel: lineViewModel)
      lineCell.didSelectLineButtonTapped = { [weak self] in
        guard let self = self else { return }
        self.updateSelectedItem(with: lineViewModel, at: indexPath)
      }
      return lineCell
    }
    if let toggleViewModel = viewModel as? ToggleTableCellViewModel,
      let toggleCell = tableView.dequeueReusableCell(withIdentifier: Const.ToggleTableCell.cellId,
                                                     for: indexPath) as? ToggleTableCell {
      toggleCell.setupCell(withViewModel: toggleViewModel)
      toggleCell.toggleDidChange = { [weak self] isToggleOn in
        guard let self = self else { return }
        self.updateSelectedToggle(with: toggleViewModel, isToggleOn: isToggleOn)
      }
      return toggleCell
    }
    if let selectViewModel = viewModel as? SelectTableCellViewModel,
      let selectCell = tableView.dequeueReusableCell(withIdentifier: Const.SelectTableCell.cellId,
                                                     for: indexPath) as? SelectTableCell {
      selectCell.setupCell(withViewModel: selectViewModel)
      selectCell.didSelectButtonTapped = { [weak self] in
        guard let self = self else { return }
        self.updateSelectedOption(with: selectViewModel, at: indexPath)
      }
      return selectCell
    }
    return UITableViewCell()
  }

  // MARK: - Show Controllers Private Methods

  private func showSelectOptionsController(with options: [String],
                                           selectedOption: String?,
                                           selectCellViewModel: SelectTableCellViewModel) {
    guard let controller = UIStoryboard.selectOptionViewController() else { return }
    controller.options = options
    controller.selectedOption = selectedOption?.capitalizeFirst()
    controller.didSelectOption = { [weak self] option in
      guard let self = self else { return }
      self.updateSelectedOptionParameters(selectedOption: option, selectViewModel: selectCellViewModel)
    }
    navigationController?.pushViewController(controller, animated: true)
  }

  // MARK: - Present Controllers Private Methods

  private func presentFullScreenPickerController(with pickerType: FullScreenPickerType,
                                                 pickerViewItem: PickerViewItem) {
    guard let controller = UIStoryboard.fullScreenPickerViewController() else { return }
    controller.selectedPickerViewItem = pickerViewItem
    controller.pickerType = pickerType
    controller.didSelectPickerViewItem = { [weak self] item in
      guard let self = self,
        let drawToolViewModel = self.drawToolViewModels[.first]?[self.selectedCellIndex] else { return }
      if let selectedColor = item.selectedColor, let colorViewModel = drawToolViewModel as? ColorTableCellViewModel {
        self.updateSelectedColorParameters(selectedColor: selectedColor, colorViewModel: colorViewModel)
      } else if let selectedLine = item.selectedLine,
        let lineViewModel = drawToolViewModel as? LineTableCellViewModel {
        self.updateSelectedLineParameters(selectedLine: selectedLine, lineViewModel: lineViewModel)
      }
    }
    let navigationController = NavigationController(rootViewController: controller)
    present(navigationController, animated: true, completion: nil)
  }
}

// MARK: - UITableViewDataSource

extension DrawToolSettingsViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return TableSection.total.rawValue
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let tableSection = TableSection(rawValue: section) else { return 0 }
    return drawToolViewModels[tableSection]?.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let tableSection = TableSection(rawValue: indexPath.section),
      let drawToolViewModel = drawToolViewModels[tableSection]?[indexPath.row] else { return UITableViewCell() }
    return getTableCell(from: drawToolViewModel, at: indexPath)
  }
}

// MARK: - UITableViewDelegate

extension DrawToolSettingsViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return Const.BaseTableCell.cellHeight
  }
}
