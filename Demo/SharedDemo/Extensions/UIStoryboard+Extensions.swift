//
//  UIStoryboard+Extensions.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - Storyboard Enum

enum Storyboard: String {
  case base = "Main"
  case chart = "Chart"
  case drawTools = "DrawTools"
  case symbols = "Symbols"
  case intervals = "Intervals"
  case series = "Series"
  case studies = "Studies"
  case settings = "Settings"
  case common = "Common"
}

// MARK: - UIStoryboard Controller Extensions

extension UIStoryboard {

  // MARK: - Internal Base Methods

  // MARK: - Internal Chart Methods

  internal static func chartViewController() -> ChartViewController? {
    guard let controller = UIStoryboard.viewController(ChartViewController.self,
                                                       from: .chart) as? ChartViewController else { return nil }
    return controller
  }

  // MARK: - Internal Drawing Tools Methods

  internal static func drawToolsViewController() -> DrawToolsViewController? {
    let controller = UIStoryboard.viewController(DrawToolsViewController.self, from: .drawTools)
    guard let viewController = controller as? DrawToolsViewController else { return nil }
    return viewController
  }

  internal static func drawToolSettingsViewController() -> DrawToolSettingsViewController? {
    let controller = UIStoryboard.viewController(DrawToolSettingsViewController.self, from: .drawTools)
    guard let viewController = controller as? DrawToolSettingsViewController else { return nil }
    return viewController
  }

  internal static func fibSettingsViewController() -> FibSettingsViewController? {
    let controller = UIStoryboard.viewController(FibSettingsViewController.self, from: .drawTools)
    guard let viewController = controller as? FibSettingsViewController else { return nil }
    return viewController
  }

  internal static func deviationsViewController() -> DeviationsViewController? {
    let controller = UIStoryboard.viewController(DeviationsViewController.self, from: .drawTools)
    guard let viewController = controller as? DeviationsViewController else { return nil }
    return viewController
  }

  // MARK: - Internal Symbols Methods

  internal static func searchSymbolsViewController() -> SearchSymbolsViewController? {
    let controller = UIStoryboard.viewController(SearchSymbolsViewController.self, from: .symbols)
    guard let viewController = controller as? SearchSymbolsViewController else { return nil }
    return viewController
  }

  // MARK: - Internal Intervals Methods

  internal static func intervalsViewController() -> IntervalsViewController? {
    let controller = UIStoryboard.viewController(IntervalsViewController.self, from: .intervals)
    guard let viewController = controller as? IntervalsViewController else { return nil }
    return viewController
  }

  // MARK: - Internal Series Methods

  internal static func seriesViewController() -> SeriesViewController? {
    let controller = UIStoryboard.viewController(SeriesViewController.self, from: .series)
    guard let viewController = controller as? SeriesViewController else { return nil }
    return viewController
  }

  // MARK: - Internal Studies Methods

  internal static func studiesViewController() -> StudiesViewController? {
    let controller = UIStoryboard.viewController(StudiesViewController.self, from: .studies)
    guard let viewController = controller as? StudiesViewController else { return nil }
    return viewController
  }

  internal static func allStudiesViewController() -> AllStudiesViewController? {
    let controller = UIStoryboard.viewController(AllStudiesViewController.self, from: .studies)
    guard let viewController = controller as? AllStudiesViewController else { return nil }
    return viewController
  }

  internal static func studyDetailViewController() -> StudyDetailViewController? {
    let controller = UIStoryboard.viewController(StudyDetailViewController.self, from: .studies)
    guard let viewController = controller as? StudyDetailViewController else { return nil }
    return viewController
  }

  // MARK: - Internal Settings Methods

  internal static func settingsViewController() -> SettingsViewController? {
    let controller = UIStoryboard.viewController(SettingsViewController.self, from: .settings)
    guard let viewController = controller as? SettingsViewController else { return nil }
    return viewController
  }

  internal static func chartStyleViewController() -> ChartStyleViewController? {
    let controller = UIStoryboard.viewController(ChartStyleViewController.self, from: .settings)
    guard let viewController = controller as? ChartStyleViewController else { return nil }
    return viewController
  }

  internal static func languagesViewController() -> LanguagesViewController? {
    let controller = UIStoryboard.viewController(LanguagesViewController.self, from: .settings)
    guard let viewController = controller as? LanguagesViewController else { return nil }
    return viewController
  }

  // MARK: - Settings Common Methods

  internal static func fullScreenPickerViewController() -> FullScreenPickerViewController? {
    let controller = UIStoryboard.viewController(FullScreenPickerViewController.self, from: .common)
    guard let viewController = controller as? FullScreenPickerViewController else { return nil }
    return viewController
  }

  internal static func selectOptionViewController() -> SelectOptionViewController? {
    let controller = UIStoryboard.viewController(SelectOptionViewController.self, from: .common)
    guard let viewController = controller as? SelectOptionViewController else { return nil }
    return viewController
  }
}

// MARK: - UIStoryboard Instantiate Extension

extension UIStoryboard {

  // MARK: - Private Methods

  private static func viewController(_ vcClass: AnyClass, from name: Storyboard = .base) -> UIViewController {
    let className = String(describing: vcClass)
    let storyboard = UIStoryboard(name: name.rawValue, bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: className)
  }
}
