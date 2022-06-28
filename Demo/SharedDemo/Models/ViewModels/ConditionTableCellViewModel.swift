//
//  ConditionTableCellViewModel.swift
//  ChartIQDemo
//
//  Copyright 2012-2022 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - ConditionJoinerType Enum

enum ConditionJoinerType: Int {
  case or
  case and

  internal var title: String {
    switch self {
    case .or:
      return "Or"
    case .and:
      return "And"
    }
  }

  internal var signalJoiner: ChartIQSignalJoiner? {
    switch self {
    case .or:
      return .or
    case .and:
      return .and
    }
  }
}

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
  internal var joinerType: ConditionJoinerType

  // MARK: - Init

  init(title: String,
       description: String,
       tagMark: String,
       color: UIColor,
       segmentType: ConditionSegmentType,
       joinerType: ConditionJoinerType) {
    self.title = title
    self.description = description
    self.tagMark = tagMark
    self.color = color
    self.segmentType = segmentType
    self.joinerType = joinerType
  }
}
