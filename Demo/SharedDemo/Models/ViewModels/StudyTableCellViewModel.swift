//
//  StudyTableCellViewModel.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - StudyTableCell ViewModel

class StudyTableCellViewModel: TableCellViewModelProtocol {

  // MARK: - Internal Properties

  internal var title: String
  internal var detailTitle: String

  // MARK: - Init

  init(title: String, detailTitle: String) {
    self.title = title
    self.detailTitle = detailTitle
  }

  init(study: ChartIQStudy) {
    self.title = LocalizationManager.shared().localize(study.name)
    self.detailTitle = study.nameParams.replace(" ", with: "")
  }
}
