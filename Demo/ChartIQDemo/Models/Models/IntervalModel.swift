//
//  IntervalModel.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - TimeUnit Enum

enum TimeUnit: CaseIterable {
  case millisecond
  case second
  case minute
  case hour
  case day
  case week
  case month

  internal var fullDisplayName: String {
    switch self {
    case .millisecond:
      return LocalizationManager.shared().localize(Const.IntervalModel.millisecondTitle)
    case .second:
      return LocalizationManager.shared().localize(Const.IntervalModel.secondTitle)
    case .minute:
      return LocalizationManager.shared().localize(Const.IntervalModel.minuteTitle)
    case .hour:
      return LocalizationManager.shared().localize(Const.IntervalModel.hourTitle)
    case .day:
      return LocalizationManager.shared().localize(Const.IntervalModel.dayTitle)
    case .week:
      return LocalizationManager.shared().localize(Const.IntervalModel.weekTitle)
    case .month:
      return LocalizationManager.shared().localize(Const.IntervalModel.monthTitle)
    }
  }

  internal var shortDisplayName: String {
    switch self {
    case .millisecond:
      return LocalizationManager.shared().localize(Const.IntervalModel.millisecondShortTitle)
    case .second:
      return LocalizationManager.shared().localize(Const.IntervalModel.secondShortTitle)
    case .minute:
      return LocalizationManager.shared().localize(Const.IntervalModel.minuteShortTitle)
    case .hour:
      return LocalizationManager.shared().localize(Const.IntervalModel.hourShortTitle)
    case .day:
      return LocalizationManager.shared().localize(Const.IntervalModel.dayShortTitle)
    case .week:
      return LocalizationManager.shared().localize(Const.IntervalModel.weekShortTitle)
    case .month:
      return LocalizationManager.shared().localize(Const.IntervalModel.monthShortTitle)
    }
  }
}

// MARK: - Interval Model

struct IntervalModel: Equatable {

  // MARK: - Internal Properties

  internal let time: Int
  internal let timeUnit: TimeUnit

  // MARK: - Init

  init(time: Int, timeUnit: TimeUnit) {
    self.time = time
    self.timeUnit = timeUnit
  }

  // MARK: - Internal Methods

  internal func getFullDisplayName() -> String {
    return "\(time) \(timeUnit.fullDisplayName)"
  }

  internal func getShortDisplayName() -> String {
    return "\(time)\(timeUnit.shortDisplayName)"
  }

  internal func getPeriod() -> Int {
    if timeUnit == .hour {
      return time * 2
    } else {
      return 1
    }
  }

  internal func getInterval() -> String {
    let interval = timeUnit == .hour ? 30 : time
    return "\(interval)"
  }

  internal func getTimeUnit() -> ChartIQTimeUnit {
    switch timeUnit {
    case .millisecond:
      return ChartIQTimeUnit.millisecond
    case .second:
      return ChartIQTimeUnit.second
    case .minute:
      return ChartIQTimeUnit.minute
    case .hour:
      return ChartIQTimeUnit.minute
    case .day:
      return ChartIQTimeUnit.day
    case .week:
      return ChartIQTimeUnit.week
    case .month:
      return ChartIQTimeUnit.month
    }
  }
}
