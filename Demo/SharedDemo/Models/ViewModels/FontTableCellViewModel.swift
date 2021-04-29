//
//  FontTableCellViewModel.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - FontTableCell ViewModel

class FontTableCellViewModel: TableCellViewModelProtocol {

  // MARK: - Internal Properties

  internal var title: String
  internal var isBoldSelected: Bool
  internal var isItalicSelected: Bool

  // MARK: - Init

  init(title: String, isBoldSelected: Bool, isItalicSelected: Bool) {
    self.title = title
    self.isBoldSelected = isBoldSelected
    self.isItalicSelected = isItalicSelected
  }
}
