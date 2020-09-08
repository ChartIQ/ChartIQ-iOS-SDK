//
//  ChartIQCrosshairHUD.swift
//  ChartIQ
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import Foundation

// MARK: - ChartIQCrosshairHUD

/// Encapsulates parameters with additional information for the data provided by CrosshairHUD.
public class ChartIQCrosshairHUD: NSObject {

  // MARK: - Properties

  /// The ChartIQCrosshairHUD price parameter.
  public var price: String = ""

  /// The ChartIQCrosshairHUD volume parameter.
  public var volume: String = ""

  /// The ChartIQCrosshairHUD open parameter.
  public var open: String = ""

  /// The ChartIQCrosshairHUD high parameter.
  public var high: String = ""

  /// The ChartIQCrosshairHUD close parameter.
  public var close: String = ""

  /// The ChartIQCrosshairHUD low parameter.
  public var low: String = ""

  // MARK: - Initializers

  /// Init CrosshairHUD model with all parameters.
  ///
  /// - Parameters:
  ///   - price: The String Object.
  ///   - volume: The String Object.
  ///   - open: The String Object.
  ///   - high: The String Object.
  ///   - close: The String Object.
  ///   - low: The String Object.
  public init(price: String, volume: String, open: String, high: String, close: String, low: String) {
    self.price = price
    self.volume = volume
    self.open = open
    self.high = high
    self.close = close
    self.low = low
  }

  /// Init CrosshairHUD model with dictionary parameter.
  ///
  /// - Parameters:
  ///   - dictionary: The dictionary with data for init CrosshairHUD model.
  public init(dictionary: [String: String]) {
    self.price = dictionary[ChartIQConstants.CrosshairHUD.priceParam] ?? ""
    self.volume = dictionary[ChartIQConstants.CrosshairHUD.volumeParam] ?? ""
    self.open = dictionary[ChartIQConstants.CrosshairHUD.openParam] ?? ""
    self.high = dictionary[ChartIQConstants.CrosshairHUD.highParam] ?? ""
    self.close = dictionary[ChartIQConstants.CrosshairHUD.closeParam] ?? ""
    self.low = dictionary[ChartIQConstants.CrosshairHUD.lowParam] ?? ""
  }
}
