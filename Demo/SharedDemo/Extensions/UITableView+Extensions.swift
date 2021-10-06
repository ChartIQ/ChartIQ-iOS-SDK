//
//  UITableView+Extensions.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - UITableView Extensions

extension UITableView {

  // MARK: - Internal Methods

  internal func register(nibName: String, cellId: String) {
    register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: cellId)
  }
}
