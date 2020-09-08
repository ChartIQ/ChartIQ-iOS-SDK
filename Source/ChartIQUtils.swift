//
//  ChartIQUtils.swift
//  ChartIQ
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import Foundation

// MARK: - ChartIQUtils

/// Chart utils.
internal class ChartIQUtils {

  // MARK: - Properties

  /// ChartIQ date formatter.
  internal static var chartDateFormatter: DateFormatter {
    let defaultDateFormatter = DateFormatter()
    defaultDateFormatter.timeZone = TimeZone(identifier: "UTC")
    defaultDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sss'Z'"
    defaultDateFormatter.locale = Locale(identifier: "en")
    return defaultDateFormatter
  }
}
