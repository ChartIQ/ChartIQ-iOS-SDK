//
//  ChartIQViewTests.swift
//  ChartIQTests
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

@testable import ChartIQ
import Foundation
import XCTest

class ChartIQViewTests: XCTestCase {

  var chartIQView: ChartIQView!

  override func setUp() {
    super.setUp()

    chartIQView = ChartIQView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Tests Evaluate JavaScript with Return

  func testStartWithURLMethod() {
    // Given
    let url = "https://startCustomURL.html"

    // When
    ChartIQView.start(url: url)

    // Then
    XCTAssertEqual(url, ChartIQView.chartIQUrl)
  }

  func testSetURLMethod() {
    // Given
    let url = "https://setCustomURL.html"

    // When
    chartIQView.setChartIQUrl(url)

    // Then
    XCTAssertEqual(url, ChartIQView.chartIQUrl)
  }

  func testSetRefreshIntervalMethod() {
    // Given
    let refreshInterval = 0

    // When
    chartIQView.setRefreshInterval(refreshInterval)

    // Then
    XCTAssertEqual(refreshInterval, ChartIQView.chartIQRefreshInterval)
  }

  func testSetVoiceoverFieldsMethod() {
    // Given
    let voiceoverFields: [String: Bool] = [
      ChartIQQuoteField.date.stringValue: true,
      ChartIQQuoteField.close.stringValue: true,
      ChartIQQuoteField.open.stringValue: false,
      ChartIQQuoteField.high.stringValue: false,
      ChartIQQuoteField.low.stringValue: false,
      ChartIQQuoteField.volume.stringValue: false
    ]

    // When
    chartIQView.setVoiceoverFields(voiceoverFields)

    // Then
    XCTAssertEqual(voiceoverFields, ChartIQView.chartIQVoiceoverFields)
  }

  func testSetDefaultVoiceoverFieldsMethod() {
    // Given
    let voiceoverFields: [String: Bool] = [
      ChartIQQuoteField.date.stringValue: true,
      ChartIQQuoteField.close.stringValue: true,
      ChartIQQuoteField.open.stringValue: false,
      ChartIQQuoteField.high.stringValue: false,
      ChartIQQuoteField.low.stringValue: false,
      ChartIQQuoteField.volume.stringValue: false
    ]

    // When
    chartIQView.setVoiceoverFields(nil, default: true)

    // Then
    XCTAssertEqual(voiceoverFields, ChartIQView.chartIQVoiceoverFields)
  }

  func testSetPullDataMethod() {
    // Given
    let chartIQDataMethod = ChartIQDataMethod.pull

    // When
    chartIQView.setDataMethod(chartIQDataMethod)

    // Then
    XCTAssertEqual(chartIQDataMethod, chartIQView.dataMethod)
  }

  func testSetPushDataMethod() {
    // Given
    let chartIQDataMethod = ChartIQDataMethod.push

    // When
    chartIQView.setDataMethod(chartIQDataMethod)

    // Then
    XCTAssertEqual(chartIQDataMethod, chartIQView.dataMethod)
  }

  func testSafeScriptParameterMethod() {
    // Given
    let chartIQScriptManager = ChartIQScriptManager()

    let originalString = ">'W'\\< >'Acc'\\< >'Dist'\\<&"
    let correctString = "&gt;&apos;W&apos;\\&lt; &gt;&apos;Acc&apos;\\&lt; &gt;&apos;Dist&apos;\\&lt;&amp;"

    // When
    let safeString = chartIQScriptManager.safeScriptParameter(originalString)

    // Then
    XCTAssertEqual(correctString, safeString)
  }

  func testDoubleApplySafeScriptParameterMethod() {
    // Given
    let chartIQScriptManager = ChartIQScriptManager()

    let originalString = ">'W'\\< >'Acc'\\< >'Dist'\\<&"
    let correctString = "&gt;&apos;W&apos;\\&lt; &gt;&apos;Acc&apos;\\&lt; &gt;&apos;Dist&apos;\\&lt;&amp;"

    // When
    let safeString = chartIQScriptManager.safeScriptParameter(originalString)
    let secondSafeString = chartIQScriptManager.safeScriptParameter(safeString)

    // Then
    XCTAssertEqual(correctString, safeString)
    XCTAssertEqual(correctString, secondSafeString)
  }

  func testGetStudyDescriptorScriptMethod() {
    // Given
    let chartIQScriptManager = ChartIQScriptManager()

    let studyDescriptorName = "‌Acc Swing‌ (0.5)"
    let correctStudyDescriptorScript = "var s=stxx.layout.studies; var selectedSd = {}; for(var n in s){ var " +
    "sd=s[n]; if (sd.name === \"‌Acc Swing‌ (0.5)\") { selectedSd = sd; }} "

    // When
    let studyDescriptorScript = chartIQScriptManager.getStudyDescriptorScript(studyDescriptorName)

    // Then
    XCTAssertEqual(correctStudyDescriptorScript, studyDescriptorScript)
  }

  func testGetStudyList() {
    // Given
    let chartIQViewStudyList = chartIQView.allStudies

    // When
    let studyList = chartIQView.getAllStudies()

    // Then
    XCTAssertEqual(chartIQViewStudyList, studyList)
  }

  func testGetWebView() {
    // Given
    let chartIQViewWebView = chartIQView.webView

    // When
    let webView = chartIQView.getWebView()

    // Then
    XCTAssertEqual(chartIQViewWebView, webView)
  }

  func testFormatObjectToPrintedJSONFormatMethod() {
    // Given
    let parametersObject: [String: Any] = [
      "init": [
        "studyOverBoughtColor": 100
      ]
    ]
    let correctJSONString = "{\n  \"init\" : {\n    \"studyOverBoughtColor\" : 100\n  }\n}"

    // When
    let jsonString = chartIQView.formatObjectToPrintedJSONFormat(parametersObject)

    // Then
    XCTAssertEqual(correctJSONString, jsonString)
  }

  func testFormatEmptyObjectToPrintedJSONFormatMethod() {
    // Given
    let parametersObject: [String: Any] = [:]
    let correctJSONString = "{\n\n}"

    // When
    let jsonString = chartIQView.formatObjectToPrintedJSONFormat(parametersObject)

    // Then
    XCTAssertEqual(correctJSONString, jsonString)
  }

  func testFormatIncorrectObjectToPrintedJSONFormatMethod() {
    // Given
    let parametersObject: String = "studyOverBoughtColor"
    let correctJSONString = ""

    // When
    let jsonString = chartIQView.formatObjectToPrintedJSONFormat(parametersObject)

    // Then
    XCTAssertEqual(correctJSONString, jsonString)
  }

  func testGetUpdateStudyParametersScript() {
    // Given
    let chartIQScriptManager = ChartIQScriptManager()

    let parameter = "Use Volume"
    let value = "0"
    let correctScriptString = "for (x in helper.inputs) {   var input = helper.inputs[x];    " +
    "if (input[\"name\"] === \"Use Volume\") {        isFound = true;        if (input[\"type\"] === \"text\" || " +
    "input[\"type\"] === \"select\") {            newInputParameters[\"Use Volume\"] = \"0\";        } else if " +
    "(input[\"type\"] === \"number\") {            newInputParameters[\"Use Volume\"] = parseFloat(\"0\");        } " +
    "else if (input[\"type\"] === \"checkbox\") {            newInputParameters[\"Use Volume\"] = false;        }    " +
    "} } if (isFound == false) {    for (x in helper.outputs) {        var output = helper.outputs[x];        " +
    "if (output[\"name\"] === \"Use Volume\") {            newOutputParameters[\"Use Volume\"] = \"0\";        }    " +
    "} } if (isFound == false) {    if(\"Use Volume\".includes(\"Color\")) {        " +
    "newParameters[\"Use Volume\"] = \"0\";    } else if(\"Use Volume\".includes(\"Enabled\")) {        " +
    "newParameters[\"Use Volume\"] = false;    } else {        newParameters[\"Use Volume\"] = parseFloat(\"0\");    " +
    "} } isFound = false; "

    // When
    let scriptString = chartIQScriptManager.getUpdateStudyParametersScript(parameter, value: value)

    // Then
    XCTAssertEqual(correctScriptString, scriptString)
  }

  func testIsSupportingFillMethod() {
    // Given

    let chartIQDrawingManager = ChartIQDrawingManager()

    // When // Then
    XCTAssertTrue(chartIQDrawingManager.isSupportingFillColor(ChartIQDrawingTool.channel))
    XCTAssertFalse(chartIQDrawingManager.isSupportingFillColor(ChartIQDrawingTool.continuous))
    XCTAssertFalse(chartIQDrawingManager.isSupportingFillColor(ChartIQDrawingTool.doodle))
    XCTAssertTrue(chartIQDrawingManager.isSupportingFillColor(ChartIQDrawingTool.ellipse))
    XCTAssertTrue(chartIQDrawingManager.isSupportingFillColor(ChartIQDrawingTool.fibArc))
    XCTAssertTrue(chartIQDrawingManager.isSupportingFillColor(ChartIQDrawingTool.fibFan))
    XCTAssertTrue(chartIQDrawingManager.isSupportingFillColor(ChartIQDrawingTool.fibRetracement))
    XCTAssertTrue(chartIQDrawingManager.isSupportingFillColor(ChartIQDrawingTool.fibTimeZone))
    XCTAssertTrue(chartIQDrawingManager.isSupportingFillColor(ChartIQDrawingTool.gartley))
    XCTAssertFalse(chartIQDrawingManager.isSupportingFillColor(ChartIQDrawingTool.horizontal))
    XCTAssertFalse(chartIQDrawingManager.isSupportingFillColor(ChartIQDrawingTool.line))
    XCTAssertFalse(chartIQDrawingManager.isSupportingFillColor(ChartIQDrawingTool.pitchfork))
    XCTAssertFalse(chartIQDrawingManager.isSupportingFillColor(ChartIQDrawingTool.ray))
    XCTAssertTrue(chartIQDrawingManager.isSupportingFillColor(ChartIQDrawingTool.rectangle))
    XCTAssertFalse(chartIQDrawingManager.isSupportingFillColor(ChartIQDrawingTool.segment))
    XCTAssertFalse(chartIQDrawingManager.isSupportingFillColor(ChartIQDrawingTool.vertical))
  }

  func testIsSupportingPatternMethod() {
    // Given

    let chartIQDrawingManager = ChartIQDrawingManager()

    // When // Then
    XCTAssertTrue(chartIQDrawingManager.isSupportingLineType(ChartIQDrawingTool.channel))
    XCTAssertTrue(chartIQDrawingManager.isSupportingLineType(ChartIQDrawingTool.continuous))
    XCTAssertTrue(chartIQDrawingManager.isSupportingLineType(ChartIQDrawingTool.doodle))
    XCTAssertTrue(chartIQDrawingManager.isSupportingLineType(ChartIQDrawingTool.ellipse))
    XCTAssertTrue(chartIQDrawingManager.isSupportingLineType(ChartIQDrawingTool.fibArc))
    XCTAssertTrue(chartIQDrawingManager.isSupportingLineType(ChartIQDrawingTool.fibFan))
    XCTAssertTrue(chartIQDrawingManager.isSupportingLineType(ChartIQDrawingTool.fibRetracement))
    XCTAssertTrue(chartIQDrawingManager.isSupportingLineType(ChartIQDrawingTool.fibTimeZone))
    XCTAssertTrue(chartIQDrawingManager.isSupportingLineType(ChartIQDrawingTool.gartley))
    XCTAssertTrue(chartIQDrawingManager.isSupportingLineType(ChartIQDrawingTool.horizontal))
    XCTAssertTrue(chartIQDrawingManager.isSupportingLineType(ChartIQDrawingTool.line))
    XCTAssertTrue(chartIQDrawingManager.isSupportingLineType(ChartIQDrawingTool.pitchfork))
    XCTAssertTrue(chartIQDrawingManager.isSupportingLineType(ChartIQDrawingTool.ray))
    XCTAssertTrue(chartIQDrawingManager.isSupportingLineType(ChartIQDrawingTool.rectangle))
    XCTAssertTrue(chartIQDrawingManager.isSupportingLineType(ChartIQDrawingTool.segment))
    XCTAssertTrue(chartIQDrawingManager.isSupportingLineType(ChartIQDrawingTool.vertical))
  }

  func testGetBaseSymbolValue() {
    // Given // When
    let chartIQViewSymbol = chartIQView.symbol

    // Then
    XCTAssertNil(chartIQViewSymbol)
  }

  func testGetBaseIntervalValue() {
    // Given // When
    let chartIQViewInterval = chartIQView.interval

    // Then
    XCTAssertNil(chartIQViewInterval)
  }

  func testGetBaseTimeUnitValue() {
    // Given // When
    let chartIQTimeUnit = chartIQView.timeUnit

    // Then
    XCTAssertNil(chartIQTimeUnit)
  }

  func testGetBasePeriodicityValue() {
    // Given // When
    let chartIQPeriodicity = chartIQView.periodicity

    // Then
    XCTAssertNil(chartIQPeriodicity)
  }

  func testGetBaseChartTypeValue() {
    // Given
    let chartType: ChartIQChartType = .bar

    // When
    let chartIQChartType = chartIQView.chartType

    // Then
    XCTAssertEqual(chartType, chartIQChartType)
  }

  func testGetBaseAggregationTypeValue() {
    // Given
    let aggregationType: ChartIQChartAggregationType? = nil

    // When
    let chartIQAggregationType = chartIQView.chartAggregationType

    // Then
    XCTAssertEqual(aggregationType, chartIQAggregationType)
  }

  func testGetBaseScaleValue() {
    // Given
    let scale: ChartIQScale = .linear

    // When
    let chartIQScale = chartIQView.chartScale

    // Then
    XCTAssertEqual(scale, chartIQScale)
  }

  func testGetBaseIsExtendedHoursValue() {
    // Given
    let isExtendedHours = false

    // When
    let chartIQIsExtendedHours = chartIQView.isExtendedHours

    // Then
    XCTAssertEqual(isExtendedHours, chartIQIsExtendedHours)
  }

  func testGetBaseIsInvertYAxisValue() {
    // Given
    let isInvertYAxis = false

    // When
    let chartIQIsInvertYAxis = chartIQView.isInvertYAxis

    // Then
    XCTAssertEqual(isInvertYAxis, chartIQIsInvertYAxis)
  }

  func testGetBaseIsCrosshairsEnabledValue() {
    // Given
    let isCrosshairsEnabled = false

    // When
    let chartIQIsCrosshairsEnabled = chartIQView.isCrosshairsEnabled()

    // Then
    XCTAssertEqual(isCrosshairsEnabled, chartIQIsCrosshairsEnabled)
  }

  func testGetBaseIsChartAvailableValue() {
    // Given
    let isChartAvailable = false

    // When
    let chartIQIsChartAvailable = chartIQView.isChartAvailable()

    // Then
    XCTAssertEqual(isChartAvailable, chartIQIsChartAvailable)
  }

  func testGetBaseStudyListValue() {
    // Given
    let studyList: [ChartIQStudy] = []

    // When
    let chartIQStudyList = chartIQView.getAllStudies()

    // Then
    XCTAssertEqual(studyList, chartIQStudyList)
  }

  func testGetBaseActiveStudyListValue() {
    // Given
    let activeStudyList: [ChartIQStudy] = []

    // When
    let chartIQActiveStudyList = chartIQView.getActiveStudies()

    // Then
    XCTAssertEqual(activeStudyList, chartIQActiveStudyList)
  }

  func testGetDrawingParametersMethod() {
    // Given // When
    let chartIQDrawingParameters = chartIQView.getDrawingParameters(.annotation)

    // Then
    XCTAssertNil(chartIQDrawingParameters)
  }

  func testGetDrawingParametersMethodNoTool() {
    // Given
    let drawingParametersIsEmpty = true

    // Given // When
    let chartIQDrawingParameters = chartIQView.getDrawingParameters(.noTool)

    // Then
    XCTAssertNotNil(chartIQDrawingParameters)
    XCTAssertEqual(drawingParametersIsEmpty, chartIQDrawingParameters?.isEmpty)
  }
}
