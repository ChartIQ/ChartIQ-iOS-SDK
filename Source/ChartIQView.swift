//
//  ChartIQView.swift
//  ChartIQ
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit
import WebKit

// MARK: - ChartIQView

/// The ChartIQ view.
public class ChartIQView: UIView {

  // MARK: - Public Properties

  /// The ChartIQ delegate.
  public weak var delegate: ChartIQDelegate?

  /// The ChartIQ dataSource.
  public weak var dataSource: ChartIQDataSource?

  /// The ChartIQ URL.
  public static var chartIQUrl: String {
    return ChartIQView.url
  }

  /// The ChartIQ refresh interval.
  public static var chartIQRefreshInterval: Int {
    return ChartIQView.refreshInterval
  }

  /// The ChartIQ voiceover fields.
  public static var chartIQVoiceoverFields: [String: Bool] {
    return ChartIQView.voiceoverFields
  }

  /// The ChartIQ data method.
  public var dataMethod: ChartIQDataMethod {
    return chartIQDataMethod
  }

  /// The ChartIQ symbol.
  public var symbol: String {
    let script = scriptManager.getScriptForSymbol()
    return webView.evaluateJavaScriptWithReturn(script) ?? ""
  }

  /// The ChartIQ interval.
  public var interval: String {
    let script = scriptManager.getScriptForInterval()
    if let intervalRawString = webView.evaluateJavaScriptWithReturn(script) {
      return intervalRawString
    }
    return Const.Core.baseInterval
  }

  /// The ChartIQ timeUnit.
  public var timeUnit: ChartIQTimeUnit {
    let script = scriptManager.getScriptForTimeUnit()
    if let timeUnitRawString = webView.evaluateJavaScriptWithReturn(script),
       let timeUnit = ChartIQTimeUnit(stringValue: timeUnitRawString) {
      return timeUnit
    }
    return Const.Core.baseTimeUnit
  }

  /// The ChartIQ periodicity.
  public var periodicity: Int {
    let script = scriptManager.getScriptForPeriodicity()
    if let periodicityStr = webView.evaluateJavaScriptWithReturn(script),
       let periodicity = Int(periodicityStr) {
      return periodicity
    }
    return Const.Core.basePeriodicity
  }

  /// The ChartIQ chart type.
  public var chartType: ChartIQChartType {
    let script = scriptManager.getScriptForChartType()
    if let chartTypeStringValue = webView.evaluateJavaScriptWithReturn(script),
       let chartType = ChartIQChartType(stringValue: chartTypeStringValue) {
      return chartType
    }
    return Const.Core.baseChartType
  }

  /// The ChartIQ chart aggregation type.
  public var chartAggregationType: ChartIQChartAggregationType? {
    let script = scriptManager.getScriptForAggregationType()
    if let aggregationTypeStringValue = webView.evaluateJavaScriptWithReturn(script) {
      let aggregationType = ChartIQChartAggregationType(stringValue: aggregationTypeStringValue)
      return aggregationType
    }
    return nil
  }

  /// The ChartIQ chart scale.
  public var chartScale: ChartIQScale {
    let script = scriptManager.getScriptForScale()
    if let scaleStringValue = webView.evaluateJavaScriptWithReturn(script),
       let scaleValue = ChartIQScale(stringValue: scaleStringValue) {
      return scaleValue
    }
    return Const.Core.baseChartScale
  }

  /// The ChartIQ isExtendedHours property.
  public var isExtendedHours: Bool {
    let script = scriptManager.getScriptForExtendedHours()
    if let isExtendedHoursStringValue = webView.evaluateJavaScriptWithReturn(script),
       let isExtendedHours = Bool(isExtendedHoursStringValue) {
      return isExtendedHours
    }
    return false
  }

  /// The ChartIQ isInvertYAxis property.
  public var isInvertYAxis: Bool {
    let script = scriptManager.getScriptForInvertYAxis()
    if let isInvertYAxisStringValue = webView.evaluateJavaScriptWithReturn(script),
       let isInvertYAxis = Bool(isInvertYAxisStringValue) {
      return isInvertYAxis
    }
    return false
  }

  // MARK: - Internal Properties

  internal var webView: WKWebView!
  internal var chartIQDataMethod: ChartIQDataMethod = .push
  internal var allStudies: [ChartIQStudy] = []
  internal var scriptManager = ChartIQScriptManager()
  internal static var url = ""
  internal static var refreshInterval = 0
  internal static var voiceoverFields: [String: Bool] = [:]

  // MARK: - Public Methods
  // MARK: - Public Initializers

  /// Init ChartIQ view with frame.
  ///
  /// - Parameters:
  ///   - frame: The ChartIQ view frame.
  override public init(frame: CGRect) {
    super.init(frame: frame)

    initialize()
  }

  /// Init ChartIQ view with coder.
  ///
  /// - Parameters:
  ///   - coder: The ChartIQ view coder.
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    initialize()
  }

  // MARK: - Public Helpers

  /// Helper to get the current WebView.
  ///
  /// - Returns: The current WebView.
  public func getWebView() -> WKWebView {
    return webView
  }

  /// Cleans up the message handlers in order to avoid a memory leak.
  /// Should be called when the view is about to get deallocated (e.g. the deinit of its superview).
  public func cleanup() {
    let messageHandlers = ChartIQCallbackMessage.allMessageHandlers()
    messageHandlers.forEach {
      webView.configuration.userContentController.removeScriptMessageHandler(forName: $0.stringValue)
    }
  }

  /// Sets your WebView URL here.
  ///
  /// - Parameters:
  ///   - url: The starting URL.
  public static func start(url: String) {
    ChartIQView.url = url
  }

  /// Sets ChartIQ URL.
  ///
  /// - Parameters:
  ///   - url: The ChartIQ URL.
  public func setChartIQUrl(_ url: String) {
    ChartIQView.url = url
    if let url = URL(string: url) {
      webView.load(URLRequest(url: url))
    }
  }

  /// Sets ChartIQ refresh Interval.
  ///
  /// - Parameters:
  ///   - refreshInterval: The ChartIQ refresh Interval.
  public func setRefreshInterval(_ refreshInterval: Int) {
    ChartIQView.refreshInterval = refreshInterval
  }

  /// Sets ChartIQ voiceover fields.
  ///
  /// - Parameters:
  ///   - voiceoverFields: The ChartIQ voiceover fields.
  public func setVoiceoverFields(_ voiceoverFields: [String: Bool]) {
    ChartIQView.voiceoverFields = voiceoverFields
  }

  // MARK: - Public Chart Controls

  /// Sets the data method to "push" or "pull".
  ///
  /// - Parameters:
  ///   - method: The ChartIQ data method.
  public func setDataMethod(_ method: ChartIQDataMethod) {
    chartIQDataMethod = method
    if method == .pull {
      debugPrint("If you want to add a quotefeed please do so in your javascript code.")
    } else {
      let script = scriptManager.getScriptForLoadChart()
      webView.evaluateJavaScript(script, completionHandler: nil)
    }
  }

  /// Sets the base chart type.
  /// Will remove any aggregation type and switch your chart to display the new chartType.
  ///
  /// - Parameters:
  ///   - chartType: The ChartIQ chart type.
  public func setChartType(_ chartType: ChartIQChartType) {
    let script = scriptManager.getScriptForSetChartType(chartType)
    webView.evaluateJavaScript(script, completionHandler: nil)
  }

  /// Sets the base aggregation type.
  /// This function should not be used to set chartTypes. Instead use setChartType.
  ///
  /// - Parameters:
  ///   - aggregationType: The ChartIQ aggregation type.
  public func setAggregationType(_ aggregationType: ChartIQChartAggregationType) {
    let script = scriptManager.getScriptForSetAggregationType(aggregationType)
    webView.evaluateJavaScript(script, completionHandler: nil)
  }

  /// Sets the periodicity and interval for the chart. Interval describes the raw data interval (1, 5, 30, "day") while period describes the multiple
  /// of that interval (7 minutes, 3 days, 7 X 5 minutes). This method sets the new periodicity and creates a new dataSet.
  ///
  /// - Parameters:
  ///   - period: The number of elements from masterData to roll-up together into one data point on the chart (candle,bar, etc).
  ///   If set to 30 in a candle chart, for example, each candle will represent 30 raw elements of interval/timeUnit type.
  ///   - interval: Further qualifies pre-rolled details of intra-day timeUnits ("millisecond","second","minute") and will be converted to “1” if used
  ///   with "day","week" or "month" 'timeUnit'. Some feeds provide data that is already rolled up.
  ///   For example, there may be a feed that provides 5 minute bars.
  ///   To let the chart know you want that 5-minute bar from your feed instead of having the chart get individual 1 minute bars and roll them up,
  ///   you would set the interval to '5' and timeUnit to 'minute'.
  ///   - timeUnit: The ChartIQ time unit.
  ///   If not set, will default to "minute". "hour" is NOT a valid timeUnit. Use timeUnit:"minute", interval:60 instead.
  public func setPeriodicity(_ period: Int, interval: String, timeUnit: ChartIQTimeUnit = .minute) {
    let script = scriptManager.getScriptForSetPeriodicity(period, interval: interval, timeUnit: timeUnit)
    webView.evaluateJavaScript(script, completionHandler: nil)
  }

  /// Renders a chart for a particular instrument from the data passed in or fetches new data from the attached CIQ.QuoteFeed.
  /// This is the method that should be called every time a new chart needs to be drawn for a different instrument.
  ///
  /// - Parameters:
  ///   - symbol: The symbol for the new chart.
  public func loadChart(_ symbol: String) {
    if UIAccessibility.isVoiceOverRunning {
      let script = scriptManager.getScriptForAccessibilityMode()
      webView.evaluateJavaScript(script, completionHandler: nil)
    }
    let script = scriptManager.getScriptForLoadChart(symbol)
    webView.evaluateJavaScript(script, completionHandler: nil)
  }

  // MARK: - Series

  /// Returns an array of all the series.
  ///
  /// - Returns: Array of ChartIQSeries models.
  public func getActiveSeries() -> [ChartIQSeries] {
    let script = scriptManager.getScriptForSeries()
    var activeSeries: [ChartIQSeries] = []
    let result = webView.evaluateJavaScriptWithReturn(script)
    if let result = result, let data = result.data(using: .utf8),
       let dictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
      for key in dictionary.keys {
        if let series = ChartIQSeries(dictionary: dictionary, key: key) {
          activeSeries.append(series)
        }
      }
      activeSeries.sort {
        $0.symbolName.localizedCaseInsensitiveCompare($1.symbolName) == ComparisonResult.orderedAscending
      }
    }
    return activeSeries
  }

  /// Adds a series of data to the chart. A series can be displayed (for instance like a comparison chart) or it can be hidden (for instance to drive a study).
  ///
  /// - Parameters:
  ///   - series: The ChartIQSeries model to add.
  ///   - isComparison: The bool value used for ???.
  public func addSeries(_ series: ChartIQSeries, isComparison: Bool) {
    let script = scriptManager.getScriptForAddSeries(series.symbolName, color: series.color, isComparison: isComparison)
    webView.evaluateJavaScript(script, completionHandler: nil)
  }

  /// Detaches a series from all associated renderers in the chart, removing the actual series data from masterData.
  ///
  /// - Parameters:
  ///   - symbol: The series symbol to remove.
  public func removeSeries(_ symbol: String) {
    let script = scriptManager.getScriptForRemoveSeries(symbol)
    webView.evaluateJavaScript(script, completionHandler: nil)
  }

  /// Sets series parameters on the chart.
  ///
  /// - Parameters:
  ///   - symbol: The String Object. The name of symbol for series.
  ///   - parameterName: The String Object. The name of parameter to modify.
  ///   - value: The String Object. The value for parameter.
  public func setSeriesParameter(_ symbol: String, parameterName: String, value: String) {
    let script = scriptManager.getScriptForSetSeriesParameter(symbol: symbol,
                                                              parameterName: parameterName,
                                                              value: value)
    webView.evaluateJavaScript(script, completionHandler: nil)
  }

  // MARK: - Scale

  /// Get ChartIQ chart scale.
  public func getChartScale() -> String? {
    let script = scriptManager.getScriptForChartScale()
    return webView.evaluateJavaScriptWithReturn(script)
  }

  /// Sets ChartIQ chart scale.
  ///
  /// - Parameters:
  ///   - scale: The ChartIQ chart scale.
  public func setScale(_ scale: ChartIQScale) {
    let script = scriptManager.getScriptForSetChartScale(scale)
    webView.evaluateJavaScript(script, completionHandler: nil)
  }

  /// Change a css style on the chart.
  ///
  /// - Parameters:
  ///   - object: The object whose style you wish to change (stx_grid, stx_xaxis, etc).
  ///   - attribute: The style name of the object you wish to change.
  ///   - value: The value to assign to the attribute.
  public func setChartStyle(_ object: String, attribute: String, value: String) {
    let script = scriptManager.getScriptForSetChartStyle(object, attribute: attribute, value: value)
    webView.evaluateJavaScript(script, completionHandler: nil)
  }

  /// Set a property value on the chart.
  ///
  /// - Parameters:
  ///   - property: The property name of the object you wish to change.
  ///   - value: The value to assign to the property.
  public func setChartProperty(_ property: String, value: Any) {
    let script = scriptManager.getScriptForSetChartProperty(property, value: value)
    webView.evaluateJavaScript(script, completionHandler: nil)
  }

  /// Get a property value on the chart.
  ///
  /// - Parameters:
  ///   - property: The property name of the object you wish to receive.
  public func getChartProperty(_ property: String) -> String? {
    let script = scriptManager.getScriptForChartProperty(property)
    return webView.evaluateJavaScriptWithReturn(script)
  }

  /// Change a property value on the chart engine.
  ///
  /// - Parameters:
  ///   - property: The property name of the object you wish to change.
  ///   - value: The value to assign to the property.
  public func setEngineProperty(_ property: String, value: Any) {
    let script = scriptManager.getScriptForSetEngineProperty(property, value: value)
    webView.evaluateJavaScript(script, completionHandler: nil)
  }

  /// Get a property value on the chart engine.
  ///
  /// - Parameters:
  ///   - property: The property name of the object you wish to receive.
  public func getEngineProperty(_ property: String) -> String? {
    let script = scriptManager.getScriptForEngineProperty(property)
    return webView.evaluateJavaScriptWithReturn(script)
  }

  /// Will toggle the crosshairs on or off.
  ///
  /// - Parameters:
  ///   - enable: The boolean value, true if need to enable crosshairs, false if need to disable crosshairs.
  public func enableCrosshairs(_ enable: Bool) {
    let script = scriptManager.getScriptForEnableCrosshairs(enable)
    webView.evaluateJavaScript(script, completionHandler: nil)
  }

  /// Checks if crosshairs is on.
  ///
  /// - Returns: True if crosshair is on.
  public func isCrosshairsEnabled() -> Bool {
    let script = scriptManager.getScriptForCrosshairsEnabled()
    return webView.evaluateJavaScriptWithReturn(script) == Const.General.trueStringValue
  }

  /// Checks if chart has finished loading.
  ///
  /// - Returns: True if the chart has finished loading.
  public func isChartAvailable() -> Bool {
    let script = scriptManager.getScriptForChartAvailable()
    return webView.evaluateJavaScriptWithReturn(script) == Const.General.trueStringValue
  }

  /// Gathers the necessary information for any HUD based on cursor position and returns that data.
  ///
  /// - Returns: The ChartIQCrosshairHUD model.
  public func getHudDetails() -> ChartIQCrosshairHUD? {
    let script = scriptManager.getScriptForHudDetails()
    let result = webView.evaluateJavaScriptWithReturn(script)
    if let result = result, let data = result.data(using: .utf8),
       let dictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: String] {
      return ChartIQCrosshairHUD(dictionary: dictionary)
    }
    return nil
  }

  /// Sets ChartIQ theme for the chart.
  /// Sets theme between 'day' or 'night' or none by adding in CSS classes to the chart's context.
  /// Also clears the chart containers backgroundColor and resets the engines styles.
  ///
  /// - Parameters:
  ///   - theme: The ChartIQ theme.
  public func setTheme(_ theme: ChartIQTheme) {
    let script = scriptManager.getScriptForSetTheme(theme)
    webView.evaluateJavaScript(script)
  }

  /// Resize chart.
  public func resizeChart() {
    let script = scriptManager.getScriptForResizeChart()
    webView.evaluateJavaScript(script, completionHandler: nil)
  }

  /// Clears out a chart, eliminating all references including the resizeTimer, quoteDriver, styles and eventListeners.
  public func clearChart() {
    let script = scriptManager.getScriptForClearChart()
    webView.evaluateJavaScript(script, completionHandler: nil)
  }

  /// Will toggle the extended hours on or off.
  ///
  /// - Parameters:
  ///   - isExtended: The boolean value, true if need to extend hours, false if need to disable extending.
  public func setExtendHours(_ isExtended: Bool) {
    let script = scriptManager.getScriptForSetExtendHours(isExtended)
    webView.evaluateJavaScript(script, completionHandler: nil)
  }

  /// Will toggle the invert y-axis on or off.
  ///
  /// - Parameters:
  ///   - isInverted: The boolean value, true if need to invert y-axis, false if need to disable inverting.
  public func setInvertYAxis(_ isInverted: Bool) {
    let script = scriptManager.getScriptForSetInvertYAxis(isInverted)
    webView.evaluateJavaScript(script, completionHandler: nil)
  }

  /// Get the language translations for the App
  ///
  /// - Parameters:
  ///   - languageCode: The language locale code value.
  public func getTranslations(_ languageCode: String) -> [String: Any] {
    let script = scriptManager.getScriptForTranslations(languageCode)
    var translationsJson: [String: Any] = [:]
    if let translationsString = webView.evaluateJavaScriptWithReturn(script),
       let data = translationsString.data(using: .utf8),
       let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
      translationsJson = json
    }
    return translationsJson
  }

  /// Set the language of the chart
  ///
  /// - Parameters:
  ///   - languageCode: The language locale code value.
  public func setLanguage(_ languageCode: String) {
    let script = scriptManager.getScriptForSetLanguage(languageCode)
    webView.evaluateJavaScript(script)
  }

  // MARK: - Public Chart Data

  /// Sets the chart data by push.
  ///
  /// - Parameters:
  ///   - data: An array of properly formatted OHLC quote objects to create a chart.
  public func push(_ data: [ChartIQData]) {
    let obj = data.map { $0.toDictionary() }
    guard let jsonData = try? JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted),
          let jsonString = String(data: jsonData,
                                  encoding: .utf8)?.replacingOccurrences(of: Const.General.newlineSymbol,
                                                                         with: "") else { return }
    let script = scriptManager.getScriptForPush(jsonString)
    webView.evaluateJavaScript(script, completionHandler: nil)
  }

  /// Uses this method to stream OHLC data into a chart.
  ///
  /// - Parameters:
  ///   - data: An array of properly formatted OHLC quote objects to append.
  public func pushUpdate(_ data: [ChartIQData]) {
    let obj = data.map { $0.toDictionary() }
    guard let jsonData = try? JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted),
          let jsonString = String(data: jsonData,
                                  encoding: .utf8)?.replacingOccurrences(of: Const.General.newlineSymbol,
                                                                         with: "") else { return }
    let script = scriptManager.getScriptForPushUpdate(jsonString)
    webView.evaluateJavaScript(script, completionHandler: nil)
  }

  // MARK: - Public Studies

  /// Returns an array of all the studies with a shortName derived from the key.
  ///
  /// - Returns: Array of ChartIQStudy models.
  public func getAllStudies() -> [ChartIQStudy] {
    return allStudies
  }

  /// Lists studies added on the Chart.
  ///
  /// - Returns: The array of ChartIQStudy models.
  public func getActiveStudies() -> [ChartIQStudy] {
    var addedStudy: [ChartIQStudy] = []
    let script = scriptManager.getScriptForActiveStudies()
    if let listString = webView.evaluateJavaScriptWithReturn(script), !listString.isEmpty {
      let list = listString.components(separatedBy: Const.General.doubleVerticalLinesSymbol)
      list.forEach({ study in
        if let studyObject = ChartIQStudy(jsStudyString: study) {
          addedStudy.append(studyObject)
        }
      })
    }
    return addedStudy
  }

  /// Will return the default parameters of a study if it is not active, or actual parameters for an active study.
  ///
  /// - Parameters:
  ///   - study: The ChartIQStudy model.
  ///   - type: What to return for the study. ChartIQStudyParametersType incapsulate values: "inputs", "outputs", "parameters".
  /// - Returns: The JSON Object or nil if an error occur.
  public func getStudyParameters(_ study: ChartIQStudy, type: ChartIQStudyParametersType) -> Any? {
    let script = scriptManager.getScriptForStudyParameters(study, type: type)
    if let jsonString = webView.evaluateJavaScriptWithReturn(script), let data = jsonString.data(using: .utf8),
       let json = try? JSONSerialization.jsonObject(with: data, options: []) {
      switch type {
      case .inputs:
        if let inputs = json as? [[String: Any]] {
          return inputs.filter({ input -> Bool in
            let name = input[Const.Study.nameParam] as? String
            return name != nil && name != Const.Study.idParam && name != Const.Study.displayParam
          })
        }
      case .outputs, .parameters:
        break
      }
      return json
    }
    return nil
  }

  /// Sets study parameters.
  /// Given an active study name this will update the study based on key value pair you pass in to a DialogHelper.
  ///
  /// - Parameters:
  ///   - studyName: The name of the study from the chart engine's layout.
  ///   - key: The parameter name that must be defined in DialogHelper.
  ///   - value: The value to set in the studies corresponding DialogHelper.
  public func setStudyParameter(_ studyName: String, key: String, value: String) {
    let script = scriptManager.getScriptForSetStudyParameter(studyName, key: key, value: value)
    webView.evaluateJavaScript(script, completionHandler: nil)
  }

  /// Sets study parameters.
  ///
  /// - Parameters:
  ///   - study: The ChartIQStudy model.
  ///   - parameter: The parameter name that must be defined in CIQ.Studies.DialogHelper.
  public func setStudyParameters(_ study: ChartIQStudy, parameters: [String: String]) {
    let script = scriptManager.getScriptForSetStudyParameters(study, parameters: parameters)
    webView.evaluateJavaScript(script, completionHandler: nil)
  }

  /// Adds a specific study to the chart.
  ///
  /// - Parameters:
  ///   - study: The ChartIQStudy model.
  ///   - forClone: The Bool value indicating whether a study will be added for cloning or for adding.
  ///   - inputs: Inputs for the study instance. If nil, it will use the paramters defined in CIQ.Studies.DialogHelper.
  ///   - outputs: Outputs for the study instance. If nil, it will use the paramters defined in CIQ.Studies.DialogHelper.
  /// - Throws: ChartIQStudyError.
  public func addStudy(_ study: ChartIQStudy,
                       forClone: Bool = false,
                       inputs: [String: Any]? = nil,
                       outputs: [String: Any]? = nil) throws {
    let studyName = forClone ? study.originalName : study.shortName
    var studyInputs = Const.Study.nullParam
    var studyOutputs = Const.Study.nullParam
    if let inputs = inputs,
       let jsonData = try? JSONSerialization.data(withJSONObject: inputs, options: .prettyPrinted),
       let jsonString = String(data: jsonData, encoding: .utf8) {
      studyInputs = jsonString
    }
    if let outputs = outputs,
       let jsonData = try? JSONSerialization.data(withJSONObject: outputs, options: .prettyPrinted),
       let jsonString = String(data: jsonData, encoding: .utf8) {
      studyOutputs = jsonString
    }
    if !allStudies.contains(where: { $0.shortName == studyName }) {
      throw ChartIQStudyError.studyNotFound
    }
    let script = scriptManager.getScriptForAddStudy(studyName, studyInputs: studyInputs, studyOutputs: studyOutputs)
    webView.evaluateJavaScript(script, completionHandler: nil)
  }

  /// Removes an active study in the chart engine's layout from the chart.
  ///
  /// - Parameters:
  ///   - study: The ChartIQStudy model.
  public func removeStudy(_ study: ChartIQStudy) {
    let script = scriptManager.getScriptForRemoveStudy(study)
    webView.evaluateJavaScript(script, completionHandler: nil)
  }

  /// Convenience function to remove all studies on the chart at once.
  public func removeAllStudies() {
    let script = scriptManager.getScriptForRemoveAllStudies()
    webView.evaluateJavaScript(script, completionHandler: nil)
  }

  // MARK: - Public Drawings

  /// Gets current draw tool.
  ///
  /// - Returns: The ChartIQDrawingTool.
  public func getCurrentDrawTool() -> ChartIQDrawingTool? {
    let script = scriptManager.getScriptForCurrentDrawTool()
    let currentDrawToolName = webView.evaluateJavaScriptWithReturn(script)
    for index in 0...ChartIQDrawingTool.measure.rawValue {
      if let drawingTool = ChartIQDrawingTool(rawValue: index), drawingTool.stringValue == currentDrawToolName {
        return drawingTool
      }
    }
    return nil
  }

  /// Enables drawing on the chart.
  ///
  /// - Parameters:
  ///   - tool: The ChartIQDrawingTool.
  public func enableDrawing(_ tool: ChartIQDrawingTool) {
    let script = scriptManager.getScriptForEnableDrawing(tool)
    webView.evaluateJavaScript(script, completionHandler: nil)
  }

  /// Will restore the drawing tool or tools to default configuration.
  ///
  /// - Parameters:
  ///   - tool: The ChartIQDrawingTool. May be nil if need to reset all drawing tools and the "all" parameter need to be equal "true".
  ///   - all: The boolean value, true if need to reset all drawing tools, false if need to disable concrete drawing tool.
  public func restoreDefaultDrawingConfig(_ tool: ChartIQDrawingTool, all: Bool) {
    let script = scriptManager.getScriptForRestoreDefaultDrawingConfig(tool, all: all)
    webView.evaluateJavaScript(script, completionHandler: nil)
  }

  /// Gets drawing parameters for a drawing tool.
  ///
  /// - Parameters:
  ///   - tool: The ChartIQDrawingTool.
  /// - Returns: The dictionary value of drawing parameters.
  public func getDrawingParameters(_ tool: ChartIQDrawingTool) -> [String: Any]? {
    if tool == .noTool { return [:] }
    let script = scriptManager.getScriptForDrawingParameters(tool)
    if let jsonString = webView.evaluateJavaScriptWithReturn(script), let data = jsonString.data(using: .utf8) {
      return try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
    }
    return nil
  }

  /// Sets drawing parameters on the chart.
  ///
  /// - Parameters:
  ///   - parameterName: The parameter name.
  ///   - value: The parameter value.
  public func setDrawingParameter(_ parameterName: String, value: Any) {
    let script = scriptManager.getScriptForSetDrawingParameter(parameterName, value: value)
    webView.evaluateJavaScript(script, completionHandler: nil)
  }

  /// The alternative version of the setDrawingParameter method.
  /// This method make the work with the most common type of parameters for drawing tools easier, offering a typed parameter ChartIQDrawingParameterType.
  /// As well as not a typed version of the method sets drawing parameters on the chart.
  ///
  /// - Parameters:
  ///   - parameter: The ChartIQDrawingParameterType.
  ///   - value: The parameter value.
  public func setDrawingParameter(_ parameter: ChartIQDrawingParameterType, value: Any) {
    let script = scriptManager.getScriptForSetDrawingParameter(parameter.stringValue, value: value)
    webView.evaluateJavaScript(script, completionHandler: nil)
  }

  /// Delete the selected drawing on the chart.
  public func deleteDrawing() {
    let script = scriptManager.getScriptForDeleteDrawing()
    webView.evaluateJavaScript(script, completionHandler: nil)
  }

  /// Clone the selected drawing on the chart.
  public func cloneDrawing() {
    let script = scriptManager.getScriptForCloneDrawing()
    webView.evaluateJavaScript(script, completionHandler: nil)
  }

  /// Manage drawing layer on the chart.
  ///
  /// - Parameters:
  ///   - layer: The ChartIQLayer parameter.
  public func manageLayerDrawing(_ layer: ChartIQLayer) {
    let script = scriptManager.getScriptForManageLayerDrawing(layer)
    webView.evaluateJavaScript(script, completionHandler: nil)
  }

  /// Undo the last drawing on the chart.
  ///
  /// - Returns: The bool value indicates if the drawing was the latest.
  public func undoDrawing() -> Bool {
    let script = scriptManager.getScriptForUndo()
    if let stringValue = webView.evaluateJavaScriptWithReturn(script), let boolValue = Bool(stringValue) {
      return boolValue
    }
    return false
  }

  /// Redo the last drawing on the chart.
  ///
  /// - Returns: The bool value indicates if the drawing was the latest.
  public func redoDrawing() -> Bool {
    let script = scriptManager.getScriptForRedo()
    if let stringValue = webView.evaluateJavaScriptWithReturn(script), let boolValue = Bool(stringValue) {
      return boolValue
    }
    return false
  }

  /// Disables drawing on the chart.
  public func disableDrawing() {
    let script = scriptManager.getScriptForDisableDrawing()
    webView.evaluateJavaScript(script, completionHandler: nil)
  }

  /// Clears drawing on the chart.
  public func clearDrawing() {
    let script = scriptManager.getScriptForClearDrawing()
    webView.evaluateJavaScript(script, completionHandler: nil)
  }

  /// Description Call any javascript function on the Chart Engine namespace
  ///
  /// - Parameters:
  ///   - functionName: The function name.
  ///   - args: The Arguments.
  public func invoke(_ functionName: String, args: Any...) -> Any {
    var jsonString = ""
    if let jsonData = try? JSONSerialization.data(withJSONObject: args, options: .prettyPrinted),
       let jsonDataString = String(data: jsonData,
                                   encoding: .utf8)?.replacingOccurrences(of: Const.General.newlineSymbol,
                                                                          with: "") {
      jsonString = jsonDataString
    }
    let script = scriptManager.getScriptForInvoke(functionName, jsonString: jsonString)
    guard let value = webView.evaluateJavaScriptWithReturn(script) else { return "" }
    return value
  }

  // MARK: - Internal Methods
  // MARK: - Internal Initializers

  internal func initialize() {
    setupWebView()
  }

  // MARK: - Internal Layouts

  /// Setup WebView.
  internal func setupWebView() {
    let messageHandlers = ChartIQCallbackMessage.allMessageHandlers()
    let userContentController = WKUserContentController()
    messageHandlers.forEach { userContentController.add(self, name: $0.stringValue) }
    let configuration = WKWebViewConfiguration()
    configuration.userContentController = userContentController

    webView = WKWebView(frame: bounds, configuration: configuration)
    webView.navigationDelegate = self
    webView.isOpaque = false
    addSubview(webView)
    setupConstraints()
    addLayoutListener()
    addDrawingListener()
    addMeasureListener()
    if let url = URL(string: ChartIQView.chartIQUrl) {
      webView.load(URLRequest(url: url))
    }
  }

  /// Setup constraints.
  internal func setupConstraints() {
    webView.translatesAutoresizingMaskIntoConstraints = false
    webView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    webView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    webView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    webView.topAnchor.constraint(equalTo: topAnchor).isActive = true
  }

  // MARK: - Internal Studies

  /// Gets all of the available studies.
  internal func retrieveAllStudies() {
    let script = scriptManager.getScriptForStudyObjects()
    webView.evaluateJavaScript(script) { [weak self] result, _ in
      guard let self = self else { return }
      if let result = result as? String, let data = result.data(using: .utf8),
         let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
         let generalStudyDict = jsonObject as? [String: Any] {
        for studyDictKey in generalStudyDict.keys {
          if let studyDict = generalStudyDict[studyDictKey] as? [String: Any] {
            let study = ChartIQStudy(dictionary: studyDict, key: studyDictKey)
            self.allStudies.append(study)
          }
        }
        self.allStudies.sort {
          $0.fullName.localizedCaseInsensitiveCompare($1.fullName) == ComparisonResult.orderedAscending
        }
      }
    }
  }

  // MARK: - Internal Helpers

  /// Uses this method to load the default ChartIQView setting.
  internal func loadDefaultSetting() {
    let script = scriptManager.getScriptForLoadDefaultSetting()
    webView.evaluateJavaScript(script, completionHandler: nil)
  }

  /// Uses this method to pass the array of ChartIQData to js and ask the chart to update.
  ///
  /// - Parameters:
  ///   - data: An array of properly formatted OHLC quote objects to append.
  ///   - cb: The callback key used in Javascript.
  internal func formatJSQuoteData(_ data: [ChartIQData], cb: String) {
    let jsonObject = data.map { $0.toDictionary() }
    guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
          let jsonString = String(data: jsonData,
                                  encoding: .utf8)?.replacingOccurrences(of: Const.General.newlineSymbol,
                                                                         with: "") else { return }
    let script = scriptManager.getScriptForFormatJSQuoteData(jsonString, cb: cb)
    webView.evaluateJavaScript(script, completionHandler: nil)
  }

  /// Uses this method to format object to printed JSON format.
  ///
  /// - Parameters:
  ///   - object: The object.
  /// - Returns: The JSON object.
  internal func formatObjectToPrintedJSONFormat(_ object: Any) -> String {
    guard let jsonData = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted),
          let jsonString = String(data: jsonData, encoding: .utf8) else { return "" }
    return jsonString
  }

  /// Sets a callbackListener with a type of drawing.
  internal func addDrawingListener() {
    let script = scriptManager.getScriptForAddDrawingListener()
    let userScript = WKUserScript(source: script, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
    webView.configuration.userContentController.addUserScript(userScript)
  }

  /// Sets a callbackListener with a type of drawing.
  internal func addMeasureListener() {
    let script = scriptManager.getScriptForAddMeasureListener()
    let userScript = WKUserScript(source: script, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
    webView.configuration.userContentController.addUserScript(userScript)
  }

  /// Sets a callbackListener with a type of layout.
  internal func addLayoutListener() {
    let script = scriptManager.getScriptForAddLayoutListener()
    let userScript = WKUserScript(source: script, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
    webView.configuration.userContentController.addUserScript(userScript)
  }
}

// MARK: - WebKit Script Message Handler

extension ChartIQView: WKScriptMessageHandler {

  public func userContentController(_ userContentController: WKUserContentController,
                                    didReceive message: WKScriptMessage) {
    guard let callbackMessage = ChartIQCallbackMessage(stringValue: message.name) else { return }
    let messageHandlers: [ChartIQCallbackMessage: (WKScriptMessage) -> Void] = [
      .newSymbol: newSymbolCallbackMessageHandler,
      .pullInitialData: pullInitialDataCallbackMessageHandler,
      .pullUpdateData: pullUpdateDataCallbackMessageHandler,
      .pullPaginationData: pullPaginationDataCallbackMessageHandler,
      .layout: layoutCallbackMessageHandler,
      .drawing: drawingCallbackMessageHandler,
      .measure: measureCallbackMessageHandler,
      .accessibility: accessibilityCallbackMessageHandler,
      .log: logCallbackMessageHandler
    ]
    messageHandlers[callbackMessage]?(message)
  }

  internal func newSymbolCallbackMessageHandler(message: WKScriptMessage) {
    guard let symbol = message.body as? String else { return }
    delegate?.chartIQView?(self, didUpdateSymbol: symbol)
  }

  internal func pullInitialDataCallbackMessageHandler(message: WKScriptMessage) {
    guard let message = message.body as? [String: Any] else { return }
    let cb = message[Const.CallbackMessage.callbackKeyParam] as? String ?? ""
    let params = ChartIQQuoteFeedParams(dictionary: message)
    dataSource?.pullInitialData(by: params, completionHandler: { [weak self] data in
      guard let self = self else { return }
      DispatchQueue.main.async {
        self.formatJSQuoteData(data, cb: cb)
      }
    })
  }

  internal func pullUpdateDataCallbackMessageHandler(message: WKScriptMessage) {
    guard let message = message.body as? [String: Any] else { return }
    let cb = message[Const.CallbackMessage.callbackKeyParam] as? String ?? ""
    let params = ChartIQQuoteFeedParams(dictionary: message)
    dataSource?.pullUpdateData(by: params, completionHandler: { [weak self] data in
      guard let self = self else { return }
      DispatchQueue.main.async {
        self.formatJSQuoteData(data, cb: cb)
      }
    })
  }

  internal func pullPaginationDataCallbackMessageHandler(message: WKScriptMessage) {
    guard let message = message.body as? [String: Any] else { return }
    let cb = message[Const.CallbackMessage.callbackKeyParam] as? String ?? ""
    let params = ChartIQQuoteFeedParams(dictionary: message)
    dataSource?.pullPaginationData(by: params, completionHandler: { [weak self] data in
      guard let self = self else { return }
      DispatchQueue.main.async {
        self.formatJSQuoteData(data, cb: cb)
      }
    })
  }

  internal func layoutCallbackMessageHandler(message: WKScriptMessage) {
    guard let message = message.body as? String, let data = message.data(using: .utf8),
          let layout = try? JSONSerialization.jsonObject(with: data, options: []) else { return }
    delegate?.chartIQView?(self, didUpdateLayout: layout)
  }

  internal func drawingCallbackMessageHandler(message: WKScriptMessage) {
    guard let message = message.body as? String, let data = message.data(using: .utf8),
          let drawings = try? JSONSerialization.jsonObject(with: data, options: []) else { return }
    delegate?.chartIQView?(self, didUpdateDrawing: drawings)
  }

  internal func measureCallbackMessageHandler(message: WKScriptMessage) {
    guard let message = message.body as? String, let data = message.data(using: .utf8) else { return }
    if let measureRawString = String(data: data, encoding: .utf8),
       let measure = measureRawString.slice(from: Const.General.quoteSymbol,
                                            to: Const.General.quoteSymbol) {
      delegate?.chartIQView?(self, didUpdateMeasure: measure)
    }
  }

  internal func accessibilityCallbackMessageHandler(message: WKScriptMessage) {
    guard let quote = message.body as? String else { return }
    let fieldsArray = quote.components(separatedBy: Const.General.doubleVerticalLinesSymbol)
    if fieldsArray.count == 6 {
      var selectedFields = ""
      if let dateField = ChartIQView.voiceoverFields[ChartIQQuoteField.date.stringValue], dateField {
        selectedFields += Const.General.commaSpaceSymbol + fieldsArray[0]
      }
      if let closeField = ChartIQView.voiceoverFields[ChartIQQuoteField.close.stringValue], closeField {
        selectedFields += Const.General.commaSpaceSymbol + fieldsArray[1]
      }
      if let openField = ChartIQView.voiceoverFields[ChartIQQuoteField.open.stringValue], openField {
        selectedFields += Const.General.commaSpaceSymbol + fieldsArray[2]
      }
      if let highField = ChartIQView.voiceoverFields[ChartIQQuoteField.high.stringValue], highField {
        selectedFields += Const.General.commaSpaceSymbol + fieldsArray[3]
      }
      if let lowField = ChartIQView.voiceoverFields[ChartIQQuoteField.low.stringValue], lowField {
        selectedFields += Const.General.commaSpaceSymbol + fieldsArray[4]
      }
      if let volumeField = ChartIQView.voiceoverFields[ChartIQQuoteField.volume.stringValue], volumeField {
        selectedFields += Const.General.commaSpaceSymbol + fieldsArray[5]
      }
      UIAccessibility.post(notification: UIAccessibility.Notification.announcement, argument: selectedFields)
    } else {
      UIAccessibility.post(notification: UIAccessibility.Notification.announcement, argument: quote)
    }
  }

  internal func logCallbackMessageHandler(message: WKScriptMessage) {
    guard let message = message.body as? [String: Any],
          let arguments = message[Const.LogMessage.argumentsParam] as? [String: String] else { return }
    let method = message[Const.LogMessage.methodParam] as? String ?? Const.LogMessage.logParam
    var msg: String = ""
    for (_, value) in arguments {
      if !msg.isEmpty {
        msg += Const.General.newlineSymbol
      }
      msg += value
    }
    debugPrint("\(method): \(msg)")
  }
}

// MARK: - WebKit Navigation Delegate

extension ChartIQView: WKNavigationDelegate {

  public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    loadDefaultSetting()
    delegate?.chartIQViewDidFinishLoading(self)
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      self.retrieveAllStudies()
    }
  }
}
