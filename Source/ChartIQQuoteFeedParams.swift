//
//  ChartIQQuoteFeedParams.swift
//  ChartIQ
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import Foundation

/// Encapsulates parameters with additional information for the data requested by the chart.
public class ChartIQQuoteFeedParams: NSObject {

  // MARK: - Properties

  /// The ChartIQQuoteFeedParams symbol parameter.
  public var symbol: String

  /// The ChartIQQuoteFeedParams startDate parameter.
  public var startDate: String

  /// The ChartIQQuoteFeedParams endDate parameter.
  public var endDate: String

  /// The ChartIQQuoteFeedParams interval parameter.
  public var interval: String

  /// The ChartIQQuoteFeedParams period parameter.
  public var period: Int

  // MARK: - Initializers

  /// Init QuoteFeedParams model with all parameters.
  ///
  /// - Parameters:
  ///   - symbol: The String Object.
  ///   - startDate: The String Object.
  ///   - endDate: The String Object.
  ///   - interval: The String Object.
  ///   - period: The Int Object.
  public init(symbol: String, startDate: String, endDate: String, interval: String, period: Int) {
    self.symbol = symbol
    self.startDate = startDate
    self.endDate = endDate
    self.interval = interval
    self.period = period
  }

  /// Init QuoteFeedParams model with dictionary parameter.
  ///
  /// - Parameters:
  ///   - dictionary: The dictionary with data for init QuoteFeedParams model.
  public init(dictionary: [String: Any]) {
    self.symbol = dictionary[Const.QuoteFeed.symbolParam] as? String ?? ""
    self.startDate = dictionary[Const.QuoteFeed.startDateParam] as? String ?? ""
    self.endDate = dictionary[Const.QuoteFeed.endDateParam] as? String ?? ""
    self.interval = dictionary[Const.QuoteFeed.intervalParam] as? String ?? ""
    self.period = dictionary[Const.QuoteFeed.periodParam] as? Int ?? 0
  }
}
