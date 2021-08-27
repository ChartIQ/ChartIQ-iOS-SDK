//
//  PickerViewItem.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - PickerViewItem Model

struct PickerViewItem {

  // MARK: - Internal Properties

  internal let selectedColor: UIColor?
  internal let selectedLine: LineModel?

  // MARK: - Init

  init(selectedColor: UIColor?, selectedLine: LineModel?) {
    self.selectedColor = selectedColor
    self.selectedLine = selectedLine
  }
}
