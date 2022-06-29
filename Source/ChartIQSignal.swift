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

  /// The ChartIQSignal study parameter.
  public var study: ChartIQStudy

  /// The ChartIQSignal conditions parameter.
  public var conditions: [ChartIQCondition]

  /// The ChartIQSignal joiner parameter.
  public var joiner: ChartIQSignalJoiner

  /// The ChartIQSignal name parameter.
  public var name: String

  /// The ChartIQSignal description parameter.
  public var signalDescription: String?

  // MARK: - Initializers

  /// Init Signal model with all parameters.
  ///
  /// - Parameters:
  ///   - study: The ChartIQStudy Object.
  ///   - conditions: The Array of ChartIQCondition Objects.
  ///   - joiner: The ChartIQSignalJoiner Object.
  ///   - name: The String Object.
  ///   - description: The String Object.
  public init(study: ChartIQStudy,
              conditions: [ChartIQCondition],
              joiner: ChartIQSignalJoiner,
              name: String,
              signalDescription: String? = nil) {
    self.study = study
    self.conditions = conditions
    self.joiner = joiner
    self.name = name
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
    self.conditions.forEach { condition in
      conditions.append(condition.toArray())
    }
    return [
      "studyName": study.fullName,
      "name": name,
      "description": signalDescription ?? "",
      "joiner": joiner.stringValue,
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
