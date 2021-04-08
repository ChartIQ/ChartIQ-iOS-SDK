//
//  ChartViewController.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - Chart ViewController

class ChartViewController: BaseViewController {

  // MARK: - IBOutlets

  @IBOutlet private var chartIQViewContainer: UIView!
  @IBOutlet private var crosshairInfoViewContainer: UIView!
  @IBOutlet private var undoRedoViewContainer: UIView!
  @IBOutlet private var measureInfoView: UIView!
  @IBOutlet private var measureInfoBackgroundView: UIView!
  @IBOutlet private var measureInfoLabel: UILabel!
  @IBOutlet private var crosshairInfoViewTopConstraint: NSLayoutConstraint!
  @IBOutlet private var horizontalPickerViewContainer: UIView!
  @IBOutlet private var horizontalPickerViewBottomConstraint: NSLayoutConstraint!
  @IBOutlet private var drawToolControlViewContainer: UIView!
  @IBOutlet private var drawToolControlViewBottomConstraint: NSLayoutConstraint!

  // MARK: - Internal Properties

  internal var chartIQView: ChartIQView!

  // MARK: - Private Properties

  private let symbolsButton = ChartButton(type: .system)
  private let intervalsButton = ChartButton(type: .system)
  private let seriesButton = ChartButton(type: .custom)
  private let crosshairButton = ChartButton(type: .custom)
  private let drawToolButton = ChartButton(type: .custom)
  private let fullViewButton = ChartButton(type: .custom)

  private var isHorizontalPickerViewHidden = true
  private var isDrawToolControlViewHidden = true
  private var isDrawToolEnable = false
  private var isFullViewModeActive = false

  private let dataSimulatorService = DataSimulatorService()
  private let drawToolsService = DrawToolsService()
  private let locManager = LocalizationManager.shared()

  private var drawToolViewModels: [DrawToolViewModelProtocol] = []

  private var floatingFullViewButton: FloatingButton?
  private var crosshairInfoView: CrosshairInfoView?
  private var horizontalPickerView: HorizontalPickerView?
  private var drawToolControlView: DrawToolControlView?
  private var blurredEffectView: UIVisualEffectView?

  private var selectedViewModelIndexPath: IndexPath?
  private var selectedDrawTool: DrawToolViewModel?
  private var selectedSymbol: SymbolModel?
  private var selectedInterval: IntervalModel?

  // MARK: - ViewController Lifecycle Methods

  override func viewDidLoad() {
    super.viewDidLoad()

    setupChartIQView()
    setupCrosshairInfoView()
    setupUndoRedoView()
    setupMeasureInfoView()
    setupHorizontalPickerView()
    setupDrawToolControlView()
    performDeviceOrientation()
    setupBlurEffectView()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    performDeviceOrientation()
    reloadDrawToolControlView()
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    floatingFullViewButton?.updateFramePosition(parentView: self.view)
  }

  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)

    guard tabBarController?.tabBar.selectedItem?.tag == 1 else { return }
    coordinator.animate(alongsideTransition: nil, completion: { _ in self.chartIQView.resizeChart() })
    performDeviceOrientation()
  }

  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)

    updateChartIQTheme()
  }

  override func languageDidChange() {
    intervalsButton.setTitle(selectedInterval?.getShortDisplayName(), for: .normal)
    if chartIQView.isCrosshairsEnabled(), let crosshairHUD = chartIQView.getHudDetails() {
      crosshairInfoView?.updateView(withCrosshairHUD: crosshairHUD)
    }
  }

  // MARK: - Setup Methods

  override func setupUI() {
    chartIQViewContainer.backgroundColor = .whiteCharlestonGreenColor
    chartIQView.backgroundColor = .whiteCharlestonGreenColor

    symbolsButton.frame = CGRect(origin: .zero, size: Const.Chart.symbolsButtonSize)
    symbolsButton.applyStyle(for: .symbols, target: self, action: #selector(symbolsButtonTapped))
    intervalsButton.frame = CGRect(origin: .zero, size: Const.Chart.intervalsButtonSize)
    intervalsButton.applyStyle(for: .intervals, target: self, action: #selector(intervalsButtonTapped))
    seriesButton.frame = CGRect(origin: .zero, size: Const.Chart.addSeriesButtonSize)
    seriesButton.applyStyle(for: .series, target: self, action: #selector(addSeriesButtonTapped))
    drawToolButton.frame = CGRect(origin: .zero, size: Const.Chart.drawingToolButtonSize)
    drawToolButton.applyStyle(for: .drawTool, target: self, action: #selector(drawToolButtonTapped))
    crosshairButton.frame = CGRect(origin: .zero, size: Const.Chart.crosshairButtonSize)
    crosshairButton.applyStyle(for: .crosshair, target: self, action: #selector(crosshairButtonTapped))
    fullViewButton.frame = CGRect(origin: .zero, size: Const.Chart.fullViewButtonSize)
    fullViewButton.applyStyle(for: .fullView, target: self, action: #selector(fullViewButtonTapped))

    navigationItem.leftBarButtonItems = [
      UIBarButtonItem(customView: symbolsButton),
      UIBarButtonItem(customView: intervalsButton)
    ]

    navigationItem.rightBarButtonItems = [
      UIBarButtonItem(customView: crosshairButton),
      UIBarButtonItem(customView: drawToolButton),
      UIBarButtonItem(customView: seriesButton)
    ]

    [symbolsButton, intervalsButton, seriesButton, drawToolButton, crosshairButton].forEach { button in
      button.isEnabled = false
    }

    floatingFullViewButton = FloatingButton(parentView: self.view, position: .rightTop)
    floatingFullViewButton?.addTarget(self, action: #selector(fullViewButtonTapped), for: .touchUpInside)
    floatingFullViewButton?.isHidden = true
  }

  override func setupSettings() {
    chartIQView.alpha = 0
    chartIQViewContainer.startActivityIndicator()
  }

  private func setupChartIQView() {
    chartIQView.adjustFrame(inView: chartIQViewContainer)
    chartIQView.pinEdges(toView: chartIQViewContainer)

    chartIQView.dataSource = self
    chartIQView.delegate = self
  }

  private func setupCrosshairInfoView() {
    crosshairInfoView = CrosshairInfoView.instantiate()
    crosshairInfoView?.adjustFrame(inView: crosshairInfoViewContainer)
    crosshairInfoViewContainer?.isHidden = true
    crosshairInfoViewTopConstraint.constant = -Const.CrosshairInfoView.height
  }

  private func setupUndoRedoView() {
    undoRedoViewContainer.isHidden = true
  }

  private func setupMeasureInfoView() {
    measureInfoView.isHidden = true
    measureInfoView.clipsToBounds = true
    measureInfoView.layer.cornerRadius = 3
    measureInfoView.backgroundColor = .clear
    measureInfoBackgroundView.backgroundColor = .ghostWhiteСhineseBlackColor
    measureInfoBackgroundView.alpha = 0.85
    measureInfoLabel.backgroundColor = .clear
    measureInfoLabel.textColor = .darkElectricBlueWhiteColor
  }

  private func setupHorizontalPickerView() {
    horizontalPickerView = HorizontalPickerView.instantiate(with: self)
    horizontalPickerView?.adjustFrame(inView: horizontalPickerViewContainer)
    isHorizontalPickerViewHidden = true
    horizontalPickerViewContainer?.isHidden = true
    horizontalPickerViewBottomConstraint.constant = -Const.HorizontalPickerView.height
  }

  private func setupDrawToolControlView() {
    drawToolControlView = DrawToolControlView.instantiate(with: self)
    drawToolControlView?.adjustFrame(inView: drawToolControlViewContainer)
    isDrawToolControlViewHidden = true
    drawToolControlViewContainer?.isHidden = true
    drawToolControlViewBottomConstraint.constant = -Const.DrawToolControlView.height
  }

  private func setupBlurEffectView() {
    let blurEffect = UIBlurEffect(style: .regular)
    blurredEffectView = UIVisualEffectView(effect: blurEffect)
    blurredEffectView?.backgroundColor = .whiteYankeesBlueColor
    guard let blurredEffectView = blurredEffectView else { return }
    chartIQViewContainer.addSubview(blurredEffectView)
    blurredEffectView.pinEdges(toView: chartIQViewContainer)
    blurredEffectView.alpha = 1
  }

  // MARK: - Actions Methods

  @IBAction private func undoButtonTapped(_ sender: Any) {
    _ = chartIQView.undoDrawing()
  }

  @IBAction private func redoButtonTapped(_ sender: Any) {
    _ = chartIQView.redoDrawing()
  }

  @objc private func symbolsButtonTapped() {
    presentSearchSymbolsViewController()
  }

  @objc private func intervalsButtonTapped() {
    presentIntervalsViewController()
  }

  @objc private func addSeriesButtonTapped() {
    presentSeriesViewController()
  }

  @objc private func crosshairButtonTapped() {
    chartIQView.isCrosshairsEnabled() ? hideCrosshairInfoView() : showCrosshairInfoView()
  }

  @objc private func drawToolButtonTapped() {
    isDrawToolEnable ? hideDrawToolControlView() : presentDrawingToolsViewController()
  }

  @objc private func fullViewButtonTapped() {
    isFullViewModeActive.toggle()
    updateFullViewMode(active: isFullViewModeActive, fromRotation: false)
  }

  // MARK: - Private Methods

  private func updateChartIQTheme() {
    if #available(iOS 12.0, *), traitCollection.userInterfaceStyle == .dark {
      chartIQView.setTheme(.night)
    } else {
      chartIQView.setTheme(.day)
    }
  }

  // MARK: - ChartIQView Private Methods

  private func chartIQLoadedInitialData() {
    [symbolsButton, intervalsButton, seriesButton, drawToolButton, crosshairButton].forEach { button in
      button.isEnabled = true
    }

    updateCrosshairInfoView()
    updateChartIQTheme()
    locManager.performTranslations()
    chartIQView.alpha = 1
    chartIQViewContainer.stopActivityIndicator()
    blurredEffectView?.fadeOutAnimation()
  }

  private func updateSymbol() {
    guard let symbol = chartIQView.symbol else { return }
    symbolsButton.setTitle(symbol, for: .normal)
  }

  private func updateInterval() {
    guard let periodicity = chartIQView.periodicity, let interval = chartIQView.interval else { return }
    let intervalModel = IntervalModel(period: periodicity,
                                      interval: interval,
                                      chartIQTimeUnit: chartIQView.timeUnit)
    selectedInterval = intervalModel
    intervalsButton.setTitle(intervalModel.getShortDisplayName(), for: .normal)
  }

  // MARK: - CrosshairInfoView Private Methods

  private func showCrosshairInfoView() {
    chartIQView.enableCrosshairs(true)
    updateCrosshairInfoView()
  }

  private func hideCrosshairInfoView() {
    chartIQView.enableCrosshairs(false)
    updateCrosshairInfoView()
  }

  private func updateCrosshairInfoView() {
    let isEnabled = chartIQView.isCrosshairsEnabled()
    isEnabled ? recursiveUpdateCrosshairHUDParameters() : ()
    crosshairButton.setImage(isEnabled ? UIImage.Chart.crosshairActiveImage : UIImage.Chart.crosshairInactiveImage,
                             for: .normal)
    animateCrosshairInfoView(show: isEnabled)
  }

  private func animateCrosshairInfoView(show isShow: Bool) {
    crosshairButton.isUserInteractionEnabled = false
    crosshairInfoViewContainer?.isHidden = false
    crosshairInfoViewTopConstraint.constant = isShow ? 0 : -Const.CrosshairInfoView.height
    UIView.animate(withDuration: AnimationTime.quiteFast.rawValue, animations: {
      self.view.layoutIfNeeded()
    }, completion: { _ in
      !isShow ? self.crosshairInfoViewContainer?.isHidden = true : ()
      self.crosshairButton.isUserInteractionEnabled = true
    })
  }

  private func recursiveUpdateCrosshairHUDParameters() {
    guard chartIQView.isCrosshairsEnabled() else { return }
    if let crosshairHUD = chartIQView.getHudDetails() {
      crosshairInfoView?.updateView(withCrosshairHUD: crosshairHUD)
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) {
      self.recursiveUpdateCrosshairHUDParameters()
    }
  }

  // MARK: - HorizontalPickerView Private Methods

  private func showHorizontalPickerView() {
    isHorizontalPickerViewHidden = false
    updateHorizontalPickerView()
  }

  private func hideHorizontalPickerView() {
    isHorizontalPickerViewHidden = true
    updateHorizontalPickerView()
  }

  private func updateHorizontalPickerView() {
    animateHorizontalPickerView(show: !isHorizontalPickerViewHidden)
  }

  private func animateHorizontalPickerView(show isShow: Bool) {
    horizontalPickerViewContainer?.isHidden = false
    horizontalPickerViewBottomConstraint.constant = isShow ? 0 : -Const.HorizontalPickerView.height
    UIView.animate(withDuration: AnimationTime.quiteFast.rawValue, animations: {
      self.view.layoutIfNeeded()
    }, completion: { _ in
      !isShow ? self.horizontalPickerViewContainer?.isHidden = true : ()
    })
  }

  // MARK: - DrawToolControlView Private Methods

  private func showDrawToolControlView() {
    if let selectedDrawingTool = selectedDrawTool?.drawingTool {
      chartIQView.enableDrawing(selectedDrawingTool)
    }
    let viewModels = drawToolsService.getDrawToolCollectionViewModels(from: chartIQView)
    if !viewModels.isEmpty {
      drawToolViewModels = viewModels
      drawToolButton.setImage(UIImage.Chart.drawToolActiveImage, for: .normal)
      isDrawToolEnable = true
      isDrawToolControlViewHidden = false
      measureInfoView.isHidden = true
      updateDrawToolControlView()
      updateFullViewMode(active: false, fromRotation: false)
    }
  }

  private func hideDrawToolControlView() {
    drawToolButton.setImage(UIImage.Chart.drawToolInactiveImage, for: .normal)
    hideHorizontalPickerView()
    selectedDrawTool = nil
    isDrawToolEnable = false
    isDrawToolControlViewHidden = true
    measureInfoView.isHidden = true
    animateDrawToolControlView(show: !isDrawToolControlViewHidden)
    chartIQView.disableDrawing()
  }

  private func reloadDrawToolControlView() {
    let viewModels = drawToolsService.getDrawToolCollectionViewModels(from: chartIQView)
    if isDrawToolEnable, !viewModels.isEmpty {
      drawToolViewModels = viewModels
      drawToolControlView?.updateView(with: drawToolViewModels)
    }
  }

  private func updateDrawToolControlView() {
    drawToolControlView?.updateView(with: drawToolViewModels)
    animateDrawToolControlView(show: !isDrawToolControlViewHidden)
  }

  private func animateDrawToolControlView(show isShow: Bool) {
    drawToolControlViewContainer.isHidden = false
    undoRedoViewContainer.isHidden = !isShow
    measureInfoView.isHidden = true
    drawToolControlViewBottomConstraint.constant = isShow ? 0 : -Const.DrawToolControlView.height
    UIView.animate(withDuration: AnimationTime.quiteFast.rawValue, animations: {
      self.view.layoutIfNeeded()
    }, completion: { _ in
      !isShow ? self.drawToolControlViewContainer?.isHidden = true : ()
    })
  }

  private func showManageLayersActionSheet() {
    let bringToTopTitle = locManager.localize(Const.Chart.bringToTopTitle)
    let bringForwardTitle = locManager.localize(Const.Chart.bringForwardTitle)
    let sendBackwardTitle = locManager.localize(Const.Chart.sendBackwardTitle)
    let sendToBottomTitle = locManager.localize(Const.Chart.sendToBottomTitle)
    let bringToTopAction = UIAlertAction(title: bringToTopTitle, style: .default) { _ in
      self.chartIQView.manageLayerDrawing(.top)
    }
    let bringForwardAction = UIAlertAction(title: bringForwardTitle, style: .default) { _ in
      self.chartIQView.manageLayerDrawing(.up)
    }
    let sendBackwardAction = UIAlertAction(title: sendBackwardTitle, style: .default) { _ in
      self.chartIQView.manageLayerDrawing(.back)
    }
    let sendToBottomAction = UIAlertAction(title: sendToBottomTitle, style: .default) { _ in
      self.chartIQView.manageLayerDrawing(.bottom)
    }
    showActionSheet(title: locManager.localize(Const.Chart.manageLayersTitle),
                    sourceView: drawToolControlViewContainer,
                    actions: [bringToTopAction, bringForwardAction, sendBackwardAction, sendToBottomAction])
  }

  // MARK: - Landscape Custom Layout Private Methods

  private func performDeviceOrientation() {
    UIDevice.current.orientation.isLandscape ? performLandscapeOrientationLayout() : performPortraitOrientationLayout()
  }

  private func performPortraitOrientationLayout() {
    if navigationItem.rightBarButtonItems?.count == Const.Chart.maxRightBarButtonItems {
      navigationItem.rightBarButtonItems?.remove(at: 0)
      updateFullViewMode(active: false, fromRotation: true)
    }
  }

  private func performLandscapeOrientationLayout() {
    if navigationItem.rightBarButtonItems?.count != Const.Chart.maxRightBarButtonItems {
      let fullViewBarButtonItem = UIBarButtonItem(customView: fullViewButton)
      navigationItem.rightBarButtonItems?.insert(fullViewBarButtonItem, at: 0)
      !isDrawToolEnable ? updateFullViewMode(active: true, fromRotation: true) : ()
    }
  }

  private func updateFullViewMode(active: Bool, fromRotation: Bool) {
    active ? hideFullViewModeViews() : ()
    navigationController?.setNavigationBarHidden(active, animated: true)
    extendedLayoutIncludesOpaqueBars = active
    edgesForExtendedLayout = .all
    tabBarController?.setTabBarHidden(active, animated: true, includingRotation: fromRotation)
    floatingFullViewButton?.isHidden = !active
    isFullViewModeActive = active
    DispatchQueue.main.asyncAfter(deadline: .now() + AnimationTime.default.rawValue) {
      self.chartIQView.resizeChart()
      DispatchQueue.main.asyncAfter(deadline: .now() + AnimationTime.default.rawValue) {
        self.chartIQView.resizeChart()
      }
    }
  }

  func hideFullViewModeViews() {
    chartIQView.enableCrosshairs(false)
    chartIQView.disableDrawing()
    crosshairButton.setImage(UIImage.Chart.crosshairInactiveImage, for: .normal)
    drawToolButton.setImage(UIImage.Chart.drawToolInactiveImage, for: .normal)
    [crosshairInfoViewContainer, horizontalPickerViewContainer, drawToolControlViewContainer,
     undoRedoViewContainer].forEach { container in
      container?.isHidden = true
    }
    selectedDrawTool = nil
    isDrawToolEnable = false
    isDrawToolControlViewHidden = true
    measureInfoView.isHidden = true
    isHorizontalPickerViewHidden = true
    horizontalPickerViewBottomConstraint.constant = -Const.HorizontalPickerView.height
    crosshairInfoViewTopConstraint.constant = -Const.CrosshairInfoView.height
    drawToolControlViewBottomConstraint.constant = -Const.DrawToolControlView.height
    view.layoutIfNeeded()
  }

  // MARK: - Present Controllers Private Methods

  private func presentSearchSymbolsViewController() {
    guard let controller = UIStoryboard.searchSymbolsViewController() else { return }
    controller.didSelectSymbol = { [weak self] symbol in
      guard let self = self else { return }
      self.selectedSymbol = symbol
      self.chartIQView.loadChart(symbol.name)
      self.symbolsButton.setTitle(symbol.name, for: .normal)
    }
    let navigationController = NavigationController(rootViewController: controller)
    present(navigationController, animated: true, completion: nil)
  }

  private func presentSeriesViewController() {
    guard let controller = UIStoryboard.seriesViewController() else { return }
    controller.chartIQView = chartIQView
    let navigationController = NavigationController(rootViewController: controller)
    present(navigationController, animated: true, completion: nil)
  }

  private func presentIntervalsViewController() {
    guard let controller = UIStoryboard.intervalsViewController() else { return }
    controller.selectedInterval = selectedInterval
    controller.didSelectInterval = { [weak self] interval in
      guard let self = self else { return }
      self.selectedInterval = interval
      self.chartIQView.setPeriodicity(interval.getPeriod(),
                                      interval: interval.getInterval(),
                                      timeUnit: interval.getTimeUnit())
      self.intervalsButton.setTitle(interval.getShortDisplayName(), for: .normal)
    }
    let navigationController = NavigationController(rootViewController: controller)
    present(navigationController, animated: true, completion: nil)
  }

  private func presentDrawingToolsViewController() {
    guard let controller = UIStoryboard.drawToolsViewController() else { return }
    controller.selectedDrawTool = selectedDrawTool
    controller.didSelectDrawTool = { [weak self] drawTool in
      guard let self = self else { return }
      self.selectedDrawTool = drawTool
      self.showDrawToolControlView()
    }
    controller.didClearAllDrawings = { [weak self] in
      guard let self = self else { return }
      self.chartIQView.clearDrawing()
      self.hideDrawToolControlView()
    }
    controller.didRestoreToDefaults = { [weak self] in
      guard let self = self else { return }
      self.chartIQView.restoreDefaultDrawingConfig(ChartIQDrawingTool.line, all: true)
      self.showDrawToolControlView()
    }
    let navigationController = NavigationController(rootViewController: controller)
    present(navigationController, animated: true, completion: nil)
  }

  // MARK: - Show Controllers Private Methods

  private func pushDrawToolSettingsViewController() {
    guard let controller = UIStoryboard.drawToolSettingsViewController() else { return }
    controller.selectedDrawTool = selectedDrawTool
    controller.chartIQView = chartIQView
    navigationController?.show(controller, sender: nil)
  }
}

// MARK: - ChartIQDataSource

extension ChartViewController: ChartIQDataSource {

  public func pullInitialData(by params: ChartIQQuoteFeedParams,
                              completionHandler: @escaping ([ChartIQData]) -> Void) {
    updateChartIQTheme()
    dataSimulatorService.loadChartData(withParameters: params, controller: self) { chartIQDataArray in
      completionHandler(chartIQDataArray)
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0, execute: {
        self.chartIQLoadedInitialData()
      })
    }
  }

  public func pullUpdateData(by params: ChartIQQuoteFeedParams,
                             completionHandler: @escaping ([ChartIQData]) -> Void) {
    dataSimulatorService.loadChartData(withParameters: params, controller: self, completionHandler: completionHandler)
  }

  public func pullPaginationData(by params: ChartIQQuoteFeedParams,
                                 completionHandler: @escaping ([ChartIQData]) -> Void) {
    dataSimulatorService.loadChartData(withParameters: params, controller: self, completionHandler: completionHandler)
  }
}

// MARK: - ChartIQDelegate

extension ChartViewController: ChartIQDelegate {

  func chartIQViewDidFinishLoading(_ chartIQView: ChartIQView) {
    chartIQView.setDataMethod(.pull)

    updateSymbol()
    updateInterval()

    let voiceoverFields = [
      ChartIQQuoteField.date.stringValue: true,
      ChartIQQuoteField.close.stringValue: true,
      ChartIQQuoteField.open.stringValue: false,
      ChartIQQuoteField.high.stringValue: false,
      ChartIQQuoteField.low.stringValue: false,
      ChartIQQuoteField.volume.stringValue: false
    ]
    chartIQView.setVoiceoverFields(voiceoverFields)
  }

  func chartIQView(_ chartIQView: ChartIQView, didUpdateLayout layout: Any) {}
  func chartIQView(_ chartIQView: ChartIQView, didUpdateSymbol symbol: String) {}
  func chartIQView(_ chartIQView: ChartIQView, didUpdateDrawing drawings: Any) {}

  func chartIQView(_ chartIQView: ChartIQView, didUpdateMeasure measure: String) {
    guard !measure.isEmpty, isDrawToolEnable else { return }
    measureInfoView.isHidden = false
    measureInfoLabel.text = measure
  }
}

// MARK: - HorizontalPickerViewDelegate

extension ChartViewController: HorizontalPickerViewDelegate {

  func horizontalPickerView(_ horizontalPickerView: HorizontalPickerView, didSelect item: PickerViewItem) {
    guard selectedViewModelIndexPath != nil else { return }
    switch horizontalPickerView.type {
    case .fillColor:
      didSelectFillColor(item: item)
    case .lineColor:
      didSelectLineColor(item: item)
    case .line:
      didSelectLine(item: item)
    }
    isHorizontalPickerViewHidden = true
    updateHorizontalPickerView()
    updateDrawToolControlView()
  }

  private func didSelectFillColor(item: PickerViewItem) {
    guard let indexPath = selectedViewModelIndexPath,
          let color = item.selectedColor,
          let viewModel = drawToolViewModels[indexPath.row] as? DrawToolColorViewModel else { return }
    viewModel.color = color
    drawToolViewModels.replace(object: viewModel, atIndex: indexPath.row)
    chartIQView.setDrawingParameter(.fillColor, value: color.toHexString())
  }

  private func didSelectLineColor(item: PickerViewItem) {
    guard let indexPath = selectedViewModelIndexPath,
          let color = item.selectedColor,
          let viewModel = drawToolViewModels[indexPath.row] as? DrawToolColorViewModel else { return }
    viewModel.color = color
    drawToolViewModels.replace(object: viewModel, atIndex: indexPath.row)
    chartIQView.setDrawingParameter(.lineColor, value: color.toHexString())
  }

  private func didSelectLine(item: PickerViewItem) {
    guard let indexPath = selectedViewModelIndexPath,
          let line = item.selectedLine,
          let viewModel = drawToolViewModels[indexPath.row] as? DrawToolBaseViewModel else { return }
    viewModel.line = line
    viewModel.image = line.lineImage
    drawToolViewModels.replace(object: viewModel, atIndex: indexPath.row)
    chartIQView.setDrawingParameter(.pattern, value: line.lineType.stringValue)
    chartIQView.setDrawingParameter(.lineWidth, value: line.lineWidth)
  }
}

// MARK: - DrawToolControlViewDelegate

extension ChartViewController: DrawToolControlViewDelegate {

  func drawingToolControlView(_ drawingToolControlView: DrawToolControlView, didSelectItemAt indexPath: IndexPath) {
    selectedViewModelIndexPath = indexPath
    let viewModel = drawToolViewModels[indexPath.row]
    switch viewModel.type {
    case .selectedTool:
      didSelectTool(viewModel: viewModel)
    case .fillColor:
      didSelectFillColor(viewModel: viewModel)
    case .lineColor:
      didSelectLineColor(viewModel: viewModel)
    case .lineType:
      didSelectLineType(viewModel: viewModel)
    case .settings:
      didSelectSettings(viewModel: viewModel)
    default:
      break
    }
  }

  private func didSelectTool(viewModel: DrawToolViewModelProtocol) {
    hideHorizontalPickerView()
    updateDrawToolControlView()
    presentDrawingToolsViewController()
  }

  private func didSelectFillColor(viewModel: DrawToolViewModelProtocol) {
    guard let colorViewModel = viewModel as? DrawToolColorViewModel else { return }
    let type: HorizontalPickerViewType = .fillColor
    if !isHorizontalPickerViewHidden && horizontalPickerView?.type == type {
      hideHorizontalPickerView()
      updateDrawToolControlView()
    } else {
      horizontalPickerView?.updateView(withType: type, color: colorViewModel.color)
      showHorizontalPickerView()
    }
  }

  private func didSelectLineColor(viewModel: DrawToolViewModelProtocol) {
    guard let colorViewModel = viewModel as? DrawToolColorViewModel else { return }
    let type: HorizontalPickerViewType = .lineColor
    if !isHorizontalPickerViewHidden && horizontalPickerView?.type == type {
      hideHorizontalPickerView()
      updateDrawToolControlView()
    } else {
      horizontalPickerView?.updateView(withType: type, color: colorViewModel.color)
      showHorizontalPickerView()
    }
  }

  private func didSelectLineType(viewModel: DrawToolViewModelProtocol) {
    guard let baseViewModel = viewModel as? DrawToolBaseViewModel, let line = baseViewModel.line else { return }
    let type: HorizontalPickerViewType = .line
    if !isHorizontalPickerViewHidden && horizontalPickerView?.type == type {
      hideHorizontalPickerView()
      updateDrawToolControlView()
    } else {
      horizontalPickerView?.updateView(withType: type, line: line)
      showHorizontalPickerView()
    }
  }

  private func didSelectSettings(viewModel: DrawToolViewModelProtocol) {
    hideHorizontalPickerView()
    updateDrawToolControlView()
    pushDrawToolSettingsViewController()
  }
}
