//
//  IntervalModel.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - TimeUnit Enum

enum TimeUnit: String, CaseIterable, Codable {

  case tick
  case millisecond
  case second
  case minute
  case hour
  case day
  case week
  case month

  internal var fullDisplayName: String {
    switch self {
    case .tick:
      return LocalizationManager.shared().localize(Const.IntervalModel.tickTitle)
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
    case .tick:
      return LocalizationManager.shared().localize(Const.IntervalModel.tickShortTitle)
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

  internal init(chartIQTimeUnit: ChartIQTimeUnit) {
    switch chartIQTimeUnit {
    case .tick:
      self = .tick
    case .millisecond:
      self = .millisecond
    case .second:
      self = .second
    case .minute:
      self = .minute
    case .day:
      self = .day
    case .week:
      self = .week
    case .month:
      self = .month
    }
  }
}

// MARK: - Interval Model

struct IntervalModel: Equatable, Codable {

  // MARK: - Internal Properties

  internal let periodicity: Int
  internal let interval: Int
  internal let timeUnit: TimeUnit

  // MARK: - Init

  init(periodicity: Int, interval: Int, timeUnit: TimeUnit) {
    self.periodicity = periodicity
    self.interval = interval
    self.timeUnit = timeUnit
  }

  init(periodicity: Int, interval: String, chartIQTimeUnit: ChartIQTimeUnit?) {
    if let chartIQTimeUnit = chartIQTimeUnit {
      guard let intInterval = Int(interval) else {
        fatalError("If we receive timeUnit, we must receive interval as int!")
      }
      self.interval = intInterval
      self.periodicity = periodicity
      if (intInterval * periodicity) % 60 == 0 {
        // Display the periodicity as hours
        self.timeUnit = .hour
      } else {
        self.timeUnit = TimeUnit(chartIQTimeUnit: chartIQTimeUnit)
      }
    } else {
      self.interval = 1
      self.periodicity = periodicity
      self.timeUnit = TimeUnit(rawValue: interval)!
    }
  }

  // MARK: - Internal Methods

  internal func getFullDisplayName() -> String {
    var fullPeriodicity = interval * periodicity
    if timeUnit == .hour {
      fullPeriodicity /= 60
    }
    return "\(fullPeriodicity) \(timeUnit.fullDisplayName)"
  }

  internal func getShortDisplayName() -> String {
    var fullPeriodicity = interval * periodicity
    if timeUnit == .hour {
      fullPeriodicity /= 60
    }
    return "\(fullPeriodicity)\(timeUnit.shortDisplayName)"
  }

  internal func getPeriod() -> Int {
    return periodicity
  }

  internal func getInterval() -> String {
    return "\(interval)"
  }

  internal func getTimeUnit() -> ChartIQTimeUnit {
    switch timeUnit {
    case .tick:
      return  ChartIQTimeUnit.tick
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
