//
//  ChartIQScriptManagerProtocol.swift
//  ChartIQ
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import Foundation

// MARK: - ChartIQScriptManager Protocol

@objc(ChartIQScriptManagerProtocol)
internal protocol ChartIQScriptManagerProtocol {

  /// Returns a script that gets a symbol.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForSymbol() -> String

  /// Returns a script that gets an interval.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForInterval() -> String

  /// Returns a script that gets a time unit.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForTimeUnit() -> String

  /// Returns a script that gets a periodicity.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForPeriodicity() -> String

  /// Returns a script that gets a chart type.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForChartType() -> String

  /// Returns a script that gets an aggregation type.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForAggregationType() -> String

  /// Returns a script that gets a scale.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForScale() -> String

  /// Returns a script that gets an extended hours state.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForExtendedHours() -> String

  /// Returns a script that gets an invert y axis state.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForInvertYAxis() -> String

  /// Returns a script that loads a chart.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForLoadChart() -> String

  /// Returns a script that sets a chart type.
  ///
  /// - Parameters:
  ///   - chartType: The ChartIQChartType Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForSetChartType(_ chartType: ChartIQChartType) -> String
  
  /// Returns a script that sets the chart refresh interval
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForSetRefreshInterval(_ refreshInterval: Int) -> String

  /// Returns a script that sets an aggregation type.
  ///
  /// - Parameters:
  ///   - aggregationType: The ChartIQChartAggregationType Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForSetAggregationType(_ aggregationType: ChartIQChartAggregationType) -> String

  /// Returns a script that sets a periodicity.
  ///
  /// - Parameters:
  ///   - period: The Int Value.
  ///   - interval: The String Object.
  ///   - timeUnit: The ChartIQTimeUnit Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForSetPeriodicity(_ period: Int, interval: String, timeUnit: ChartIQTimeUnit) -> String

  /// Returns a script that gets an accessibility mode.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForAccessibilityMode() -> String

  /// Returns a script that loads a chart.
  ///
  /// - Parameters:
  ///   - symbol: The String Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForLoadChart(_ symbol: String) -> String

  // MARK: - Series

  /// Returns a script that returns series.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForSeries() -> String

  /// Returns a script that adds series.
  ///
  /// - Parameters:
  ///   - symbol: The String Object.
  ///   - color: The UIColor Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForAddSeries(_ symbol: String, color: UIColor, isComparison: Bool) -> String

  /// Returns a script that removes series.
  ///
  /// - Parameters:
  ///   - symbol: The String Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForRemoveSeries(_ symbol: String) -> String

  /// Returns a script that sets a series parameter.
  ///
  /// - Parameters:
  ///   - symbol: The String Object. The name of symbol for series.
  ///   - parameterName: The String Object. The name of parameter to modify.
  ///   - value: The String Object. The value for parameter.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForSetSeriesParameter(symbol: String, parameterName: String, value: String) -> String

  /// Returns a script that gets a chart scale.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForChartScale() -> String

  /// Returns a script that sets a chart scale.
  ///
  /// - Parameters:
  ///   - scale: The ChartIQScale Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForSetChartScale(_ scale: ChartIQScale) -> String

  /// Returns a script that sets a chart style.
  ///
  /// - Parameters:
  ///   - object: The String Object.
  ///   - attribute: The String Object.
  ///   - value: The String Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForSetChartStyle(_ object: String, attribute: String, value: String) -> String

  /// Returns a script that sets a chart property.
  ///
  /// - Parameters:
  ///   - property: The String Object.
  ///   - value: The Any Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForSetChartProperty(_ property: String, value: Any) -> String

  /// Returns a script that gets a chart property.
  ///
  /// - Parameters:
  ///   - property: The String Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForChartProperty(_ property: String) -> String

  /// Returns a script that sets an engine property.
  ///
  /// - Parameters:
  ///   - property: The String Object.
  ///   - value: The Any Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForSetEngineProperty(_ property: String, value: Any) -> String

  /// Returns a script that gets an engine property.
  ///
  /// - Parameters:
  ///   - property: The String Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForEngineProperty(_ property: String) -> String

  /// Returns a script that enables crosshairs.
  ///
  /// - Parameters:
  ///   - enable: The Bool Value.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForEnableCrosshairs(_ enable: Bool) -> String

  /// Returns a script that gets a crosshairs enabled status.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForCrosshairsEnabled() -> String

  /// Returns a script that gets hud details.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForHudDetails() -> String

  /// Returns a script that gets a chart available status.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForChartAvailable() -> String

  /// Returns a script that sets a theme.
  ///
  /// - Parameters:
  ///   - theme: The ChartIQTheme Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForSetTheme(_ theme: ChartIQTheme) -> String

  /// Returns a script that resizes a chart.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForResizeChart() -> String

  /// Returns a script that clears a chart.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForClearChart() -> String

  /// Returns a script that sets extended hours.
  ///
  /// - Parameters:
  ///   - isExtended: The Bool Value.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForSetExtendHours(_ isExtended: Bool) -> String

  /// Returns a script that sets an invert y axis.
  ///
  /// - Parameters:
  ///   - isInverted: The Bool Value.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForSetInvertYAxis(_ isInverted: Bool) -> String

  /// Returns a script that gets translations.
  ///
  /// - Parameters:
  ///   - languageCode: The String Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForTranslations(_ languageCode: String) -> String

  /// Returns a script that sets a language.
  ///
  /// - Parameters:
  ///   - languageCode: The String Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForSetLanguage(_ languageCode: String) -> String

  /// Returns a script that pushes a smth.
  ///
  /// - Parameters:
  ///   - symbol: The String Object
  ///   - data: The String Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForPush(_ symbol: String, data: String) -> String

  /// Returns a script that pushes an update.
  ///
  /// - Parameters:
  ///   - data: The String Object.
  ///   - useAsLastSale: The Bool Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForPushUpdate(_ data: String, useAsLastSale: Bool) -> String

  // MARK: - Studies

  /// Returns a script that gets active studies.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForActiveStudies() -> String

  /// Returns a script that gets study parameters.
  ///
  /// - Parameters:
  ///   - study: The ChartIQStudy model.
  ///   - type: The ChartIQStudyParametersType Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForStudyParameters(_ study: ChartIQStudy, type: ChartIQStudyParametersType) -> String

  /// Returns a script that sets a study.
  ///
  /// - Parameters:
  ///   - name: The String Object.
  ///   - key: The String Object.
  ///   - value: The String Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForSetStudyParameter(_ name: String, key: String, value: String) -> String

  /// Returns a script that sets a study.
  ///
  /// - Parameters:
  ///   - study: The ChartIQStudy model.
  ///   - parameters: The Dictionary Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForSetStudyParameters(_ study: ChartIQStudy, parameters: [String: String]) -> String

  /// Returns a script that adds a study.
  ///
  /// - Parameters:
  ///   - studyName: The String Object of the study name.
  ///   - studyInputs: The JSON String Object of the study inputs
  ///   - studyOutputs: The JSON String Object of the study outputs.
  ///   - studyParameters: The JSON String Object of the study parameters.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForAddStudy(_ studyName: String, studyInputs: String, studyOutputs: String, studyParameters: String) -> String

  /// Returns a script that removes a study.
  ///
  /// - Parameters:
  ///   - study: The ChartIQStudy model.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForRemoveStudy(_ study: ChartIQStudy) -> String

  /// Returns a script that removes all studies.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForRemoveAllStudies() -> String

  // MARK: - Signals

  /// Returns a script that adds a study as a signal.
  ///
  /// - Parameters:
  ///   - study: The ChartIQStudy model.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForAddSignalStudy(_ study: ChartIQStudy) -> String

  /// Returns a script that save a signal.
  ///
  /// - Parameters:
  ///   - signal: The ChartIQSignal model.
  ///   - isEdit: The Bool value.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForSaveSignal(_ signal: ChartIQSignal, isEdit: Bool) -> String

  /// Returns a script that gets active signals.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForActiveSignals() -> String

  /// Returns a script that toggle signal study.
  ///
  /// - Parameters:
  ///   - signal: The ChartIQSignal model.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForToggleSignal(_ signal: ChartIQSignal) -> String

  /// Returns a script that removes a signal.
  ///
  /// - Parameters:
  ///   - signal: The ChartIQSignal model.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForRemoveSignal(_ signal: ChartIQSignal) -> String

  // MARK: - Drawings

  /// Returns a script that gets a current drawing tool.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForCurrentDrawTool() -> String

  /// Returns a script that enables a drawing.
  ///
  /// - Parameters:
  ///   - tool: The ChartIQDrawingTool Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForEnableDrawing(_ tool: ChartIQDrawingTool) -> String

  /// Returns a script that restores a default drawing config.
  ///
  /// - Parameters:
  ///   - tool: The ChartIQDrawingTool Object that can be nil.
  ///   - all: The Bool Value.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForRestoreDefaultDrawingConfig(_ tool: ChartIQDrawingTool, all: Bool) -> String

  /// Returns a script that gets drawing parameters.
  ///
  /// - Parameters:
  ///   - tool: The ChartIQDrawingTool Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForDrawingParameters(_ tool: ChartIQDrawingTool) -> String

  /// Returns a script that sets a drawing parameter.
  ///
  /// - Parameters:
  ///   - parameterName: The String Object.
  ///   - value: The Any Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForSetDrawingParameter(_ parameterName: String, value: Any) -> String

  /// Returns a script that deletes a drawing.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForDeleteDrawing() -> String

  /// Returns a script that clones a drawing.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForCloneDrawing() -> String

  /// Returns a script that manages a layer drawing.
  ///
  /// - Parameters:
  ///   - layer: The ChartIQLayer Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForManageLayerDrawing(_ layer: ChartIQLayer) -> String

  /// Returns a script that undoes an action.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForUndo() -> String

  /// Returns a script that redoes an action.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForRedo() -> String

  /// Returns a script that disables a drawing.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForDisableDrawing() -> String

  /// Returns a script that clears a drawing.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForClearDrawing() -> String

  /// Returns a script that has been invoked.
  ///
  /// - Parameters:
  ///   - functionName: The String Object.
  ///   - jsonString: The String Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForInvoke(_ functionName: String, jsonString: String) -> String

  /// Returns a script that gets study objects.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForStudyObjects() -> String

  /// Returns a script that formats JSQuote data.
  ///
  /// - Parameters:
  ///   - json: The String Object.
  ///   - callbackId: The String Object.
  ///   - moreAvailable:The Bool Value.
  ///   - upToDate: The Bool Value
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForFormatJSQuoteData(_ json: String, callbackId: String, moreAvailable: Bool, upToDate: Bool) -> String

  /// Returns a script that gets a drawing listener.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForAddDrawingListener() -> String

  /// Returns a script that gets a measure listener.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForAddMeasureListener() -> String

  /// Returns a script that gets a layout listener.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getScriptForAddLayoutListener() -> String

  /// Uses this method to generate the javascript of getting study descriptor.
  ///
  /// - Parameters:
  ///   - name: The name of study descriptor.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getStudyDescriptorScript(_ name: String) -> String

  /// Uses this method in order to prevent the possibility of Javascript code injections.
  ///
  /// - Parameters:
  ///   - parameter: The javascript string parameter.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func safeScriptParameter(_ parameter: String) -> String

  /// Uses this method to generate the javascript of updating study parameter.
  ///
  /// - Parameters:
  ///   - parameter: The study parameter name.
  ///   - value: The study parameter value.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  func getUpdateStudyParametersScript(_ parameter: String, value: String) -> String
}
