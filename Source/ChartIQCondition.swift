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
  /// Is a field in the study's outputMap.
  public var leftIndicator: String

  /// The ChartIQCondition operator parameter.
  public var `operator`: ChartIQSignalOperator

  /// The ChartIQCondition rightIndicator parameter.
  /// Can be either a numeric value in string or a field in the study's outputMap.
  public var rightIndicator: String

  /// The ChartIQCondition markerOptions parameter.
  /// Optional settings for main series marker. When multiple conditions match, markerOptions from the first matching condition are applied.
  public var markerOptions: ChartIQMarkerOptions?

  // MARK: - Initializers

  /// Init Condition model with all parameters.
  ///
  /// - Parameters:
  ///   - leftIndicator: The String Object.
  ///   - operator: The ChartIQSignalOperator model.
  ///   - rightIndicator: The String Object.
  ///   - markerOptions: The ChartIQMarkerOptions model.
  public init(leftIndicator: String,
              `operator`: ChartIQSignalOperator,
              rightIndicator: String,
              markerOptions: ChartIQMarkerOptions?) {
    self.leftIndicator = leftIndicator
    self.`operator` = `operator`
    self.rightIndicator = rightIndicator
    self.markerOptions = markerOptions
  }

  /// Init Condition model with dictionary.
  ///
  /// - Parameters:
  ///   - array: The array with data for init Condition model.
  public init?(array: [Any]) {
    guard let leftIndicator = array[0] as? String,
          let operatorStringValue = array[1] as? String,
          let signalOperator = ChartIQSignalOperator(stringValue: operatorStringValue),
          let rightIndicator = array[2] as? String else { return nil }
    self.leftIndicator = leftIndicator
    self.`operator` = signalOperator
    self.rightIndicator = rightIndicator
    if let markerOptionsDictionary = array[4] as? [String: Any],
       let markerOptions = ChartIQMarkerOptions(dictionary: markerOptionsDictionary) {
      self.markerOptions = markerOptions
    }
  }

  // MARK: - Helpers

  /// Convert Condition model to array.
  ///
  /// - Returns: The dictionary with Condition model parameters.
  public func toArray() -> [Any] {
    return [
      leftIndicator,
      `operator`.stringValue,
      rightIndicator,
      markerOptions?.color?.toHexString() as Any,
      markerOptions?.toDictionary() as Any
    ]
  }
}
