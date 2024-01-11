//
//  ChartIQSignalTests.swift
//  ChartIQTests
//
//  Copyright 2012-2022 by ChartIQ, Inc.
//  All rights reserved
//

@testable import ChartIQ
import Foundation
import XCTest

class ChartIQSignalTests: XCTestCase {

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
  }

  func testInitWithParameters() {
    // Given
    let shortName = "ATR Trailing Stops"
    let fullName = "ATR Trailing Stops"
    let inputs: [String: Any] = [
      "HighLow": 0,
      "Multiplier": 3,
      "Period": 21,
      "Plot Type": [
        "points",
        "squarewave"
      ]
    ]
    let outputs: [String: Any] = [
      "Buy Stops": "#FF0000",
      "Sell Stops": "#00FF00"
    ]
    let parameters: [String: Any] = [
      "init": [
        "studyOverBoughtColor": "auto",
        "studyOverBoughtValue": 100,
        "studyOverSoldColor": "auto",
        "studyOverSoldValue": "-100",
        "studyOverZonesEnabled": 1
      ]
    ]
    let array: [Any] = [
      "Jaw Alligator",
      ">",
      "Lips Alligator",
      "",
      [
        "type": "marker",
        "color": "#0000ff",
        "shape": "circle",
        "label": "X",
        "size": "M",
        "position": "above_candle"
      ]
    ]
    let study: ChartIQStudy = ChartIQStudy(shortName: shortName,
                                           fullName: fullName,
                                           originalName: "",
                                           uniqueId: "",
                                           inputs: inputs,
                                           outputs: outputs,
                                           parameters: parameters)
    var conditions: [ChartIQCondition] = []
    for _ in 0...5 {
      if let condition = ChartIQCondition(array: array) {
        conditions.append(condition)
      }
    }
    let joiner: ChartIQSignalJoiner = .and
    let name: String = "New Signal"
    let signalDescription: String = "New Signal Unit Test"
    let isEnabled: Bool = true

    // When
    let signal = ChartIQSignal(study: study,
                               conditions: conditions,
                               joiner: joiner,
                               name: name,
                               signalDescription: signalDescription,
                               isEnabled: isEnabled)

    // Then
    XCTAssertEqual(study, signal.study)
    XCTAssertEqual(conditions, signal.conditions)
    XCTAssertEqual(joiner, signal.joiner)
    XCTAssertEqual(name, signal.name)
    XCTAssertEqual(signalDescription, signal.signalDescription)
    XCTAssertEqual(isEnabled, signal.isEnabled)
  }

  func testInitWithDictionary() {
    // Given
    let dictionary: [String: Any] = [
      "conditions": [[
        "Jaw Alligator",
        ">",
        "Lips Alligator",
        "",
        [
          "type": "marker",
          "color": "#0000ff",
          "shape": "circle",
          "label": "X",
          "size": "M",
          "position": "above_candle"
        ]
      ]],
      "type": "Alligator",
      "studyName": "‌Alligator‌ (y,20,8,8,5,5,5,y)",
      "uniqueId": "L5O66FE7173",
      "outputs": [
        "Jaw ‌Alligator‌ (y,20,8,8,5,5,5,y)": "Jaw",
        "Teeth ‌Alligator‌ (y,20,8,8,5,5,5,y)": "Teeth",
        "Lips ‌Alligator‌ (y,20,8,8,5,5,5,y)": "Lips"
      ],
      "joiner": "&",
      "signalName": "New Signal Test",
      "description": "New Signal Unit Test",
      "disabled": false
    ]

    // When
    let signal = ChartIQSignal(dictionary: dictionary)

    // Then
    XCTAssertNotNil(signal)
    XCTAssertNotNil(signal?.study)
    XCTAssertEqual((dictionary[Const.Signal.conditionsParam] as? [Any])?.count, signal?.conditions.count)
    XCTAssertEqual(dictionary[Const.Signal.joinerParam] as? String, signal?.joiner.stringValue)
    XCTAssertEqual(dictionary[Const.Signal.signalNameParam] as? String, signal?.name)
    XCTAssertEqual(dictionary[Const.Signal.descriptionParam] as? String, signal?.signalDescription)
    XCTAssertEqual(dictionary[Const.Signal.disabledParam] as? Bool, !(signal!.isEnabled))
  }

  func testInitWithDictionaryNil() {
    // Given
    let dictionary: [String: Any] = [
      "conditions": [],
      "type": "Alligator",
      "joiner": "circle",
      "signalName": "New Signal Test",
      "description": "New Signal Unit Test",
      "disabled": true
    ]

    // When
    let signal = ChartIQSignal(dictionary: dictionary)

    // Then
    XCTAssertNil(signal)
  }

  func testToDictionary() {
    // Given
    let name: String = "New Signal"
    let description: String = "New Signal Unit Test"
    let nameInDict = name.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? name
    let descriptionInDict = description.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? description
    let initialDictionary: [String: Any] = [
      "conditions": [[
        "Jaw Alligator",
        ">",
        "Lips Alligator",
        "",
        [
          "type": "marker",
          "color": "#0000ff",
          "shape": "circle",
          "label": "X",
          "size": "M",
          "position": "above_candle"
        ]
      ]],
      "type": "Alligator",
      "studyName": "‌Alligator‌ (y,20,8,8,5,5,5,y)",
      "uniqueId": "L5O66FE7173",
      "outputs": [
        "Jaw ‌Alligator‌ (y,20,8,8,5,5,5,y)": "Jaw",
        "Teeth ‌Alligator‌ (y,20,8,8,5,5,5,y)": "Teeth",
        "Lips ‌Alligator‌ (y,20,8,8,5,5,5,y)": "Lips"
      ],
      "joiner": "&",
      "signalName": name,
      "description": description,
      "disabled": false
    ]
    let signal = ChartIQSignal(dictionary: initialDictionary)

    // When
    let dictionary = signal?.toDictionary()

    // Then
    XCTAssertNotNil(signal)
    XCTAssertNotNil(signal?.study)
    XCTAssertEqual((dictionary?[Const.Signal.conditionsParam] as? [Any])?.count, signal?.conditions.count)
    XCTAssertEqual(dictionary?[Const.Signal.joinerParam] as? String, signal?.joiner.stringValue)
    XCTAssertEqual(dictionary?[Const.Signal.nameParam] as? String, nameInDict)
    XCTAssertEqual(dictionary?[Const.Signal.descriptionParam] as? String, descriptionInDict)
    XCTAssertNil(dictionary?[Const.Signal.disabledParam] as? Bool)
  }

  func testToDictionaryWithNameEncodingIssue() {
    // Given
    let name: String = String(bytes: [0xD8, 0x00] as [UInt8], encoding: .utf16BigEndian)! // should return nil when encoding
    let description: String = "New Signal Unit Test"
    let nameInDict = name.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? name
    let initialDictionary: [String: Any] = [
      "conditions": [[
        "Jaw Alligator",
        ">",
        "Lips Alligator",
        "",
        [
          "type": "marker",
          "color": "#0000ff",
          "shape": "circle",
          "label": "X",
          "size": "M",
          "position": "above_candle"
        ]
      ]],
      "type": "Alligator",
      "studyName": "‌Alligator‌ (y,20,8,8,5,5,5,y)",
      "uniqueId": "L5O66FE7173",
      "outputs": [
        "Jaw ‌Alligator‌ (y,20,8,8,5,5,5,y)": "Jaw",
        "Teeth ‌Alligator‌ (y,20,8,8,5,5,5,y)": "Teeth",
        "Lips ‌Alligator‌ (y,20,8,8,5,5,5,y)": "Lips"
      ],
      "joiner": "&",
      "signalName": name,
      "description": description,
      "disabled": false
    ]
    let signal = ChartIQSignal(dictionary: initialDictionary)

    // When
    let dictionary = signal?.toDictionary()

    // Then
    XCTAssertTrue(!name.isEmpty)
    XCTAssertEqual(name, nameInDict)
    XCTAssertNotNil(dictionary?[Const.Signal.nameParam] as? String)
    XCTAssertEqual(dictionary?[Const.Signal.nameParam] as? String, nameInDict)
  }

  func testCreateJSONString() {
    // Given
    let shortName = "ATR Trailing Stops"
    let fullName = "ATR Trailing Stops"
    let inputs: [String: Any] = [
      "HighLow": 0,
      "Multiplier": 3,
      "Period": 21,
      "Plot Type": [
        "points",
        "squarewave"
      ]
    ]
    let outputs: [String: Any] = [
      "Buy Stops": "#FF0000",
      "Sell Stops": "#00FF00"
    ]
    let parameters: [String: Any] = [
      "init": [
        "studyOverBoughtColor": "auto",
        "studyOverBoughtValue": 100,
        "studyOverSoldColor": "auto",
        "studyOverSoldValue": "-100",
        "studyOverZonesEnabled": 1
      ]
    ]
    let array: [Any] = [
      "Jaw Alligator",
      ">",
      "Lips Alligator",
      "",
      [
        "type": "marker",
        "color": "#0000ff",
        "shape": "circle",
        "label": "X",
        "size": "M",
        "position": "above_candle"
      ]
    ]
    let study: ChartIQStudy = ChartIQStudy(shortName: shortName,
                                           fullName: fullName,
                                           originalName: "",
                                           uniqueId: "",
                                           inputs: inputs,
                                           outputs: outputs,
                                           parameters: parameters)
    var conditions: [ChartIQCondition] = []
    for _ in 0...5 {
      if let condition = ChartIQCondition(array: array) {
        conditions.append(condition)
      }
    }
    let joiner: ChartIQSignalJoiner = .and
    let name: String = "New Signal"
    let description: String = "New Signal Unit Test"
    let nameInString = name.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? name
    let descriptionInString = description.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? description
    let isEnabled: Bool = true
    let signal = ChartIQSignal(study: study,
                               conditions: conditions,
                               joiner: joiner,
                               name: name,
                               signalDescription: description,
                               isEnabled: isEnabled)

    // When
    let string = signal.toJSONString()

    // Then
    XCTAssertTrue(string.contains(nameInString))
    XCTAssertTrue(string.contains(descriptionInString))
    XCTAssertTrue(string.contains(joiner.stringValue))
    XCTAssertFalse(string.contains(String(isEnabled)))
    XCTAssertFalse(string.contains(String(shortName)))
  }

  func testCreateJSONStringWithoutDesccription() {
    // Given
    let shortName = "ATR Trailing Stops"
    let fullName = "ATR Trailing Stops"
    let inputs: [String: Any] = [
      "HighLow": 0,
      "Multiplier": 3,
      "Period": 21,
      "Plot Type": [
        "points",
        "squarewave"
      ]
    ]
    let outputs: [String: Any] = [
      "Buy Stops": "#FF0000",
      "Sell Stops": "#00FF00"
    ]
    let parameters: [String: Any] = [
      "init": [
        "studyOverBoughtColor": "auto",
        "studyOverBoughtValue": 100,
        "studyOverSoldColor": "auto",
        "studyOverSoldValue": "-100",
        "studyOverZonesEnabled": 1
      ]
    ]
    let array: [Any] = [
      "Jaw Alligator",
      ">",
      "Lips Alligator",
      "",
      [
        "type": "marker",
        "color": "#0000ff",
        "shape": "circle",
        "label": "X",
        "size": "M",
        "position": "above_candle"
      ]
    ]
    let study: ChartIQStudy = ChartIQStudy(shortName: shortName,
                                           fullName: fullName,
                                           originalName: "",
                                           uniqueId: "",
                                           inputs: inputs,
                                           outputs: outputs,
                                           parameters: parameters)
    var conditions: [ChartIQCondition] = []
    for _ in 0...5 {
      if let condition = ChartIQCondition(array: array) {
        conditions.append(condition)
      }
    }
    let joiner: ChartIQSignalJoiner = .and
    let name: String = "New Signal"
    let description: String = "New Signal Unit Test"
    let nameInString = name.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? name
    let descriptionInString = description.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? description
    let isEnabled: Bool = true
    let signal = ChartIQSignal(study: study,
                               conditions: conditions,
                               joiner: joiner,
                               name: name,
                               signalDescription: nil,
                               isEnabled: isEnabled)

    // When
    let string = signal.toJSONString()

    // Then
    XCTAssertTrue(string.contains(nameInString))
    XCTAssertFalse(string.contains(descriptionInString))
    XCTAssertTrue(string.contains(joiner.stringValue))
    XCTAssertFalse(string.contains(String(isEnabled)))
    XCTAssertFalse(string.contains(String(shortName)))
  }
}
