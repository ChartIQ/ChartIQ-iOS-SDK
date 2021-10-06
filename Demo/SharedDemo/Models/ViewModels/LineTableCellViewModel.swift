//
//  LineTableCellViewModel.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - LineTableCell ViewModel

class LineTableCellViewModel: TableCellViewModelProtocol {

  // MARK: - Internal Properties

  internal var title: String
  internal var lineModel: LineModel

  // MARK: - Init

  init(title: String, lineModel: LineModel) {
    self.title = title
    self.lineModel = lineModel
  }
}
