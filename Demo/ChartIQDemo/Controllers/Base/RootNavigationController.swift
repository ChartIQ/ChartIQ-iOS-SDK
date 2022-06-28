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

    setupScrollEdgeAppearance()
  }

  private func setupSettings() {
    chartIQView = ChartIQView(frame: CGRect.zero)
    guard let chartController = UIStoryboard.chartViewController() else { return }
    locManager.setChartIQView(chartIQView)
    chartController.chartIQView = chartIQView
    viewControllers = [chartController]
  }

  /// In iOS 15, UIKit has extended the usage of the scrollEdgeAppearance,
  /// which by default produces a transparent background, to all navigation bars.
  /// The background is controlled by when we scroll view scrolls content behind the navigation bar.
  /// To restore the old look, we must adopt the new UINavigationBar appearance APIs.
  /// The last line navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance,
  /// which resolves the issue by having the UINavigationBar use the same appearance
  /// for both its standard and edge states.
  private func setupScrollEdgeAppearance() {
    if #available(iOS 15.0, *) {
      navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
    }
  }
}
