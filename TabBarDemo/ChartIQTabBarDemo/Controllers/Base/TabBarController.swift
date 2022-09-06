//
//  TabBarController.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - TabBar Controller

class TabBarController: UITabBarController {

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
    tabBar.isTranslucent = true
    tabBar.tintColor = .mountainMeadowColor
    tabBar.barTintColor = .ghostWhiteСhineseBlackColor
    tabBar.backgroundColor = .ghostWhiteСhineseBlackColor
    tabBar.backgroundImage = UIImage()
    tabBar.unselectedItemTintColor = .cadetBlueColor

    setupScrollEdgeAppearance()
  }

  private func setupSettings() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(languageDidChange),
                                           name: Const.LocalizationManager.languageChangedNotification,
                                           object: nil)
    chartIQView = ChartIQView(frame: CGRect.zero)
    guard let chartController = UIStoryboard.chartViewController(),
          let studiesController = UIStoryboard.studiesViewController(),
          let settingsController = UIStoryboard.settingsViewController() else { return }
    locManager.setChartIQView(chartIQView)
    chartController.chartIQView = chartIQView
    studiesController.chartIQView = chartIQView
    settingsController.chartIQView = chartIQView
    chartController.tabBarItem = UITabBarItem(title: locManager.localize(Const.TabBar.chartItemTitle),
                                              image: UIImage.TabBar.chartItemImage,
                                              tag: 1)
    studiesController.tabBarItem = UITabBarItem(title: locManager.localize(Const.TabBar.studiesItemTitle),
                                                image: UIImage.TabBar.studiesItemImage,
                                                tag: 2)
    settingsController.tabBarItem = UITabBarItem(title: locManager.localize(Const.TabBar.settingsItemTitle),
                                                 image: UIImage.TabBar.settingsItemImage,
                                                 tag: 3)
    let controllers = [chartController, studiesController, settingsController]
    viewControllers = controllers.map { NavigationController(rootViewController: $0) }
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
      let appearance = UITabBarAppearance()
      appearance.configureWithOpaqueBackground()
      appearance.backgroundColor = .ghostWhiteСhineseBlackColor
      tabBar.standardAppearance = appearance
      tabBar.scrollEdgeAppearance = tabBar.standardAppearance
    }
  }

  // MARK: - Private Methods

  @objc private func languageDidChange() {
    guard let tabBarItems = tabBar.items, tabBarItems.count == 3 else { return }
    tabBarItems[0].title = locManager.localize(Const.TabBar.chartItemTitle)
    tabBarItems[1].title = locManager.localize(Const.TabBar.studiesItemTitle)
    tabBarItems[2].title = locManager.localize(Const.TabBar.settingsItemTitle)
  }
}
