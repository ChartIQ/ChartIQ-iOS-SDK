//
//  UITableView+Extensions.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - UITableView Extension

extension UITableView {

  // MARK: - Internal Methods

  internal func register(nibName: String, cellId: String) {
    register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: cellId)
  }
}
