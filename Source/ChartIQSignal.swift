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

  /// The ChartIQSignal isEnabled parameter.
  public var isEnabled: Bool

  // MARK: - Initializers

  /// Init Signal model with all parameters.
  ///
  /// - Parameters:
  ///   - study: The ChartIQStudy Object.
  ///   - conditions: The Array of ChartIQCondition Objects.
  ///   - joiner: The ChartIQSignalJoiner Object.
  ///   - name: The String Object.
  ///   - description: The String Object.
  ///   - isEnabled: The Bool Object.
  public init(study: ChartIQStudy,
              conditions: [ChartIQCondition],
              joiner: ChartIQSignalJoiner,
              name: String,
              signalDescription: String? = nil,
              isEnabled: Bool = false) {
    self.study = study
    self.conditions = conditions
    self.joiner = joiner
    self.name = name
    self.signalDescription = signalDescription
    self.isEnabled = isEnabled
  }

  /// Init Signal model with dictionary.
  ///
  /// - Parameters:
  ///   - dictionary: The dictionary with data for init Signal model.
  ///   - study: The ChartIQStudy Object.
  public init?(dictionary: [String: Any]) {
    guard let study = ChartIQStudy(dictionary: dictionary),
          let conditionsArray = dictionary[Const.Signal.conditionsParam] as? [[Any]],
          let joinerString = dictionary[Const.Signal.joinerParam] as? String,
          let joiner = ChartIQSignalJoiner(stringValue: joinerString),
          let name = dictionary[Const.Signal.signalNameParam] as? String,
          let isDisabled = dictionary[Const.Signal.disabledParam] as? Bool else { return nil }
    self.study = study
    var conditions: [ChartIQCondition] = []
    conditionsArray.forEach { conditionArray in
      if let condition = ChartIQCondition(array: conditionArray) {
        conditions.append(condition)
      }
    }
    self.conditions = conditions
    self.joiner = joiner
    self.name = name
    self.signalDescription = dictionary[Const.Signal.descriptionParam] as? String
    self.isEnabled = !isDisabled
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
      Const.Signal.nameParam: name,
      Const.Signal.descriptionParam: signalDescription ?? "",
      Const.Signal.joinerParam: joiner.stringValue,
      Const.Signal.conditionsParam: conditions
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
