//
//  TextTableCellViewModel.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - TextTableCell ViewModel

class TextTableCellViewModel: TableCellViewModelProtocol {

  // MARK: - Internal Properties

  internal var title: String
  internal var text: String?
  internal var placeholder: String?

  // MARK: - Init

  init(title: String, text: String?, placeholder: String? = nil) {
    self.title = title
    self.text = text
    self.placeholder = placeholder
  }
}
