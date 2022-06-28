//
//  ChartIQSignal.swift
//  ChartIQ
//
//  Copyright 2012-2022 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

/// Encapsulates parameters with additional information for Signal.
public class ChartIQSignal: NSObject {

  // MARK: - Public Properties

  /// The ChartIQSignal signalStudy parameter.
  public var signalStudy: ChartIQStudy

  /// The ChartIQSignal signalConditions parameter.
  public var signalConditions: [ChartIQCondition]

  /// The ChartIQSignal signalJoiner parameter.
  public var signalJoiner: ChartIQSignalJoiner

  /// The ChartIQSignal signalName parameter.
  public var signalName: String

  /// The ChartIQSignal signalDescription parameter.
  public var signalDescription: String?

  // MARK: - Initializers

  /// Init Signal model with all parameters.
  ///
  /// - Parameters:
  ///   - signalStudy: The ChartIQStudy Object.
  ///   - signalConditions: The Array of ChartIQCondition Objects.
  ///   - signalJoiner: The ChartIQSignalJoiner Object.
  ///   - signalName: The String Object.
  ///   - signalDescription: The String Object.
  public init(signalStudy: ChartIQStudy,
              signalConditions: [ChartIQCondition],
              signalJoiner: ChartIQSignalJoiner,
              signalName: String,
              signalDescription: String? = nil) {
    self.signalStudy = signalStudy
    self.signalConditions = signalConditions
    self.signalJoiner = signalJoiner
    self.signalName = signalName
    self.signalDescription = signalDescription
  }

  /// Init Signal model with js study string parameter.
  ///
  /// - Parameters:
  ///   - signal: The js signal string with data for init Signal model.
  public init?(jsSignalString signal: String) {
    return nil
  }

  // MARK: - Helpers

  /// Convert Data model to dictionary.
  ///
  /// - Returns: The dictionary with Data model.
  public func toDictionary() -> [String: Any] {
    var conditions: [[Any]] = []
    signalConditions.forEach { condition in
      conditions.append(condition.toArray())
    }
    return [
      "studyName": signalStudy.fullName,
      "name": signalName,
      "description": signalDescription ?? "",
      "joiner": signalJoiner.stringValue,
      "conditions": conditions
    ]
  }

  /// Convert Data model to JSON string.
  ///
  /// - Returns: The JSON string with Data model.
  public func toJSONString() -> String {
    guard let data = try? JSONSerialization.data(withJSONObject: self.toDictionary(), options: []),
          let stringValue = String(data: data, encoding: .utf8) else { return "" }
    return stringValue
  }
}
