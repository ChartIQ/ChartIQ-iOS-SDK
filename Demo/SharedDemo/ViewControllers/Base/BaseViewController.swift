//
//  BaseViewController.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - Base ViewController

class BaseViewController: UIViewController {

  // MARK: - ViewController Lifecycle Methods

  override func viewDidLoad() {
    super.viewDidLoad()

    setupBaseUI()
    setupBaseSettings()

    setupUI()
    setupSettings()
  }

  // MARK: - Setup Methods

  private func setupBaseUI() {
    view.backgroundColor = .ghostWhiteСhineseBlackColor
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
  }

  private func setupBaseSettings() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(languageDidChange),
                                           name: Const.LocalizationManager.languageChangedNotification,
                                           object: nil)
  }

  // MARK: Override Methods

  func setupUI() {}
  func setupSettings() {}

  @objc func languageDidChange() {}

  // MARK: Deinit

  deinit {
    debugPrint(String(describing: self))
  }
}
