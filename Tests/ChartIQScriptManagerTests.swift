//
//  ChartIQScriptManagerTests.swift
//  ChartIQTests
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

@testable import ChartIQ
import Foundation
import XCTest

class ChartIQScriptManagerTests: XCTestCase {

  let chartIQScriptManager = ChartIQScriptManager()
  var mobileNameSpace = "CIQ.MobileBridge."

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Tests ChartIQScript Manager

  func testsGetScriptForSymbol() {
    // Given
    let correctScript = "stxx.chart.symbol"

    // When
    let script = chartIQScriptManager.getScriptForSymbol()

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForInterval() {
    // Given
    let correctScript = "stxx.layout.interval.toString()"

    // When
    let script = chartIQScriptManager.getScriptForInterval()

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForTimeUnit() {
    // Given
    let correctScript = "stxx.timeUnit"

    // When
    let script = chartIQScriptManager.getScriptForTimeUnit()

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForPeriodicity() {
    // Given
    let correctScript = "stxx.layout.periodicity.toString()"

    // When
    let script = chartIQScriptManager.getScriptForPeriodicity()

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForChartType() {
    // Given
    let correctScript = "stxx.layout.chartType"

    // When
    let script = chartIQScriptManager.getScriptForChartType()

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForAggregationType() {
    // Given
    let correctScript = "stxx.layout.aggregationType"

    // When
    let script = chartIQScriptManager.getScriptForAggregationType()

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForScale() {
    // Given
    let correctScript = "stxx.layout.chartScale"

    // When
    let script = chartIQScriptManager.getScriptForScale()

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForExtendedHours() {
    // Given
    let correctScript = mobileNameSpace + "getLayoutProperty(\"extended\");"

    // When
    let script = chartIQScriptManager.getScriptForExtendedHours()

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForInvertYAxis() {
    // Given
    let correctScript = mobileNameSpace + "getLayoutProperty(\"flipped\");"

    // When
    let script = chartIQScriptManager.getScriptForInvertYAxis()

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForLoadChart() {
    // Given
    let correctScript = mobileNameSpace + "loadChart();"

    // When
    let script = chartIQScriptManager.getScriptForLoadChart()

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForSetChartType() {
    // Given
    let correctScript = mobileNameSpace + "setChartType(\"bar\");"

    // When
    let script = chartIQScriptManager.getScriptForSetChartType(.bar)

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForSetAggregationType() {
    // Given
    let correctScript = mobileNameSpace + "setAggregationType(\"kagi\");"

    // When
    let script = chartIQScriptManager.getScriptForSetAggregationType(.kagi)

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForSetPeriodicity() {
    // Given

    let correctScript = mobileNameSpace + "setPeriodicity(0, \"day\", \"day\");"

    // When
    let script = chartIQScriptManager.getScriptForSetPeriodicity(0, interval: "day", timeUnit: .day)

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForAccessibilityMode() {
    // Given
    let correctScript = mobileNameSpace + "accessibilityMode();"

    // When
    let script = chartIQScriptManager.getScriptForAccessibilityMode()

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForLoadChartWithSymbol() {
    // Given
    let correctScript = mobileNameSpace + "loadChart(\"AAPL\");"

    // When
    let script = chartIQScriptManager.getScriptForLoadChart("AAPL")

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForAddSeries() {
    // Given
    let correctScript = "stxx.addSeries(\"ibm\", {display:\"ibm\", color: \"#ff0000\",  isComparison:\"true\"});"

    // When
    let script = chartIQScriptManager.getScriptForAddSeries("ibm", color: .red, isComparison: true)

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForRemoveSeries() {
    // Given
    let correctScript = "stxx.removeSeries(\"ibm\");"

    // When
    let script = chartIQScriptManager.getScriptForRemoveSeries("ibm")

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForChartScale() {
    // Given
    let correctScript = "stxx.layout.chartScale;"

    // When
    let script = chartIQScriptManager.getScriptForChartScale()

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForSetChartScale() {
    // Given
    let correctScript = "stxx.layout.chartScale = \"log\";"

    // When
    let script = chartIQScriptManager.getScriptForSetChartScale(.log)

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForSetChartStyle() {
    // Given
    let correctScript = "stxx.setStyle(\"stx_grid\",\"color\",\"#ff0000\");"

    // When
    let script = chartIQScriptManager.getScriptForSetChartStyle("stx_grid",
                                                                attribute: "color",
                                                                value: UIColor.red.toHexString())

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForSetChartProperty() {
    // Given
    let correctScript = "stxx.chartmaxTicks = 200;"

    // When
    let script = chartIQScriptManager.getScriptForSetChartProperty("maxTicks", value: 200)

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForSetChartPropertyWithStringValue() {
    // Given
    let correctScript = "stxx.chart.maxTicks = \"200\";"

    // When
    let script = chartIQScriptManager.getScriptForSetChartProperty("maxTicks", value: "200")

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForChartProperty() {
    // Given
    let correctScript = mobileNameSpace + "getChartProperty(\"maxTicks\");"

    // When
    let script = chartIQScriptManager.getScriptForChartProperty("maxTicks")

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForSetEngineProperty() {
    // Given
    let correctScript = "stxx.allowZoom = true;"

    // When
    let script = chartIQScriptManager.getScriptForSetEngineProperty("allowZoom", value: true)

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForSetEnginePropertyWithStringValue() {
    // Given
    let correctScript = "stxx.allowZoom = \"true\";"

    // When
    let script = chartIQScriptManager.getScriptForSetEngineProperty("allowZoom", value: "true")

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForEngineProperty() {
    // Given
    let correctScript = mobileNameSpace + "getEngineProperty(\"allowZoom\");"

    // When
    let script = chartIQScriptManager.getScriptForEngineProperty("allowZoom")

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForEnableCrosshairs() {
    // Given
    let correctScript = mobileNameSpace + "enableCrosshairs(true);"

    // When
    let script = chartIQScriptManager.getScriptForEnableCrosshairs(true)

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForCrosshairsEnabled() {
    // Given
    let correctScript = "if (stxx.layout.crosshair == true) { \"true\" } else { \"false\" } "

    // When
    let script = chartIQScriptManager.getScriptForCrosshairsEnabled()

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForHudDetails() {
    // Given
    let correctScript = mobileNameSpace + "getHudDetails();"

    // When
    let script = chartIQScriptManager.getScriptForHudDetails()

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForChartAvailable() {
    // Given
    let correctScript = "if (" + mobileNameSpace + "isChartAvailable() == true) { \"true\" } else { \"false\" } "

    // When
    let script = chartIQScriptManager.getScriptForChartAvailable()

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForSetTheme() {
    // Given
    let correctScript = mobileNameSpace + "setTheme(\"day\");"

    // When
    let script = chartIQScriptManager.getScriptForSetTheme(.day)

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForResizeChart() {
    // Given
    let correctScript = "stxx.resizeChart();"

    // When
    let script = chartIQScriptManager.getScriptForResizeChart()

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForClearChart() {
    // Given
    let correctScript = "stxx.destroy();"

    // When
    let script = chartIQScriptManager.getScriptForClearChart()

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForSetExtendHours() {
    // Given
    let correctScript = mobileNameSpace + "toggleExtendedHours(true);"

    // When
    let script = chartIQScriptManager.getScriptForSetExtendHours(true)

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForSetInvertYAxis() {
    // Given
    let correctScript = "stxx.flipChart(true);"

    // When
    let script = chartIQScriptManager.getScriptForSetInvertYAxis(true)

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForTranslations() {
    // Given
    let correctScript = mobileNameSpace + "getTranslations(\"ru\");"

    // When
    let script = chartIQScriptManager.getScriptForTranslations("ru")

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForSetLanguage() {
    // Given
    let correctScript = mobileNameSpace + "setLanguage(\"ru\");"

    // When
    let script = chartIQScriptManager.getScriptForSetLanguage("ru")

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForPush() {
    // Given
    let correctScript = mobileNameSpace + "loadChart(\"\", [  {    \"Open\" : 100.2,    \"Volume\" : 66188138,    " +
      "\"Adj_Close\" : 100.42,    \"DT\" : \"2020-09-08T10:00:00.000Z\",    \"High\" : 100.75,    " +
    "\"Low\" : 99.599999999999994,    \"Close\" : 100.42  }]); "

    let jsonString = "[  {    \"Open\" : 100.2,    \"Volume\" : 66188138,    \"Adj_Close\" : 100.42,    " +
      "\"DT\" : \"2020-09-08T10:00:00.000Z\",    \"High\" : 100.75,    \"Low\" : 99.599999999999994,    " +
    "\"Close\" : 100.42  }]"

    // When
    let script = chartIQScriptManager.getScriptForPush(jsonString)

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForPushUpdate() {
    // Given
    let correctScript = mobileNameSpace + "parseData(\'[  {    \"Open\" : 100.2,    \"Volume\" : 66188138,    " +
      "\"Adj_Close\" : 100.42,    \"DT\" : \"2020-09-08T10:00:00.000Z\",    \"High\" : 100.75,    \"Low\" : " +
    "99.599999999999994,    \"Close\" : 100.42  }]\');"

    let jsonString = "[  {    \"Open\" : 100.2,    \"Volume\" : 66188138,    \"Adj_Close\" : 100.42,    " +
      "\"DT\" : \"2020-09-08T10:00:00.000Z\",    \"High\" : 100.75,    \"Low\" : 99.599999999999994,    " +
    "\"Close\" : 100.42  }]"

    // When
    let script = chartIQScriptManager.getScriptForPushUpdate(jsonString)

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForStudyParameters() {
    // Given
    let correctScript = mobileNameSpace + "getStudyParameters(\"‌Alligator‌ (y,13,8,8,5,5,3,n)\" , \"inputs\");"

    let studyFullName = "‌Alligator‌ (y,13,8,8,5,5,3,n)"
    let study = ChartIQStudy(shortName: studyFullName,
                             fullName: studyFullName,
                             originalName: studyFullName,
                             inputs: nil,
                             outputs: nil,
                             parameters: nil)

    // When
    let script = chartIQScriptManager.getScriptForStudyParameters(study, type: .inputs)

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForSetStudyWithKeyValue() {
    // Given
    let correctScript = mobileNameSpace + "setStudy(\"‌Alligator‌ (y,13,8,8,5,5,3,n)-2\", \"Lips\", \"#00DD00\")"

    // When
    let script = chartIQScriptManager.getScriptForSetStudyParameter("‌Alligator‌ (y,13,8,8,5,5,3,n)-2",
                                                                    key: "Lips",
                                                                    value: "#00DD00")

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForSetStudyWithParameters() {
    // Given
    let correctScript = "var s=stxx.layout.studies; var selectedSd = {}; for(var n in s){ " +
      "var sd=s[n]; if (sd.name === \"‌Alligator‌ (y,13,8,8,5,5,3,n)-2\") { selectedSd = sd; }} var helper = " +
      "new CIQ.Studies.DialogHelper({sd:selectedSd,stx:stxx}); var isFound = false; var newInputParameters = {}; " +
      "var newOutputParameters = {}; var newParameters = {}; for (x in helper.inputs) {   var input = " +
      "helper.inputs[x];    if (input[\"name\"] === \"Lips\") {        isFound = true;        if (input[\"type\"] === " +
      "\"text\" || input[\"type\"] === \"select\") {            newInputParameters[\"Lips\"] = \"#00DD00\";        } " +
      "else if (input[\"type\"] === \"number\") {            newInputParameters[\"Lips\"] = parseFloat(\"#00DD00\");" +
      "        } else if (input[\"type\"] === \"checkbox\") {            newInputParameters[\"Lips\"] = true;        " +
      "}    } } if (isFound == false) {    for (x in helper.outputs) {        var output = helper.outputs[x];        " +
      "if (output[\"name\"] === \"Lips\") {            newOutputParameters[\"Lips\"] = \"#00DD00\";        }    } } " +
      "if (isFound == false) {    if(\"Lips\".includes(\"Color\")) {        newParameters[\"Lips\"] = \"#00DD00\";    " +
      "} else if(\"Lips\".includes(\"Enabled\")) {        newParameters[\"Lips\"] = true;    } else {        " +
      "newParameters[\"Lips\"] = parseFloat(\"#00DD00\");    } } isFound = false; helper.updateStudy({inputs:" +
      "newInputParameters, outputs:newOutputParameters, parameters:newParameters}); console.log(JSON.stringify" +
    "(newParameters)) "

    let parameters: [String: String] = [
      "Lips": "#00DD00"
    ]

    let studyFullName = "‌Alligator‌ (y,13,8,8,5,5,3,n)-2"
    let study = ChartIQStudy(shortName: studyFullName,
                             fullName: studyFullName,
                             originalName: studyFullName,
                             inputs: nil,
                             outputs: nil,
                             parameters: nil)

    // When
    let script = chartIQScriptManager.getScriptForSetStudyParameters(study, parameters: parameters)

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForAddStudy() {
    // Given
    let correctScript = mobileNameSpace + "addStudy(\'Alligator\', null, null);"

    // When
    let script = chartIQScriptManager.getScriptForAddStudy("Alligator", studyInputs: "null", studyOutputs: "null")

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForRemoveStudy() {
    // Given
    let correctScript = mobileNameSpace + "removeStudy(\'‌Alligator‌ (y,13,8,8,5,5,3,n)\');"
    let studyFullName = "‌Alligator‌ (y,13,8,8,5,5,3,n)"
    let study = ChartIQStudy(shortName: studyFullName,
                             fullName: studyFullName,
                             originalName: studyFullName,
                             inputs: nil,
                             outputs: nil,
                             parameters: nil)
    // When
    let script = chartIQScriptManager.getScriptForRemoveStudy(study)

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForRemoveAllStudies() {
    // Given
    let correctScript = mobileNameSpace + "removeAllStudies();"

    // When
    let script = chartIQScriptManager.getScriptForRemoveAllStudies()

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForActiveStudies() {
    // Given
    let correctScript = mobileNameSpace + "getActiveStudies();"

    // When
    let script = chartIQScriptManager.getScriptForActiveStudies()

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForCurrentDrawTool() {
    // Given
    let correctScript = "currentDrawing"

    // When
    let script = chartIQScriptManager.getScriptForCurrentDrawTool()

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForEnableDrawing() {
    // Given
    let correctScript = "currentDrawing = \"freeform\"; stxx.changeVectorType(currentDrawing); "

    // When
    let script = chartIQScriptManager.getScriptForEnableDrawing(.doodle)

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForRestoreDefaultDrawingConfig() {
    // Given
    let correctScript = mobileNameSpace + "restoreDefaultDrawingConfig(\"trendline\", false);"

    // When
    let script = chartIQScriptManager.getScriptForRestoreDefaultDrawingConfig(.trend, all: false)

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForDrawingParameters() {
    // Given
    let correctScript = mobileNameSpace + "getDrawingParameters(\"annotation\");"

    // When
    let script = chartIQScriptManager.getScriptForDrawingParameters(.annotation)

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForSetDrawingParameter() {
    // Given
    let correctScript = mobileNameSpace + "setDrawingParameters(\"color\", \"#0073ba\");"

    // When
    let script = chartIQScriptManager.getScriptForSetDrawingParameter("color", value: "#0073ba")

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForDeleteDrawing() {
    // Given
    let correctScript = mobileNameSpace + "deleteDrawing();"

    // When
    let script = chartIQScriptManager.getScriptForDeleteDrawing()

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForCloneDrawing() {
    // Given
    let correctScript = mobileNameSpace + "cloneDrawing();"

    // When
    let script = chartIQScriptManager.getScriptForCloneDrawing()

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForManageLayerDrawing() {
    // Given
    let correctScript = mobileNameSpace + "layerDrawing(\"bottom\");"

    // When
    let script = chartIQScriptManager.getScriptForManageLayerDrawing(.bottom)

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForUndo() {
    // Given
    let correctScript = mobileNameSpace + "undo();"

    // When
    let script = chartIQScriptManager.getScriptForUndo()

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForRedo() {
    // Given
    let correctScript = mobileNameSpace + "redo();"

    // When
    let script = chartIQScriptManager.getScriptForRedo()

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForDisableDrawing() {
    // Given
    let correctScript = "stxx.changeVectorType(null); currentDrawing = \"\" ; "

    // When
    let script = chartIQScriptManager.getScriptForDisableDrawing()

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForClearDrawing() {
    // Given
    let correctScript = "stxx.clearDrawings();"

    // When
    let script = chartIQScriptManager.getScriptForClearDrawing()

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForInvoke() {
    // Given
    let correctScript = "stxx.setCandleWidth(5);"

    // When
    let script = chartIQScriptManager.getScriptForInvoke("setCandleWidth", jsonString: "[5]")

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForStudyObjects() {
    // Given
    let correctScript = "JSON.stringify(CIQ.Studies.studyLibrary);"

    // When
    let script = chartIQScriptManager.getScriptForStudyObjects()

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForLoadDefaultSetting() {
    // Given
    let correctScript = "stxx.layout.chartScale = \"log\";"

    // When
    let script = chartIQScriptManager.getScriptForLoadDefaultSetting()

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForFormatJSQuoteData() {
    // Given
    let correctScript = mobileNameSpace + "parseData(\'[  {    \"Open\" : 100.2,    \"Volume\" : 66188138,    " +
      "\"Adj_Close\" : 100.42,    \"DT\" : \"2020-09-08T10:00:00.000Z\",    \"High\" : 100.75,    " +
    "\"Low\" : 99.599999999999994,    \"Close\" : 100.42  }]\', \"KETSMXAUPW\");"

    let jsonString = "[  {    \"Open\" : 100.2,    \"Volume\" : 66188138,    \"Adj_Close\" : 100.42,    " +
      "\"DT\" : \"2020-09-08T10:00:00.000Z\",    \"High\" : 100.75,    \"Low\" : 99.599999999999994,    " +
    "\"Close\" : 100.42  }]"

    // When
    let script = chartIQScriptManager.getScriptForFormatJSQuoteData(jsonString, cb: "KETSMXAUPW")

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForAddDrawingListener() {
    // Given
    let correctScript = mobileNameSpace + "addDrawingListener();"

    // When
    let script = chartIQScriptManager.getScriptForAddDrawingListener()

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForAddMeasureListener() {
    // Given
    let correctScript = mobileNameSpace + "addMeasureListener();"

    // When
    let script = chartIQScriptManager.getScriptForAddMeasureListener()

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetScriptForAddLayoutListener() {
    // Given
    let correctScript = mobileNameSpace + "addLayoutListener()"

    // When
    let script = chartIQScriptManager.getScriptForAddLayoutListener()

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetStudyDescriptorScript() {
    // Given
    let correctScript = "var s=stxx.layout.studies; var selectedSd = {}; for(var n in s){ " +
    "var sd=s[n]; if (sd.name === \"‌Aroon‌ (14)\") { selectedSd = sd; }} "

    // When
    let script = chartIQScriptManager.getStudyDescriptorScript("‌Aroon‌ (14)")

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsSafeScriptParameter() {
    // Given
    let correctScript = "&gt;&apos;W&apos;\\&lt; &gt;&apos;Acc&apos;\\&lt; &gt;&apos;Dist&apos;\\&lt;&amp;"

    // When
    let script = chartIQScriptManager.safeScriptParameter(">'W'\\< >'Acc'\\< >'Dist'\\<&")

    // Then
    XCTAssertEqual(correctScript, script)
  }

  func testsGetUpdateStudyParametersScript() {
    // Given
    let correctScript = "for (x in helper.inputs) {   var input = helper.inputs[x];    " +
      "if (input[\"name\"] === \"Aroon Up\") {        isFound = true;        if (input[\"type\"] === \"text\" || " +
      "input[\"type\"] === \"select\") {            newInputParameters[\"Aroon Up\"] = \"#1d1d1d\";        } " +
      "else if (input[\"type\"] === \"number\") {            newInputParameters[\"Aroon Up\"] = " +
      "parseFloat(\"#1d1d1d\");        } else if (input[\"type\"] === \"checkbox\") {            " +
      "newInputParameters[\"Aroon Up\"] = true;        }    } } if (isFound == false) {    for (x in helper.outputs) " +
      "{        var output = helper.outputs[x];        if (output[\"name\"] === \"Aroon Up\") {            " +
      "newOutputParameters[\"Aroon Up\"] = \"#1d1d1d\";        }    } } if (isFound == false) {    " +
      "if(\"Aroon Up\".includes(\"Color\")) {        newParameters[\"Aroon Up\"] = \"#1d1d1d\";    } " +
      "else if(\"Aroon Up\".includes(\"Enabled\")) {        newParameters[\"Aroon Up\"] = true;    } " +
    "else {        newParameters[\"Aroon Up\"] = parseFloat(\"#1d1d1d\");    } } isFound = false; "

    // When
    let script = chartIQScriptManager.getUpdateStudyParametersScript("Aroon Up", value: "#1d1d1d")

    // Then
    XCTAssertEqual(correctScript, script)
  }
}
