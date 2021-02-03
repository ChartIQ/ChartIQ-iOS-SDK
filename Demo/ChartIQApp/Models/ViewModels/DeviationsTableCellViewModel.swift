//
//  DeviationsTableCellViewModel.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - DeviationsTableCell ViewModel

class DeviationsTableCellViewModel: TableCellViewModelProtocol {

  // MARK: - Internal Properties

  internal var title: String
  internal var deviationModels: [DeviationModel]

  // MARK: - Init

  init(title: String, deviationModels: [DeviationModel]) {
    self.title = title
    self.deviationModels = deviationModels
  }
}
