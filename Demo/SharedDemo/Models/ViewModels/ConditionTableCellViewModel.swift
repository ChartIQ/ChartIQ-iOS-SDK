//
//  ConditionTableCellViewModel.swift
//  ChartIQDemo
//
//  Copyright 2012-2022 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - ConditionSegmentType Enum

enum ConditionSegmentType: Int {
  case one
  case both
  case none
}

// MARK: - ConditionTableCell ViewModel

class ConditionTableCellViewModel: TableCellViewModelProtocol {

  // MARK: - Internal Properties

  internal var title: String
  internal var description: String
  internal var tagMark: String
  internal var color: UIColor
  internal var segmentType: ConditionSegmentType
  internal var joinerType: ChartIQSignalJoiner

  // MARK: - Init

  init(title: String,
       description: String,
       tagMark: String,
       color: UIColor,
       segmentType: ConditionSegmentType,
       joinerType: ChartIQSignalJoiner) {
    self.title = title
    self.description = description
    self.tagMark = tagMark
    self.color = color
    self.segmentType = segmentType
    self.joinerType = joinerType
  }
}
