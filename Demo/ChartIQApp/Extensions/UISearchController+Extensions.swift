//
//  UISearchController+Extensions.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - UISearchController Extension

extension UISearchController {

  // MARK: - Internal Methods

  internal func defaultConfiguration() {
    obscuresBackgroundDuringPresentation = false
    hidesNavigationBarDuringPresentation = false
    searchBar.defaultConfiguration()
  }
}
