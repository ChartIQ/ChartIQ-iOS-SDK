//
//  ChartIQStudy.swift
//  ChartIQ
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

/// Encapsulates parameters with additional information for Study.
public class ChartIQStudy: NSObject {

  // MARK: - Public Properties

  /// The ChartIQStudy name parameter.
  public var name: String = ""

  /// The ChartIQStudy nameParams parameter.
  public var nameParams: String = ""

  /// The ChartIQStudy shortName parameter.
  public var shortName: String = ""

  /// The ChartIQStudy fullName parameter.
  public var fullName: String = ""

  /// The ChartIQStudy originalName parameter.
  public var originalName: String = ""

  /// The ChartIQStudy inputs parameter.
  public var inputs: [String: Any]?

  /// The ChartIQStudy outputs parameter.
  public var outputs: [String: Any]?

  /// The ChartIQStudy parameters parameter.
  public var parameters: [String: Any]?

  // MARK: - Initializers

  /// Init Study model with all parameters.
  ///
  /// - Parameters:
  ///   - shortName: The String Object.
  ///   - fullName: The String Object.
  ///   - originalName: The String Object.
  ///   - inputs: The Dictionary Object.
  ///   - outputs: The Dictionary Object.
  ///   - parameters: The Dictionary Object.
  public init(shortName: String,
              fullName: String,
              originalName: String,
              inputs: [String: Any]?,
              outputs: [String: Any]?,
              parameters: [String: Any]?) {
    self.shortName = shortName
    self.fullName = fullName
    self.originalName = originalName
    self.inputs = inputs
    self.outputs = outputs
    self.parameters = parameters
  }

  /// Init Study model with js study string parameter.
  ///
  /// - Parameters:
  ///   - study: The js study string with data for init Study model.
  public init?(jsStudyString study: String) {
    let studyComponents = study.components(separatedBy: "___")
    guard studyComponents.count > 4 else { return nil }
    var fullName = studyComponents[0]
    var originalName = studyComponents[1]
    let inputString = studyComponents[2]
    let outputString = studyComponents[3]
    let parametersString = studyComponents[4]
    self.fullName = fullName.replaceSymbolWithZwnj(symbol: "|")
    self.originalName = originalName.replaceSymbolWithZwnj(symbol: "|")
    let fullNameComponents = self.fullName.components(separatedBy: ChartIQConstants.General.zwnjSymbol)
    if fullNameComponents.count > 2 {
      self.name = fullNameComponents[1]
      self.nameParams = fullNameComponents[2]
    }
    if !inputString.isEmpty, let data = inputString.data(using: .utf8) {
      self.inputs = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any]
    }
    if !outputString.isEmpty, let data = outputString.data(using: .utf8) {
      self.outputs = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any]
    }
    if !parametersString.isEmpty, let data = parametersString.data(using: .utf8) {
      self.parameters = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any]
    }
  }

  /// Init Study model with dictionary and key parameters.
  ///
  /// - Parameters:
  ///   - dictionary: The dictionary with data for init Study model.
  ///   - key: The string value for init Study model.
  public init(dictionary: [String: Any], key: String) {
    self.shortName = key
    self.fullName = key
    if let studyFullName = dictionary[ChartIQConstants.Study.nameParam] as? String, !fullName.isEmpty {
      self.fullName = studyFullName
    }
    if let inputs = dictionary[ChartIQConstants.Study.inputsParam] as? [String: Any]? {
      self.inputs = inputs
    }
    if let outputs = dictionary[ChartIQConstants.Study.outputsParam] as? [String: Any]? {
      self.outputs = outputs
    }
    if let parameters = dictionary[ChartIQConstants.Study.parametersParam] as? [String: Any]? {
      self.parameters = parameters
    }
  }
}
