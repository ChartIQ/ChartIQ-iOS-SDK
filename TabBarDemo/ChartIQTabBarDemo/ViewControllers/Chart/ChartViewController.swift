//
//  ChartViewController.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - Chart ViewController

class ChartViewController: BaseViewController, ChartRouterInputProtocol {

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

  /// ChartViewController cannot exist and work without a ChartIQView, so it is required to this screen.
  internal var chartIQView: ChartIQView!

  internal var selectedSymbol: SymbolModel?
  internal var selectedInterval: IntervalModel?
  internal var selectedChartStyle: ChartStyleModel?
  internal var selectedDrawTool: DrawToolViewModel?

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
  private var selectedDrawToolIndexPath: IndexPath?

  /// ChartViewController cannot exist and work without a ChartRouter, so it is required to this screen.
  private var chartRouter: ChartRouterOutputProtocol!

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

    floatingFullViewButton?.updateFramePosition(parentView: view)
  }

  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)

    guard tabBarController?.tabBar.selectedItem?.tag == 1 else { return }
    coordinator.animate(alongsideTransition: nil, completion: { _ in self.chartIQView.resizeChart() })
    performDeviceOrientation()
  }

  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)

    if #available(iOS 13.0, *), traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
      DispatchQueue.main.async {
        self.updateTheme()
      }
    }
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

    chartIQView.alpha = 0
    chartIQViewContainer.startActivityIndicator()
  }

  override func setupSettings() {
    chartRouter = ChartRouter(rootViewController: self)

    setupNavigationButtons()
    setupFloatingButton()
  }

  private func setupNavigationButtons() {
    setupLeftNavigationButtons()
    setupRightNavigationButtons()

    [symbolsButton, intervalsButton, seriesButton, drawToolButton, crosshairButton].forEach { button in
      button.isEnabled = false
    }
  }

  private func setupLeftNavigationButtons() {
    symbolsButton.applyStyle(for: .symbols, target: self, action: #selector(symbolsButtonTapped))
    intervalsButton.applyStyle(for: .intervals, target: self, action: #selector(intervalsButtonTapped))

    navigationItem.leftBarButtonItems = [
      UIBarButtonItem(customView: symbolsButton),
      UIBarButtonItem(customView: intervalsButton)
    ]
  }

  private func setupRightNavigationButtons() {
    seriesButton.applyStyle(for: .series, target: self, action: #selector(addSeriesButtonTapped))
    drawToolButton.applyStyle(for: .drawTool, target: self, action: #selector(drawToolButtonTapped))
    crosshairButton.applyStyle(for: .crosshair, target: self, action: #selector(crosshairButtonTapped))
    fullViewButton.applyStyle(for: .fullView, target: self, action: #selector(fullViewButtonTapped))

    navigationItem.rightBarButtonItems = [
      UIBarButtonItem(customView: crosshairButton),
      UIBarButtonItem(customView: drawToolButton),
      UIBarButtonItem(customView: seriesButton)
    ]
  }

  private func setupFloatingButton() {
    floatingFullViewButton = FloatingButton(parentView: view, position: .rightTop)
    floatingFullViewButton?.addTarget(self, action: #selector(fullViewButtonTapped), for: .touchUpInside)
    floatingFullViewButton?.isHidden = true
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
    blurredEffectView = UIVisualEffectView(style: .regular)
    guard let blurredEffectView = blurredEffectView else { return }
    chartIQViewContainer.addSubview(blurredEffectView)
    blurredEffectView.pinEdges(toView: chartIQViewContainer)
  }

  // MARK: - Actions Methods

  @IBAction private func undoButtonTapped(_ sender: Any) {
    _ = chartIQView.undoDrawing()
  }

  @IBAction private func redoButtonTapped(_ sender: Any) {
    _ = chartIQView.redoDrawing()
  }

  @objc private func symbolsButtonTapped() {
    chartRouter.route(to: .symbols, as: .present)
  }

  @objc private func intervalsButtonTapped() {
    chartRouter.route(to: .intervals, as: .present)
  }

  @objc private func addSeriesButtonTapped() {
    chartRouter.route(to: .series, as: .present)
  }

  @objc private func crosshairButtonTapped() {
    chartIQView.isCrosshairsEnabled() ? hideCrosshairInfoView() : showCrosshairInfoView()
  }

  @objc private func drawToolButtonTapped() {
    isDrawToolEnable ? hideDrawToolControlView() : chartRouter.route(to: .drawingTools, as: .present)
  }

  @objc private func fullViewButtonTapped() {
    isFullViewModeActive.toggle()
    updateFullViewMode(active: isFullViewModeActive, fromRotation: false)
  }

  // MARK: - Private Methods

  private func chartIQLoadedInitialData() {
    [symbolsButton, intervalsButton, seriesButton, drawToolButton, crosshairButton].forEach { button in
      button.isEnabled = true
    }

    updateCrosshairInfoView()
    updateTheme()
    locManager.performTranslations()
    chartIQView.alpha = 1
    chartIQViewContainer.stopActivityIndicator()
    blurredEffectView?.fadeOutAnimation()
  }

  internal func updateSymbol() {
    guard let symbol = chartIQView.symbol else { return }
    symbolsButton.setTitle(symbol, for: .normal)
  }

  internal func updateInterval() {
    guard let periodicity = chartIQView.periodicity, let interval = chartIQView.interval else { return }
    let intervalModel = IntervalModel(periodicity: periodicity,
                                      interval: interval,
                                      chartIQTimeUnit: chartIQView.timeUnit)
    selectedInterval = intervalModel
    intervalsButton.setTitle(intervalModel.getShortDisplayName(), for: .normal)
  }

  internal func updateChartStyle() {}

  private func updateTheme() {
    isUserInterfaceStyleDark ? chartIQView.setTheme(.night) : chartIQView.setTheme(.day)
    reloadDrawToolControlView()
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
    let crosshairImage = isEnabled ? UIImage.Chart.crosshairActiveImage : UIImage.Chart.crosshairInactiveImage
    crosshairButton.setImage(crosshairImage, for: .normal)
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

  internal func showDrawToolControlView() {
    if let selectedDrawingTool = selectedDrawTool?.drawingTool {
      chartIQView.enableDrawing(selectedDrawingTool)
    }
    let viewModels = drawToolsService.getDrawToolCollectionViewModels(from: chartIQView,
                                                                      isDarkTheme: isUserInterfaceStyleDark)
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

  internal func hideDrawToolControlView() {
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
    let viewModels = drawToolsService.getDrawToolCollectionViewModels(from: chartIQView,
                                                                      isDarkTheme: isUserInterfaceStyleDark)
    guard isDrawToolEnable, !viewModels.isEmpty else { return }
    drawToolViewModels = viewModels
    drawToolControlView?.updateView(with: drawToolViewModels)
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

  // MARK: - Landscape Custom Layout Private Methods

  private func performDeviceOrientation() {
    UIDevice.current.orientation.isLandscape ? performLandscapeOrientationLayout() : performPortraitOrientationLayout()
  }

  private func performPortraitOrientationLayout() {
    guard navigationItem.rightBarButtonItems?.count == Const.Chart.maxTabBarRightBarButtonItems else { return }
    navigationItem.rightBarButtonItems?.remove(at: 0)
    updateFullViewMode(active: false, fromRotation: true)
  }

  private func performLandscapeOrientationLayout() {
    guard navigationItem.rightBarButtonItems?.count != Const.Chart.maxTabBarRightBarButtonItems else { return }
    let fullViewBarButtonItem = UIBarButtonItem(customView: fullViewButton)
    navigationItem.rightBarButtonItems?.insert(fullViewBarButtonItem, at: 0)
    !isDrawToolEnable ? updateFullViewMode(active: true, fromRotation: true) : ()
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
}

// MARK: - ChartIQDataSource

extension ChartViewController: ChartIQDataSource {

  public func pullInitialData(by params: ChartIQQuoteFeedParams,
                              completionHandler: @escaping ([ChartIQData]) -> Void) {
    updateTheme()
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
    chartIQView.setVoiceoverFields(default: true)

    updateSymbol()
    updateInterval()
  }

  func chartIQView(_ chartIQView: ChartIQView, didUpdateMeasure measure: String) {
    guard !measure.isEmpty, isDrawToolEnable else { return }
    measureInfoView.isHidden = false
    measureInfoLabel.text = measure
  }
}

// MARK: - HorizontalPickerViewDelegate

extension ChartViewController: HorizontalPickerViewDelegate {

  func horizontalPickerView(_ horizontalPickerView: HorizontalPickerView, didSelect item: PickerViewItem) {
    guard selectedDrawToolIndexPath != nil else { return }
    switch horizontalPickerView.type {
    case .fillColor:
      didSelectColor(item: item, type: .fillColor)
    case .lineColor:
      didSelectColor(item: item, type: .lineColor)
    case .line:
      didSelectLine(item: item)
    }
    isHorizontalPickerViewHidden = true
    updateHorizontalPickerView()
    updateDrawToolControlView()
  }

  private func didSelectColor(item: PickerViewItem, type: ChartIQDrawingParameterType) {
    guard let indexPath = selectedDrawToolIndexPath,
          let color = item.selectedColor,
          let viewModel = drawToolViewModels[indexPath.row] as? DrawToolColorViewModel else { return }
    viewModel.color = color
    drawToolViewModels.replace(object: viewModel, atIndex: indexPath.row)
    chartIQView.setDrawingParameter(type, value: color.toHexString())
  }

  private func didSelectLine(item: PickerViewItem) {
    guard let indexPath = selectedDrawToolIndexPath,
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
    selectedDrawToolIndexPath = indexPath
    let viewModel = drawToolViewModels[indexPath.row]
    switch viewModel.type {
    case .selectedTool:
      didSelectTool(viewModel: viewModel)
    case .fillColor:
      didSelectColor(viewModel: viewModel, type: .fillColor)
    case .lineColor:
      didSelectColor(viewModel: viewModel, type: .lineColor)
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
    chartRouter.route(to: .drawingTools, as: .present)
  }

  private func didSelectColor(viewModel: DrawToolViewModelProtocol, type: HorizontalPickerViewType) {
    guard let colorViewModel = viewModel as? DrawToolColorViewModel else { return }
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
    chartRouter.route(to: .drawToolSettings, as: .push)
  }
}
