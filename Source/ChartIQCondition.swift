//
//  ChartIQCondition.swift
//  ChartIQ
//
//  Copyright 2012-2022 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

/// Encapsulates parameters with additional information for Condition.
public class ChartIQCondition: NSObject {

  // MARK: - Public Properties

  /// The ChartIQCondition leftIndicator parameter.
  public var leftIndicator: String

  /// The ChartIQCondition operator parameter.
  public var `operator`: ChartIQSignalOperator

  /// The ChartIQCondition rightIndicator parameter.
  public var rightIndicator: String

  /// The ChartIQCondition markerOptions parameter.
  public var markerOptions: ChartIQMarkerOptions?

  // MARK: - Initializers

  /// Init Study model with all parameters.
  ///
  /// - Parameters:
  ///   - leftIndicator: The String Object.
  ///   - operator: The ChartIQSignalOperator Object.
  ///   - rightIndicator: The String Object.
  ///   - markerOptions: The ChartIQMarkerOptions Object.
  public init(leftIndicator: String,
              `operator`: ChartIQSignalOperator,
              rightIndicator: String,
              markerOptions: ChartIQMarkerOptions?) {
    self.leftIndicator = leftIndicator
    self.`operator` = `operator`
    self.rightIndicator = rightIndicator
    self.markerOptions = markerOptions
  }

  // MARK: - Helpers

  /// Convert Data model to dictionary.
  ///
  /// - Returns: The dictionary with Data model.
  public func toArray() -> [Any] {
    return [
      leftIndicator,
      `operator`.stringValue,
      rightIndicator, markerOptions?.color.toHexString() as Any,
      markerOptions?.toDictionary() as Any
    ]
  }
}
