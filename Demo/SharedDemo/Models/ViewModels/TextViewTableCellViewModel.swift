//
//  TextViewTableCellViewModel.swift
//  ChartIQDemo
//
//  Copyright 2012-2022 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - TextViewTableCell ViewModel

class TextViewTableCellViewModel: TableCellViewModelProtocol {

  // MARK: - Internal Properties

  internal var title: String
  internal var text: String?
  internal var placeholder: String

  // MARK: - Init

  init(title: String, text: String?, placeholder: String) {
    self.title = title
    self.text = text
    self.placeholder = placeholder
  }
}
