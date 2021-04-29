//
//  TextColorTableCellViewModel.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - TextColorTableCell ViewModel

class TextColorTableCellViewModel: TableCellViewModelProtocol {

  // MARK: - Internal Properties

  internal var title: String
  internal var number: Int
  internal var color: UIColor

  // MARK: - Init

  init(title: String, number: Int, color: UIColor) {
    self.title = title
    self.number = number
    self.color = color
  }
}
