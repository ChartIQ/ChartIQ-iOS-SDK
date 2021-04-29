//
//  RootNavigationController.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - RootNavigation Controller

class RootNavigationController: UINavigationController {

  // MARK: - Internal Properties

  internal var chartIQView: ChartIQView!

  // MARK: - Private Properties

  private let locManager = LocalizationManager.shared()

  // MARK: - Controller Lifecycle Methods

  override func viewDidLoad() {
    super.viewDidLoad()

    setupUI()
    setupSettings()
  }

  // MARK: - Setup Methods

  private func setupUI() {
    navigationBar.isTranslucent = true
    navigationBar.tintColor = .mountainMeadowColor
    navigationBar.barTintColor = .ghostWhiteСhineseBlackColor
    navigationBar.backgroundColor = .ghostWhiteСhineseBlackColor
    navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
  }

  private func setupSettings() {
    chartIQView = ChartIQView(frame: CGRect.zero)
    guard let chartController = UIStoryboard.chartViewController() else { return }
    locManager.setChartIQView(chartIQView)
    chartController.chartIQView = chartIQView
    viewControllers = [chartController]
  }
}
