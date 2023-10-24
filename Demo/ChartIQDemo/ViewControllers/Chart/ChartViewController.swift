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
  @IBOutlet private var navigationViewContainer: UIView!
  @IBOutlet private var undoRedoViewContainer: UIView!
  @IBOutlet private var measureInfoView: UIView!
  @IBOutlet private var measureInfoBackgroundView: UIView!
  @IBOutlet private var measureInfoLabel: UILabel!
  @IBOutlet private var crosshairInfoViewTopConstraint: NSLayoutConstraint!
  @IBOutlet private var navigationViewTopConstraint: NSLayoutConstraint!
  @IBOutlet private var horizontalPickerViewContainer: UIView!
  @IBOutlet private var horizontalPickerViewBottomConstraint: NSLayoutConstraint!
  @IBOutlet private var drawToolControlViewContainer: UIView!
  @IBOutlet private var drawToolControlViewBottomConstraint: NSLayoutConstraint!
  @IBOutlet private var homeIndicatorView: UIView!

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
  private let signalsButton = ChartButton(type: .custom)
  private let crosshairButton = ChartButton(type: .custom)
  private let drawToolButton = ChartButton(type: .custom)
  private let fullViewButton = ChartButton(type: .custom)
  private let moreButton = ChartButton(type: .custom)
  private let studiesButton = ChartButton(type: .custom)
  private let settingsButton = ChartButton(type: .custom)
  private let chartStyleButton = ChartButton(type: .custom)

  private var isHorizontalPickerViewHidden = true
  private var isDrawToolControlViewHidden = true
  private var isDrawToolEnable = false
  private var isFullViewModeActive = false
  private var isNavigationViewVisible = false

  private let dataSimulatorService = DataSimulatorService()
  private let drawToolsService = DrawToolsService()
  private let locManager = LocalizationManager.shared()

  private var drawToolViewModels: [DrawToolViewModelProtocol] = []

  private var floatingFullViewButton: FloatingButton?
  private var crosshairInfoView: CrosshairInfoView?
  private var navigationView: NavigationView?
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
    updateNativeNavigationBar(isSeparatorHidden: isNavigationViewVisible)
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)

    updateNativeNavigationBar(isSeparatorHidden: false)
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    floatingFullViewButton?.updateFramePosition(parentView: view)
  }

  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)

    coordinator.animate(alongsideTransition: nil, completion: { _ in self.chartIQView.resizeChart() })

    performDeviceOrientation()
  }

  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)

    if #available(iOS 13.0, *), traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
      DispatchQueue.main.async { self.updateTheme() }
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

    homeIndicatorView.backgroundColor = .ghostWhiteСhineseBlackColor
    undoRedoViewContainer.isHidden = true
  }

  override func setupSettings() {
    chartRouter = ChartRouter(rootViewController: self)
    setupNavigationButtons()
    setupFloatingButton()
  }

  private func setupNavigationButtons() {
    setupNavigationView()
    setupLeftNavigationButtons()
    setupRightNavigationButtons()
    updateNavigationButtons(isEnabled: false)
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
    seriesButton.applyStyle(for: .series, target: self, action: #selector(seriesButtonTapped))
    signalsButton.applyStyle(for: .signals, target: self, action: #selector(signalsButtonTapped))
    drawToolButton.applyStyle(for: .drawTool, target: self, action: #selector(drawToolButtonTapped))
    crosshairButton.applyStyle(for: .crosshair, target: self, action: #selector(crosshairButtonTapped))
    fullViewButton.applyStyle(for: .fullView, target: self, action: #selector(fullViewButtonTapped))
    moreButton.applyStyle(for: .more, target: self, action: #selector(moreButtonTapped))
    studiesButton.applyStyle(for: .studies, target: self, action: #selector(studiesButtonTapped))
    settingsButton.applyStyle(for: .settings, target: self, action: #selector(settingsButtonTapped))
    chartStyleButton.applyStyle(for: .chartStyle, target: self, action: #selector(chartStyleButtonTapped))

    setupPortraitRightNavigationButtons()
  }

  private func setupPortraitRightNavigationButtons() {
    navigationItem.rightBarButtonItems = nil

    DispatchQueue.main.async {
      if DeviceManager.shared().device == .iPhoneSE {
        self.setupIPhoneSEPortraitRightNavigationButtons()
      } else if DeviceManager.shared().device == .iPad {
        self.setupiPadPortraitRightNavigationButtons()
      } else {
        self.setupBasePortraitRightNavigationButtons()
      }
    }
  }

  private func setupIPhoneSEPortraitRightNavigationButtons() {
    navigationItem.rightBarButtonItems = [
      UIBarButtonItem(customView: moreButton),
      UIBarButtonItem(customView: studiesButton),
      UIBarButtonItem(customView: chartStyleButton)
    ]

    navigationView?.buttons = [
      settingsButton,
      drawToolButton,
      crosshairButton,
      seriesButton,
      signalsButton
    ]
  }

  private func setupBasePortraitRightNavigationButtons() {
    navigationItem.rightBarButtonItems = [
      UIBarButtonItem(customView: moreButton),
      UIBarButtonItem(customView: seriesButton),
      UIBarButtonItem(customView: studiesButton),
      UIBarButtonItem(customView: chartStyleButton)
    ]

    navigationView?.buttons = [
      settingsButton,
      drawToolButton,
      crosshairButton,
      signalsButton
    ]
  }

  private func setupiPadPortraitRightNavigationButtons() {
    navigationItem.rightBarButtonItems = [
      UIBarButtonItem(customView: settingsButton),
      UIBarButtonItem(customView: drawToolButton),
      UIBarButtonItem(customView: crosshairButton),
      UIBarButtonItem(customView: seriesButton),
      UIBarButtonItem(customView: signalsButton),
      UIBarButtonItem(customView: studiesButton),
      UIBarButtonItem(customView: chartStyleButton)
    ]

    navigationView?.isHidden = true
  }

  private func setupLandscapeRightNavigationButtons() {
    navigationItem.rightBarButtonItems = nil

    navigationItem.rightBarButtonItems = [
      UIBarButtonItem(customView: fullViewButton),
      UIBarButtonItem(customView: settingsButton),
      UIBarButtonItem(customView: drawToolButton),
      UIBarButtonItem(customView: crosshairButton),
      UIBarButtonItem(customView: seriesButton),
      UIBarButtonItem(customView: signalsButton),
      UIBarButtonItem(customView: studiesButton),
      UIBarButtonItem(customView: chartStyleButton)
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

  private func setupNavigationView() {
    navigationView = NavigationView.instantiate()
    navigationView?.adjustFrame(inView: navigationViewContainer)
    navigationViewContainer?.isHidden = true
    navigationViewTopConstraint.constant = -Const.NavigationView.height
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

  @objc private func studiesButtonTapped() {
    chartRouter.route(to: .studies, as: .present)
  }

  @objc private func settingsButtonTapped() {
    chartRouter.route(to: .settings, as: .present)
  }

  @objc private func chartStyleButtonTapped() {
    chartRouter.route(to: .chartStyle, as: .present)
  }

  @objc private func symbolsButtonTapped() {
    chartRouter.route(to: .symbols, as: .present)
  }

  @objc private func intervalsButtonTapped() {
    chartRouter.route(to: .intervals, as: .present)
  }

  @objc private func seriesButtonTapped() {
    chartRouter.route(to: .series, as: .present)
  }

  @objc private func signalsButtonTapped() {
    chartRouter.route(to: .signals, as: .present)
  }

  @objc private func crosshairButtonTapped() {
    chartIQView.isCrosshairsEnabled() ? hideCrosshairInfoView() : showCrosshairInfoView()
  }

  @objc private func drawToolButtonTapped() {
    isDrawToolEnable ? hideDrawToolControlView() : chartRouter.route(to: .drawingTools, as: .present)
  }

  @objc private func moreButtonTapped() {
    isNavigationViewVisible ? hideNavigationView() : showNavigationView()
  }

  @objc private func fullViewButtonTapped() {
    isFullViewModeActive.toggle()
    updateFullViewMode(active: isFullViewModeActive, fromRotation: false)
  }

  // MARK: - Private Methods

  private func chartIQLoadedInitialData() {
    updateNavigationButtons(isEnabled: true)
    updateCrosshairInfoView()
    updateTheme()
    locManager.performTranslations()
    chartIQView.alpha = 1
    chartIQViewContainer.stopActivityIndicator()
    blurredEffectView?.fadeOutAnimation()
  }

  private func updateNavigationButtons(isEnabled: Bool) {
    [symbolsButton, intervalsButton, seriesButton, signalsButton, drawToolButton, crosshairButton,
     fullViewButton, moreButton, studiesButton, settingsButton, chartStyleButton
    ].forEach { button in
      button.isEnabled = isEnabled
    }
  }

  internal func updateSymbol() {
    guard let symbol = chartIQView.symbol else { return }
    symbolsButton.setTitle(symbol, for: .normal)
  }

  internal func updateInterval() {
    guard let periodicity = chartIQView.periodicity, let interval = chartIQView.interval else { return }
    let intervalModel = IntervalModel(periodicity: periodicity, interval: interval, chartIQTimeUnit: chartIQView.timeUnit)
    selectedInterval = intervalModel
    intervalsButton.setTitle(intervalModel.getShortDisplayName(), for: .normal)
  }

  internal func updateChartStyle() {
    selectedChartStyle = ChartStyleModel(chartType: chartIQView.chartType,
                                         chartAggregationType: chartIQView.chartAggregationType)
    chartStyleButton.setImage(selectedChartStyle?.typeImage, for: .normal)
  }

  private func updateTheme() {
    isUserInterfaceStyleDark ? chartIQView.setTheme(.night) : chartIQView.setTheme(.day)
    chartStyleButton.updateStyle()
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
    let viewModels = drawToolsService.getDrawToolCollectionViewModels(from: chartIQView, isDarkTheme: isUserInterfaceStyleDark)
    guard !viewModels.isEmpty else { return }
    drawToolViewModels = viewModels
    drawToolButton.setImage(UIImage.Chart.drawToolActiveImage, for: .normal)
    isDrawToolEnable = true
    isDrawToolControlViewHidden = false
    measureInfoView.isHidden = true
    updateDrawToolControlView()
    updateFullViewMode(active: false, fromRotation: false)
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
    let viewModels = drawToolsService.getDrawToolCollectionViewModels(from: chartIQView, isDarkTheme: isUserInterfaceStyleDark)
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

  // MARK: - NavigationView Private Methods

  private func showNavigationView() {
    isNavigationViewVisible = true
    updateNavigationView()
  }

  private func hideNavigationView() {
    isNavigationViewVisible = false
    updateNavigationView()
  }

  private func hideNavigationViewWithoutAnimtation() {
    isNavigationViewVisible = false
    navigationViewContainer.isHidden = true
    navigationViewTopConstraint.constant = -Const.NavigationView.height
    moreButton.setImage(UIImage.Chart.moreInactiveImage, for: .normal)
  }

  private func updateNavigationView() {
    let image = isNavigationViewVisible ? UIImage.Chart.moreActiveImage : UIImage.Chart.moreInactiveImage
    moreButton.setImage(image, for: .normal)
    animateNavigationView(show: isNavigationViewVisible)
  }

  private func animateNavigationView(show isShow: Bool) {
    moreButton.isUserInteractionEnabled = false
    navigationViewContainer?.isHidden = false
    navigationViewTopConstraint.constant = isShow ? 0 : -Const.NavigationView.height
    isShow ? updateNativeNavigationBar(isSeparatorHidden: true) : ()
    UIView.animate(withDuration: AnimationTime.quiteFast.rawValue, animations: {
      self.view.layoutIfNeeded()
    }, completion: { _ in
      !isShow ? self.navigationViewContainer?.isHidden = true : ()
      !isShow ? self.updateNativeNavigationBar(isSeparatorHidden: false) : ()
      self.moreButton.isUserInteractionEnabled = true
    })
  }

  // MARK: - Landscape Custom Layout Private Methods

  private func performDeviceOrientation() {
    UIDevice.current.orientation.isLandscape ? performLandscapeOrientationLayout() : performPortraitOrientationLayout()
  }

  private func performPortraitOrientationLayout() {
    guard navigationItem.rightBarButtonItems?.count == Const.Chart.maxRightBarButtonItems else { return }
    setupPortraitRightNavigationButtons()
    updateFullViewMode(active: false, fromRotation: true)
  }

  private func performLandscapeOrientationLayout() {
    guard navigationItem.rightBarButtonItems?.count != Const.Chart.maxRightBarButtonItems else { return }
    setupLandscapeRightNavigationButtons()
    !isDrawToolEnable ? updateFullViewMode(active: true, fromRotation: true) : hideNavigationViewWithoutAnimtation()
  }

  private func updateFullViewMode(active: Bool, fromRotation: Bool) {
    active ? hideFullViewModeViews() : ()
    navigationController?.setNavigationBarHidden(active, animated: true)
    extendedLayoutIncludesOpaqueBars = active
    edgesForExtendedLayout = .all
    floatingFullViewButton?.isHidden = !active
    isFullViewModeActive = active
    DispatchQueue.main.asyncAfter(deadline: .now() + AnimationTime.default.rawValue) {
      self.chartIQView.resizeChart()
      DispatchQueue.main.asyncAfter(deadline: .now() + AnimationTime.default.rawValue) {
        self.chartIQView.resizeChart()
      }
    }
  }

  private func hideFullViewModeViews() {
    chartIQView.enableCrosshairs(false)
    chartIQView.disableDrawing()
    hideNavigationViewWithoutAnimtation()
    crosshairButton.setImage(UIImage.Chart.crosshairInactiveImage, for: .normal)
    drawToolButton.setImage(UIImage.Chart.drawToolInactiveImage, for: .normal)
    [crosshairInfoViewContainer, horizontalPickerViewContainer, drawToolControlViewContainer,
     undoRedoViewContainer].forEach { container in
      container?.isHidden = true
    }
    selectedDrawTool = nil
    isDrawToolEnable = false
    isDrawToolControlViewHidden = true
    isHorizontalPickerViewHidden = true
    measureInfoView.isHidden = true
    crosshairInfoViewTopConstraint.constant = -Const.CrosshairInfoView.height
    horizontalPickerViewBottomConstraint.constant = -Const.HorizontalPickerView.height
    drawToolControlViewBottomConstraint.constant = -Const.DrawToolControlView.height
    view.layoutIfNeeded()
  }
}

// MARK: - ChartIQDataSource

extension ChartViewController: ChartIQDataSource {

  public func pullInitialData(by params: ChartIQQuoteFeedParams, completionHandler: @escaping ([ChartIQData]) -> Void) {
    updateTheme()
    dataSimulatorService.loadChartData(withParameters: params, controller: self) { chartIQDataArray in
      completionHandler(chartIQDataArray)
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0, execute: {
        self.chartIQLoadedInitialData()
      })
    }
  }

  public func pullUpdateData(by params: ChartIQQuoteFeedParams, completionHandler: @escaping ([ChartIQData]) -> Void) {
    dataSimulatorService.loadChartData(withParameters: params, controller: self, completionHandler: completionHandler)
  }

  public func pullPaginationData(by params: ChartIQQuoteFeedParams, completionHandler: @escaping ([ChartIQData]) -> Void) {
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
    updateChartStyle()
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
    guard let indexPath = selectedDrawToolIndexPath, let color = item.selectedColor,
          let viewModel = drawToolViewModels[indexPath.row] as? DrawToolColorViewModel else { return }
    viewModel.color = color
    drawToolViewModels.replace(object: viewModel, atIndex: indexPath.row)
    chartIQView.setDrawingParameter(type, value: color.toHexString())
  }

  private func didSelectLine(item: PickerViewItem) {
    guard let indexPath = selectedDrawToolIndexPath, let line = item.selectedLine,
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
