//
//  UIStoryboard+Extensions.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - Storyboard Enum

enum Storyboard: String {
  case base = "Main"
  case chart = "Chart"
  case studies = "Studies"
  case settings = "Settings"
  case common = "Common"
}

// MARK: - UIStoryboard Controllers Extension

extension UIStoryboard {

  // MARK: - Internal Base Methods

  // MARK: - Internal Chart Methods

  internal static func chartViewController() -> ChartViewController? {
    guard let controller = UIStoryboard.viewController(ChartViewController.self,
                                                       from: .chart) as? ChartViewController else { return nil }
    return controller
  }

  internal static func drawToolsViewController() -> DrawToolsViewController? {
    guard let controller = UIStoryboard.viewController(DrawToolsViewController.self,
                                                       from: .chart) as? DrawToolsViewController else { return nil }
    return controller
  }

  internal static func drawToolSettingsViewController() -> DrawToolSettingsViewController? {
    guard let controller = UIStoryboard.viewController(DrawToolSettingsViewController.self,
                                                       from: .chart) as? DrawToolSettingsViewController else { return nil }
    return controller
  }

  internal static func fibSettingsViewController() -> FibSettingsViewController? {
    guard let controller = UIStoryboard.viewController(FibSettingsViewController.self,
                                                       from: .chart) as? FibSettingsViewController else { return nil }
    return controller
  }

  internal static func deviationsViewController() -> DeviationsViewController? {
    guard let controller = UIStoryboard.viewController(DeviationsViewController.self,
                                                       from: .chart) as? DeviationsViewController else { return nil }
    return controller
  }

  internal static func intervalsViewController() -> IntervalsViewController? {
    guard let controller = UIStoryboard.viewController(IntervalsViewController.self,
                                                       from: .chart) as? IntervalsViewController else { return nil }
    return controller
  }

  internal static func searchSymbolsViewController() -> SearchSymbolsViewController? {
    guard let controller = UIStoryboard.viewController(SearchSymbolsViewController.self,
                                                       from: .chart) as? SearchSymbolsViewController else { return nil }
    return controller
  }

  internal static func seriesViewController() -> SeriesViewController? {
    guard let controller = UIStoryboard.viewController(SeriesViewController.self,
                                                       from: .chart) as? SeriesViewController else { return nil }
    return controller
  }

  // MARK: - Internal Studies Methods

  internal static func studiesViewController() -> StudiesViewController? {
    guard let controller = UIStoryboard.viewController(StudiesViewController.self,
                                                       from: .studies) as? StudiesViewController else { return nil }
    return controller
  }

  internal static func allStudiesViewController() -> AllStudiesViewController? {
    guard let controller = UIStoryboard.viewController(AllStudiesViewController.self,
                                                       from: .studies) as? AllStudiesViewController else { return nil }
    return controller
  }

  internal static func studyDetailViewController() -> StudyDetailViewController? {
    guard let controller = UIStoryboard.viewController(StudyDetailViewController.self,
                                                       from: .studies) as? StudyDetailViewController else { return nil }
    return controller
  }

  // MARK: - Internal Settings Methods

  internal static func settingsViewController() -> SettingsViewController? {
    guard let controller = UIStoryboard.viewController(SettingsViewController.self,
                                                       from: .settings) as? SettingsViewController else { return nil }
    return controller
  }

  internal static func chartStyleViewController() -> ChartStyleViewController? {
    guard let controller = UIStoryboard.viewController(ChartStyleViewController.self,
                                                       from: .settings) as? ChartStyleViewController else { return nil }
    return controller
  }

  internal static func languagesViewController() -> LanguagesViewController? {
    guard let controller = UIStoryboard.viewController(LanguagesViewController.self,
                                                       from: .settings) as? LanguagesViewController else { return nil }
    return controller
  }

  // MARK: - Settings Common Methods

  internal static func fullScreenPickerViewController() -> FullScreenPickerViewController? {
    guard let controller = UIStoryboard.viewController(FullScreenPickerViewController.self,
                                                       from: .common) as? FullScreenPickerViewController else { return nil }
    return controller
  }

  internal static func selectOptionViewController() -> SelectOptionViewController? {
    guard let controller = UIStoryboard.viewController(SelectOptionViewController.self,
                                                       from: .common) as? SelectOptionViewController else { return nil }
    return controller
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
