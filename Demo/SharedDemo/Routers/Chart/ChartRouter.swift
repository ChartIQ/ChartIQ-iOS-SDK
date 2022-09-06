//
//  ChartRouter.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - Chart Router Destination Enum

enum ChartRouterDestination {
  case symbols
  case series
  case signals
  case intervals
  case drawingTools
  case chartStyle
  case studies
  case settings
  case drawToolSettings
}

// MARK: - Router Transition Enum

enum RouterTransition {
  case push
  case present
}

// MARK: - Chart Router Output Protocol

protocol ChartRouterOutputProtocol {
  func route(to destination: ChartRouterDestination, as transition: RouterTransition)
}

// MARK: - Chart Router Input Protocol

protocol ChartRouterInputProtocol: AnyObject {
  var chartIQView: ChartIQView! { get set }
  var selectedSymbol: SymbolModel? { get set }
  var selectedDrawTool: DrawToolViewModel? { get set }
  var selectedInterval: IntervalModel? { get set }
  var selectedChartStyle: ChartStyleModel? { get set }

  func showDrawToolControlView()
  func hideDrawToolControlView()
  func updateChartStyle()
  func updateSymbol()
  func updateInterval()
}

// MARK: - Chart Router

class ChartRouter {

  // MARK: - Internal Properties

  /// The root controller of this router
  internal weak var root: ChartViewController!

  /// The input protocol of this router
  internal var input: ChartRouterInputProtocol!

  init(rootViewController: ChartViewController) {
    self.root = rootViewController
    self.input = rootViewController
  }
}

// MARK: - Chart Router Output Protocol Extension

extension ChartRouter: ChartRouterOutputProtocol {

  // MARK: - Internal Methods

  internal func route(to destination: ChartRouterDestination, as transition: RouterTransition) {
    switch destination {
    case .symbols:
      presentSearchSymbolsViewController(with: transition)
    case .series:
      presentSeriesViewController(with: transition)
    case .signals:
        presentSignalsViewController(with: transition)
    case .intervals:
      presentIntervalsViewController(with: transition)
    case .drawingTools:
      presentDrawingToolsViewController(with: transition)
    case .chartStyle:
      presentChartStyleViewController(with: transition)
    case .studies:
      presentStudiesViewController(with: transition)
    case .settings:
      presentSettingsViewController(with: transition)
    case .drawToolSettings:
      pushDrawToolSettingsViewController(with: transition)
    }
  }

  // MARK: - Private Methods

  private func presentSearchSymbolsViewController(with transition: RouterTransition) {
    guard let controller = UIStoryboard.searchSymbolsViewController() else { return }
    controller.didSelectSymbol = { [weak self] symbol in
      guard let self = self else { return }
      self.input?.selectedSymbol = symbol
      self.input?.chartIQView.loadChart(symbol.name)
      self.input?.updateSymbol()
    }
    openController(controller, with: transition)
  }

  private func presentSeriesViewController(with transition: RouterTransition) {
    guard let controller = UIStoryboard.seriesViewController() else { return }
    controller.chartIQView = input?.chartIQView
    openController(controller, with: transition)
  }

  private func presentSignalsViewController(with transition: RouterTransition) {
    guard let controller = UIStoryboard.signalsViewController() else { return }
    controller.chartIQView = input?.chartIQView
    openController(controller, with: transition)
  }

  internal func presentIntervalsViewController(with transition: RouterTransition) {
    guard let controller = UIStoryboard.intervalsViewController() else { return }
    controller.selectedInterval = input?.selectedInterval
    controller.didSelectInterval = { [weak self] interval in
      guard let self = self else { return }
      self.input?.selectedInterval = interval
      self.input?.chartIQView.setPeriodicity(interval.getPeriod(),
                                             interval: interval.getInterval(),
                                             timeUnit: interval.getTimeUnit())
      self.input?.updateInterval()
    }
    openController(controller, with: transition)
  }

  private func presentDrawingToolsViewController(with transition: RouterTransition) {
    guard let controller = UIStoryboard.drawToolsViewController() else { return }
    controller.selectedDrawTool = input?.selectedDrawTool
    controller.didSelectDrawTool = { [weak self] drawTool in
      guard let self = self else { return }
      self.input?.selectedDrawTool = drawTool
      self.input?.showDrawToolControlView()
    }
    controller.didClearAllDrawings = { [weak self] in
      guard let self = self else { return }
      self.input?.chartIQView.clearDrawing()
      self.input?.hideDrawToolControlView()
    }
    controller.didRestoreToDefaults = { [weak self] in
      guard let self = self else { return }
      self.input?.chartIQView.restoreDefaultDrawingConfig(.line, all: true)
      self.input?.showDrawToolControlView()
    }
    openController(controller, with: transition)
  }

  private func presentChartStyleViewController(with transition: RouterTransition) {
    guard let controller = UIStoryboard.chartStyleViewController() else { return }
    controller.isPresented = true
    controller.selectedChartStyle = input?.selectedChartStyle
    controller.didSelectChartStyle = { [weak self] chartStyle in
      guard let self = self else { return }
      self.input?.selectedChartStyle = chartStyle
      if let chartType = chartStyle.chartType {
        self.input?.chartIQView.setChartType(chartType)
      } else if let chartAggregationType = chartStyle.chartAggregationType {
        self.input?.chartIQView.setAggregationType(chartAggregationType)
      }
      self.input?.updateChartStyle()
    }
    openController(controller, with: transition)
  }

  private func presentStudiesViewController(with transition: RouterTransition) {
    guard let controller = UIStoryboard.studiesViewController() else { return }
    controller.isPresented = true
    controller.chartIQView = input?.chartIQView
    openController(controller, with: transition)
  }

  private func presentSettingsViewController(with transition: RouterTransition) {
    guard let controller = UIStoryboard.settingsViewController() else { return }
    controller.isPresented = true
    controller.isShowChartStyle = false
    controller.chartIQView = input?.chartIQView
    openController(controller, with: transition)
  }

  private func pushDrawToolSettingsViewController(with transition: RouterTransition) {
    guard let controller = UIStoryboard.drawToolSettingsViewController() else { return }
    controller.selectedDrawTool = input?.selectedDrawTool
    controller.chartIQView = input?.chartIQView
    openController(controller, with: transition)
  }

  // MARK: - Private Helper Methods

  private func openController(_ controller: UIViewController, with transition: RouterTransition) {
    switch transition {
    case .push:
      pushController(controller: controller)
    case .present:
      presentController(controller: controller)
    }
  }

  private func presentController(controller: UIViewController) {
    let navigationController = NavigationController(rootViewController: controller)
    root.present(navigationController, animated: true, completion: nil)
  }

  private func pushController(controller: UIViewController) {
    root.navigationController?.show(controller, sender: nil)
  }
}
