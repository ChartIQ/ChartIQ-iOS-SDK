//
//  Array+Extensions.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import Foundation

// MARK: - Array Extensions

extension Array {

  // MARK: - Internal Methods

  internal mutating func replace(object: Element, atIndex index: Int) {
    remove(at: index)
    insert(object, at: index)
  }
}
