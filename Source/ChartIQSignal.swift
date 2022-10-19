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
  /// Array of conditions. Each condition is itself an array of [leftIndicator, operator, rightIndicator, color, markerOptions]
  public var conditions: [ChartIQCondition]

  /// The ChartIQSignal joiner parameter.
  /// & or | to join conditions. If omitted, "|" assumed.
  public var joiner: ChartIQSignalJoiner

  /// The ChartIQSignal name parameter.
  /// Name of Signal. Signal will be saved with this name and this name will appear in any study legend and in the expanded signal's title.
  public var name: String

  /// The ChartIQSignal description parameter.
  /// Description of signal. Can be nil.
  public var signalDescription: String?

  /// The ChartIQSignal isEnabled parameter.
  public var isEnabled: Bool

  // MARK: - Initializers

  /// Init Signal model with all parameters.
  ///
  /// - Parameters:
  ///   - study: The ChartIQStudy model.
  ///   - conditions: The Array of ChartIQCondition models.
  ///   - joiner: The ChartIQSignalJoiner model.
  ///   - name: The String Object.
  ///   - signalDescription: The String Object. Can be nil.
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

  /// Convert Signal model to dictionary.
  ///
  /// - Returns: The dictionary with Signal model parameters.
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

  /// Convert Signal model to JSON string.
  ///
  /// - Returns: The JSON string with Signal model parameters.
  public func toJSONString() -> String {
    guard let data = try? JSONSerialization.data(withJSONObject: self.toDictionary(), options: []),
          let stringValue = String(data: data, encoding: .utf8) else { return "" }
    return stringValue
  }
}
