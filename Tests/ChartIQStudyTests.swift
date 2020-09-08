//
//  ChartIQStudyTests.swift
//  ChartIQTests
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

@testable import ChartIQ
import Foundation
import XCTest

class ChartIQStudyTests: XCTestCase {

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Tests Init with Parameters

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

    // When
    let study = ChartIQStudy(shortName: shortName,
                             fullName: fullName,
                             originalName: "",
                             inputs: inputs,
                             outputs: outputs,
                             parameters: parameters)

    // Then
    XCTAssertEqual(shortName, study.shortName)
    XCTAssertEqual(fullName, study.fullName)
    XCTAssertEqual(inputs.count, study.inputs?.count)
    XCTAssertEqual(outputs.count, study.outputs?.count)
    XCTAssertEqual(parameters.count, study.parameters?.count)
  }

  // MARK: - Tests Init with Dictionary and Key

  func testInitWithDictionaryAndKey() {
    // Given
    let dictionary: [String: Any] = [
      "name": "Darvas Box",
      "outputs": [
        "Darvas": "#5F7CB8",
        "Ghost": "#699158",
        "Levels": "auto"
      ],
      "underlay": 1,
      "attributes": [
        "Price Minimum": [
          "min": "0.01",
          "step": "0.01"
        ],
        "flippedEnabled": [
          "hidden": 1
        ],
        "panelName": [
          "hidden": 1
        ],
        "yaxisDisplayValue": [
          "hidden": 1
        ]
      ],
      "inputs": [
        "ATH Lookback Period": 100,
        "Exit Field": [
          "close",
          "high/low"
        ],
        "Ghost Boxes": 1,
        "Level Offset": "0.01",
        "Price Minimum": 5,
        "Stop Levels": 0,
        "Volume % of Avg": 400,
        "Volume Spike": 0
      ],
      "customRemoval": 1
    ]
    let key = "Darvas Box"

    // When
    let study = ChartIQStudy(dictionary: dictionary, key: key)

    // Then
    XCTAssertEqual(key, study.shortName)
    XCTAssertEqual(dictionary[ChartIQConstants.Study.nameParam] as? String, study.fullName)
    XCTAssertEqual((dictionary[ChartIQConstants.Study.inputsParam] as? [String: Any])?.count, study.inputs?.count)
    XCTAssertEqual((dictionary[ChartIQConstants.Study.outputsParam] as? [String: Any])?.count, study.outputs?.count)
    XCTAssertEqual((dictionary[ChartIQConstants.Study.parametersParam] as? [String: Any])?.count, study.parameters?.count)
  }

  func testInitWithJSStudyStringNil() {
    // Given
    let jsStudyString = "|‌W Acc Dist‌ (y)___{\"Use Volume\":true,\"id\":\"‌W Acc Dist‌ (y)\",\"display\":" +
    "\"‌W Acc Dist‌ (y)\"}___{\"Result\":\"#fff371\"}___{\"chartName\":\"chart\",\"panelName\":\"‌W Acc Dist‌ (y)\"}"

    // When
    let study = ChartIQStudy(jsStudyString: jsStudyString)

    // Then
    XCTAssertNil(study)
  }

  func testInitWithJSStudyString() {
    // Given
    let jsStudyString = "‌W Acc Dist‌ (n)___W Acc Dist___{\"Use Volume\":false,\"id\":\"‌W Acc Dist‌ (n)\",\"display\":" +
    "\"‌W Acc Dist‌ (n)\"}___{\"Result\":\"auto\"}___{\"chartName\":\"chart\",\"panelName\":\"‌W Acc Dist‌ (n)\"}"
    let fullName = "‌W Acc Dist‌ (n)"
    let inputs: [String: Any] = [
      "Use Volume": true,
      "display": "W Acc Dist‌ (n)",
      "id": "‌W Acc Dist‌ (n)"
    ]
    let outputs: [String: Any] = [
      "Result": "auto"
    ]
    let parameters: [String: Any] = [
      "chartName": "chart",
      "panelName": "W Acc Dist‌ (n)"
    ]

    // When
    let study = ChartIQStudy(jsStudyString: jsStudyString)

    // Then
    XCTAssertNotNil(study)
    XCTAssertEqual(fullName, study?.fullName)
    XCTAssertEqual(inputs.count, study?.inputs?.count)
    XCTAssertEqual(outputs.count, study?.outputs?.count)
    XCTAssertEqual(parameters.count, study?.parameters?.count)
  }
}
