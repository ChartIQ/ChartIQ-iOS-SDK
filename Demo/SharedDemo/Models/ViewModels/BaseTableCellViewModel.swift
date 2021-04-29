//
//  BaseTableCellViewModel.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - BaseTableCell ViewModel

class BaseTableCellViewModel: TableCellViewModelProtocol {

  // MARK: - Internal Properties

  internal var title: String
  internal var image: UIImage?

  // MARK: - Init

  init(title: String, image: UIImage? = nil) {
    self.title = title
    self.image = image
  }
}
