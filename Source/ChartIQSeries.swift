//
//  ChartIQSeries.swift
//  ChartIQ
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

/// Encapsulates parameters with additional information for Series.
public class ChartIQSeries: NSObject {

  // MARK: - Public Properties

  /// The ChartIQSeries symbolName parameter.
  public var symbolName: String

  /// The ChartIQSeries color parameter.
  public var color: UIColor

  // MARK: - Initializers

  /// Init Series model with all parameters.
  ///
  /// - Parameters:
  ///   - symbolName: The String Object.
  ///   - color: The UIColor Object.
  public init(symbolName: String, color: UIColor) {
    self.symbolName = symbolName
    self.color = color
  }

  /// Init Series model with dictionary and key parameters.
  ///
  /// - Parameters:
  ///   - dictionary: The dictionary with data for init Study model.
  ///   - key: The string value for init Study model.
  public init?(dictionary: [String: Any], key: String) {
    guard let seriesDict = dictionary[key] as? [String: Any],
          let colorHexString = seriesDict[Const.Series.colorParam] as? String else { return nil }
    self.symbolName = key
    self.color = UIColor(hexString: colorHexString)
  }
}
