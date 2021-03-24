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

enum TimeUnit: String, CaseIterable, Codable {

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

  internal init(chartIQTimeUnit: ChartIQTimeUnit) {
    switch chartIQTimeUnit {
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

  internal let time: Int
  internal let timeUnit: TimeUnit

  // MARK: - Init

  init(time: Int, timeUnit: TimeUnit) {
    self.time = time
    self.timeUnit = timeUnit
  }

  init(periodicity: Int, interval: String, chartIQTimeUnit: ChartIQTimeUnit?) {
    var updatedPeriodicity = periodicity
    var updatedInterval = interval
    if let chartIQTimeUnit = chartIQTimeUnit {
      guard let intInterval = Int(interval) else {
        fatalError("If we receive timeUnit, we must receive interval as int!")
      }

      switch chartIQTimeUnit {
      case .millisecond, .second, .minute, .day, .week, .month:
        updatedPeriodicity = intInterval
        updatedInterval = String(periodicity)
      default:
        break
      }

      guard let updatedIntInterval = Int(updatedInterval) else {
        fatalError("If we receive timeUnit, we must receive interval as int!")
      }

      if updatedPeriodicity > 1 && chartIQTimeUnit == .minute {
        // Calculating Hours
        self.time = periodicity * intInterval / 60
        self.timeUnit = .hour
      } else {
        // Use ChartIQTimeUnit and Interval
        self.time = updatedIntInterval
        self.timeUnit = TimeUnit(chartIQTimeUnit: chartIQTimeUnit)
      }
    } else {
      self.time = updatedPeriodicity
      self.timeUnit = TimeUnit(rawValue: updatedInterval)!
    }
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
      return calculatePeriod()
    } else {
      return calculateInterval()
    }
  }

  internal func getInterval() -> String {
    if timeUnit == .hour {
      return "\(calculateInterval())"
    } else {
      return "\(calculatePeriod())"
    }
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

  // MARK: - Private Methods

  private func calculatePeriod() -> Int {
    if timeUnit == .hour {
      return time * 2
    } else {
      return 1
    }
  }

  private func calculateInterval() -> Int {
    let interval = timeUnit == .hour ? 30 : time
    return interval
  }
}
