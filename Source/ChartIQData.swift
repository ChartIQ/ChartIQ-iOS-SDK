//
//  ChartIQData.swift
//  ChartIQ
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import Foundation

/// Encapsulates parameters with additional information for formatted OHLC quote objects.
public class ChartIQData: NSObject {

  // MARK: - Properties

  /// The ChartIQData date parameter.
  public var date: Date

  /// The ChartIQData open parameter.
  public var open: Double?

  /// The ChartIQData high parameter.
  public var high: Double?

  /// The ChartIQData low parameter.
  public var low: Double?

  /// The ChartIQData close parameter.
  public var close: Double?

  /// The ChartIQData volume parameter.
  public var volume: Double?

  /// The ChartIQData adjClose parameter.
  public var adjClose: Double?

  // MARK: - Initializers

  /// Init Data model with all parameters.
  ///
  /// - Parameters:
  ///   - date: The Date Object.
  ///   - open: The Double Object.
  ///   - high: The Double Object.
  ///   - low: The Double Object.
  ///   - close: The Double Object.
  ///   - volume: The Double Object.
  ///   - adjClose: The Double Object.
  public init(date: Date, open: Double, high: Double, low: Double, close: Double, volume: Double, adjClose: Double) {
    self.date = date
    self.open = open
    self.high = high
    self.low = low
    self.close = close
    self.volume = volume
    self.adjClose = adjClose
  }

  /// Init Data model with dictionary.
  ///
  /// - Parameters:
  ///   - dictionary: The dictionary with data for init Data model.
  public init(dictionary: [String: Any]) {
    let dt = dictionary["DT"] as? String ?? ""
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    let close = dictionary["Close"] as? Double
    self.close = close
    self.date = dateFormatter.date(from: dt) ?? Date()
    self.high = dictionary["High"] as? Double
    self.low = dictionary["Low"] as? Double
    self.open = dictionary["Open"] as? Double
    self.volume = Double(dictionary["Volume"] as? Int ?? 0)
    self.adjClose = close
  }

  // MARK: - Helpers

  /// Convert Data model to dictionary.
  ///
  /// - Returns: The dictionary with Data model.
  public func toDictionary() -> [String: Any] {
    let dateString = ChartIQUtils.chartDateFormatter.string(from: date)
    return [
      Const.Data.dateParam: dateString,
      Const.Data.openParam: open as Any,
      Const.Data.highParam: high as Any,
      Const.Data.lowParam: low as Any,
      Const.Data.closeParam: close as Any,
      Const.Data.volumeParam: volume as Any,
      Const.Data.adjCloseParam: adjClose as Any
    ]
  }

  /// Convert Data model to JSON string.
  ///
  /// - Returns: The JSON string with Data model.
  public func toJSONString() -> String {
    guard let data = try? JSONSerialization.data(withJSONObject: self.toDictionary(), options: .prettyPrinted),
      let stringValue = String(data: data, encoding: .utf8) else { return "" }
    return stringValue
  }
}
