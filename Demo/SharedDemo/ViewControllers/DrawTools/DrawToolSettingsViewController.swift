//
//  DrawToolSettingsViewController.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
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
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    updateDrawToolViewModels()
  }

  override func languageDidChange() {
    let drawToolName = selectedDrawTool?.displayName ?? Const.DrawToolSettings.screenTitle
    navigationItem.title = locManager.localize(drawToolName)
  }

  // MARK: - Setup Methods

  override func setupUI() {
    let drawToolName = selectedDrawTool?.displayName ?? Const.DrawToolSettings.screenTitle
    navigationItem.title = locManager.localize(drawToolName)

    tableView.backgroundColor = .ghostWhiteСhineseBlackColor

    //    Temporarily commented not yet implemented
    //    optionsButton.frame = CGRect(origin: .zero, size: Const.ChartButton.circleButtonSize)
    //    optionsButton.setImage(UIImage.DrawTools.moreOptionsImage, for: .normal)
    //    optionsButton.addTarget(self, action: #selector(optionsButtonTapped), for: .touchUpInside)
    //    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: optionsButton)
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

  // MARK: - Actions Methods

  @objc private func optionsButtonTapped() {
    showMoreOptionsAlert()
  }

  // MARK: - Private Methods

  private func updateDrawToolViewModels() {
    guard let chartIQView = chartIQView else { return }
    let parameterViewModels = drawToolsService.getDrawToolTableViewModels(from: chartIQView,
                                                                          isDarkTheme: isUserInterfaceStyleDark)
    drawToolViewModels = [
      .first: parameterViewModels
    ]
    tableView.reloadData()
  }

  private func getOptionsForSelect(selectViewModel: SelectTableCellViewModel) -> [String] {
    let fontOptions = getFontOptionsForSelect(selectViewModel: selectViewModel)
    let elliottWaveOptions = getElliottWaveOptionsForSelect(selectViewModel: selectViewModel)
    var options: [String] = []
    options.append(contentsOf: fontOptions)
    options.append(contentsOf: elliottWaveOptions)
    return options
  }

  private func getFontOptionsForSelect(selectViewModel: SelectTableCellViewModel) -> [String] {
    var options: [String] = []
    if selectViewModel.title == Const.DrawToolsService.fontFamilyTitle {
      for fontFamily in ChartIQFontFamily.allCases {
        options.append(fontFamily.displayName)
      }
    } else if selectViewModel.title == Const.DrawToolsService.fontSizeTitle {
      for fontSize in ChartIQFontSize.allCases {
        options.append(fontSize.displayName)
      }
    }
    return options
  }

  private func getElliottWaveOptionsForSelect(selectViewModel: SelectTableCellViewModel) -> [String] {
    var options: [String] = []
    if selectViewModel.title == Const.DrawToolsService.waveTemplateTitle {
      for fontSize in ChartIQElliottWaveTemplate.allCases {
        options.append(fontSize.displayName)
      }
    } else if selectViewModel.title == Const.DrawToolsService.impulseTitle {
      for fontSize in ChartIQElliottWaveImpulse.allCases {
        options.append(fontSize.displayName)
      }
    } else if selectViewModel.title == Const.DrawToolsService.correctiveTitle {
      for fontSize in ChartIQElliottWaveCorrective.allCases {
        options.append(fontSize.displayName)
      }
    } else if selectViewModel.title == Const.DrawToolsService.decorationTitle {
      for fontSize in ChartIQElliottWaveDecoration.allCases {
        options.append(fontSize.displayName)
      }
    }
    return options
  }

  // MARK: - Private Update Parameter Methods

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

  private func updateSelectedOption(with viewModel: TableCellViewModelProtocol,
                                    at indexPath: IndexPath) {
    selectedCellIndex = indexPath.row
    if let selectViewModel = viewModel as? SelectTableCellViewModel {
      let options = getOptionsForSelect(selectViewModel: selectViewModel)
      showSelectOptionsController(with: options, selectCellViewModel: selectViewModel)
    } else if let fibSettingsViewModel = viewModel as? FibSettingsTableCellViewModel {
      showFibSettingsController(with: fibSettingsViewModel)
    } else if let deviationsViewModel = viewModel as? DeviationsTableCellViewModel {
      showDeviationsSettingsController(with: deviationsViewModel)
    }
  }

  // MARK: - Private Update Drawing Parameter Methods

  private func updateSelectedToggle(with toggleViewModel: ToggleTableCellViewModel, isToggleOn: Bool) {
    toggleViewModel.isToggleOn = isToggleOn
    chartIQView?.setDrawingParameter(.showLines, value: isToggleOn)
  }

  private func updateSelectedColorParameters(selectedColor: UIColor, colorViewModel: ColorTableCellViewModel) {
    colorViewModel.color = selectedColor
    let colorHexString = selectedColor.toHexString()
    if colorViewModel.title == Const.DrawToolsService.fillColorTitle {
      chartIQView?.setDrawingParameter(.fillColor, value: colorHexString)
    } else if colorViewModel.title == Const.DrawToolsService.lineColorTitle {
      chartIQView?.setDrawingParameter(.lineColor, value: colorHexString)
    }
    tableView.reloadData()
  }

  private func updateSelectedLineParameters(selectedLine: LineModel, lineViewModel: LineTableCellViewModel) {
    lineViewModel.lineModel = selectedLine
    chartIQView?.setDrawingParameter(.pattern, value: selectedLine.lineType.stringValue)
    chartIQView?.setDrawingParameter(.lineWidth, value: selectedLine.lineWidth)
    tableView.reloadData()
  }

  private func updateSelectedBoldParameter(isBoldSelected: Bool) {
    let value = isBoldSelected ? ChartIQConst.DrawingTool.boldKey : ChartIQConst.DrawingTool.boldOffKey
    chartIQView?.setDrawingParameter(.weight, value: value)
  }

  private func updateSelectedItalicParameter(isItalicSelected: Bool) {
    let value = isItalicSelected ? ChartIQConst.DrawingTool.italicKey : ChartIQConst.DrawingTool.normalKey
    chartIQView?.setDrawingParameter(.style, value: value)
  }

  private func updateSelectedOptionParameters(selectedOption: String, selectViewModel: SelectTableCellViewModel) {
    selectViewModel.detailTitle = selectedOption
    if selectViewModel.title == Const.DrawToolsService.fontFamilyTitle {
      chartIQView?.setDrawingParameter(.family, value: selectedOption)
    } else if selectViewModel.title == Const.DrawToolsService.fontSizeTitle {
      chartIQView?.setDrawingParameter(.size, value: selectedOption)
    } else if selectViewModel.title == Const.DrawToolsService.waveTemplateTitle {
      chartIQView?.setDrawingParameter(.waveTemplate, value: selectedOption)
    } else if selectViewModel.title == Const.DrawToolsService.impulseTitle {
      chartIQView?.setDrawingParameter(.impulse, value: selectedOption)
    } else if selectViewModel.title == Const.DrawToolsService.correctiveTitle {
      chartIQView?.setDrawingParameter(.corrective, value: selectedOption)
    } else if selectViewModel.title == Const.DrawToolsService.decorationTitle {
      chartIQView?.setDrawingParameter(.decoration, value: selectedOption)
    }
    tableView.reloadData()
  }

  private func updateSelectedFibSettings(selectedFibSettings: [[String: Any]]) {
    if let fibSettingsData = try? JSONSerialization.data(withJSONObject: selectedFibSettings, options: []) {
      let fibSettingsEncodedString = fibSettingsData.base64EncodedString()
      chartIQView?.setDrawingParameter(.fibs, value: fibSettingsEncodedString)
    }
  }

  // MARK: - Private Alert Methods

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

  // MARK: - Show Controllers Private Methods

  private func showSelectOptionsController(with options: [String],
                                           selectCellViewModel: SelectTableCellViewModel) {
    guard let controller = UIStoryboard.selectOptionViewController() else { return }
    controller.options = options
    controller.selectedOption = selectCellViewModel.detailTitle
    controller.selectedOptionTitle = selectCellViewModel.title
    controller.didSelectOption = { [weak self] option in
      self?.updateSelectedOptionParameters(selectedOption: option, selectViewModel: selectCellViewModel)
    }
    navigationController?.pushViewController(controller, animated: true)
  }

  private func showFibSettingsController(with viewModel: FibSettingsTableCellViewModel) {
    guard let controller = UIStoryboard.fibSettingsViewController() else { return }
    controller.selectedDrawTool = selectedDrawTool
    controller.fibSettings = viewModel.parameters
    controller.didSaveFibSettings = { [weak self] fibSettings in
      self?.updateSelectedFibSettings(selectedFibSettings: fibSettings)
    }
    navigationController?.pushViewController(controller, animated: true)
  }

  private func showDeviationsSettingsController(with viewModel: DeviationsTableCellViewModel) {
    guard let controller = UIStoryboard.deviationsViewController() else { return }
    controller.chartIQView = chartIQView
    controller.deviationModels = viewModel.deviationModels
    controller.didSaveFibSettings = { [weak self] fibSettings in
      self?.updateSelectedFibSettings(selectedFibSettings: fibSettings)
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
      guard let self = self else { return }
      guard let drawToolViewModel = self.drawToolViewModels[.first]?[self.selectedCellIndex] else { return }
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

  // MARK: - Private UITableView Helper Methods

  private func getTableCell(from viewModel: TableCellViewModelProtocol,
                            at indexPath: IndexPath) -> UITableViewCell {
    if let fontViewModel = viewModel as? FontTableCellViewModel,
       let fontCell = tableView.dequeueReusableCell(withIdentifier: Const.FontTableCell.cellId,
                                                    for: indexPath) as? FontTableCell {
      fontCell.setupCell(withViewModel: fontViewModel)
      fontCell.didSelectBoldButtonTapped = { [weak self] isBoldSelected in
        self?.updateSelectedBoldParameter(isBoldSelected: isBoldSelected)
      }
      fontCell.didSelectItalicButtonTapped = { [weak self] isItalicSelected in
        self?.updateSelectedItalicParameter(isItalicSelected: isItalicSelected)
      }
      return fontCell
    }
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
      toggleCell.didChangeToggle = { [weak self] isToggleOn in
        self?.updateSelectedToggle(with: toggleViewModel, isToggleOn: isToggleOn)
      }
      return toggleCell
    }
    if (viewModel is SelectTableCellViewModel) ||
        (viewModel is FibSettingsTableCellViewModel) ||
        (viewModel is DeviationsTableCellViewModel),
       let selectCell = tableView.dequeueReusableCell(withIdentifier: Const.SelectTableCell.cellId,
                                                      for: indexPath) as? SelectTableCell {
      selectCell.setupCell(withViewModel: viewModel)
      selectCell.didSelectButtonTapped = { [weak self] in
        self?.updateSelectedOption(with: viewModel, at: indexPath)
      }
      return selectCell
    }
    return UITableViewCell()
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
