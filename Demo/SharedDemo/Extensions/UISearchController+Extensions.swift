//
//  UISearchController+Extensions.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - UISearchController Extensions

extension UISearchController {

  // MARK: - Internal Methods

  internal func defaultConfiguration() {
    obscuresBackgroundDuringPresentation = false
    hidesNavigationBarDuringPresentation = false
    searchBar.defaultConfiguration()
  }
}
