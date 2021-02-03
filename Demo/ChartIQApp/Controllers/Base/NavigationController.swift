//
//  NavigationController.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - Navigation Controller

class NavigationController: UINavigationController {

  // MARK: - Controller Lifecycle Methods

  override func viewDidLoad() {
    super.viewDidLoad()

    setupUI()
    setupSettings()
  }

  // MARK: - Setup Methods

  func setupUI() {
    navigationBar.isTranslucent = true
    navigationBar.tintColor = .mountainMeadowColor
    navigationBar.barTintColor = .ghostWhiteСhineseBlackColor
    navigationBar.backgroundColor = .ghostWhiteСhineseBlackColor
    navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
  }

  func setupSettings() {}
}
