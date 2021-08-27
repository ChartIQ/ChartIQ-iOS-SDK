//
//  SelectTableCellViewModel.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - SelectTableCell ViewModel

class SelectTableCellViewModel: TableCellViewModelProtocol {

  // MARK: - Internal Properties

  internal var title: String
  internal var detailTitle: String?

  // MARK: - Init

  init(title: String, detailTitle: String? = nil) {
    self.title = title
    self.detailTitle = detailTitle
  }
}
