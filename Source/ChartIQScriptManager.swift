//
//  ChartIQScriptManager.swift
//  ChartIQ
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import Foundation

// MARK: - ChartIQScriptManager

/// Encapsulates helper methods for working with the ChartIQ evaluate scripts methods.
internal class ChartIQScriptManager: ChartIQScriptManagerProtocol {

  // MARK: - Initializers

  internal init() {}

  // MARK: - Private Properties

  /// The string property used for define mobile name space for most evaluated scripts.
  private var mobileNameSpace = "CIQ.MobileBridge."

  // MARK: - Internal Methods

  /// Returns a script that gets a symbol.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForSymbol() -> String {
    let script = "stxx.chart.symbol"
    return script
  }

  /// Returns a script that gets an interval.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForInterval() -> String {
    let script = "stxx.layout.interval.toString()"
    return script
  }

  /// Returns a script that gets a time unit.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForTimeUnit() -> String {
    let script = "stxx.timeUnit"
    return script
  }

  /// Returns a script that gets a periodicity.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForPeriodicity() -> String {
    let script = "stxx.layout.periodicity.toString()"
    return script
  }

  /// Returns a script that gets a chart type.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForChartType() -> String {
    let script = "stxx.layout.chartType"
    return script
  }

  /// Returns a script that gets an aggregation type.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForAggregationType() -> String {
    let script = "stxx.layout.aggregationType"
    return script
  }

  /// Returns a script that gets a scale.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForScale() -> String {
    let script = "stxx.layout.chartScale"
    return script
  }

  /// Returns a script that gets an extended hours state.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForExtendedHours() -> String {
    let script = mobileNameSpace + "getLayoutProperty(\"extended\");"
    return script
  }

  /// Returns a script that gets an invert y axis state.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForInvertYAxis() -> String {
    let script = mobileNameSpace + "getLayoutProperty(\"flipped\");"
    return script
  }

  /// Returns a script that loads a chart.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForLoadChart() -> String {
    let script = mobileNameSpace + "loadChart();"
    return script
  }

  /// Returns a script that sets a chart type.
  ///
  /// - Parameters:
  ///   - chartType: The ChartIQChartType Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForSetChartType(_ chartType: ChartIQChartType) -> String {
    let script = mobileNameSpace + "setChartType(\"\(chartType.stringValue)\");"
    return script
  }

  /// Returns a script that sets an aggregation type.
  ///
  /// - Parameters:
  ///   - aggregationType: The ChartIQChartAggregationType Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForSetAggregationType(_ aggregationType: ChartIQChartAggregationType) -> String {
    let script = mobileNameSpace + "setAggregationType(\"\(aggregationType.stringValue)\");"
    return script
  }

  /// Returns a script that sets a periodicity.
  ///
  /// - Parameters:
  ///   - period: The Int Value.
  ///   - interval: The String Object.
  ///   - timeUnit: The ChartIQTimeUnit Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForSetPeriodicity(_ period: Int, interval: String, timeUnit: ChartIQTimeUnit) -> String {
    let safeInterval = safeScriptParameter(interval)
    var intervalValue = safeInterval
    if Int(safeInterval) == nil {
      intervalValue = "\"" + safeInterval + "\""
    }
    let script = mobileNameSpace + "setPeriodicity(\(period), \(intervalValue), \"\(timeUnit.stringValue)\");"
    return script
  }

  /// Returns a script that gets an accessibility mode.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForAccessibilityMode() -> String {
    let script = mobileNameSpace + "accessibilityMode();"
    return script
  }

  /// Returns a script that loads a chart.
  ///
  /// - Parameters:
  ///   - symbol: The String Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForLoadChart(_ symbol: String) -> String {
    let safeSymbol = safeScriptParameter(symbol)
    let script = mobileNameSpace + "loadChart(\"\(safeSymbol)\");"
    return script
  }

  /// Returns a script that adds series.
  ///
  /// - Parameters:
  ///   - symbol: The String Object.
  ///   - color: The UIColor Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForAddSeries(_ symbol: String, color: UIColor) -> String {
    let safeSymbol = safeScriptParameter(symbol)
    let script = "stxx.addSeries(\"\(safeSymbol)\", {display:\"\(symbol)\", " +
    "color: \"\(color.toHexString())\"  isComparison:true});"
    return script
  }

  /// Returns a script that removes series.
  ///
  /// - Parameters:
  ///   - symbol: The String Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForRemoveSeries(_ symbol: String) -> String {
    let safeSymbol = safeScriptParameter(symbol)
    let script = "stxx.removeSeries(\"\(safeSymbol)\");"
    return script
  }

  /// Returns a script that gets a chart scale.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForChartScale() -> String {
    let script = "stxx.layout.chartScale;"
    return script
  }

  /// Returns a script that sets a chart scale.
  ///
  /// - Parameters:
  ///   - scale: The ChartIQScale Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForSetChartScale(_ scale: ChartIQScale) -> String {
    let script = "stxx.layout.chartScale = \"\(scale.stringValue)\";"
    return script
  }

  /// Returns a script that sets a chart style.
  ///
  /// - Parameters:
  ///   - object: The String Object.
  ///   - attribute: The String Object.
  ///   - value: The String Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForSetChartStyle(_ object: String, attribute: String, value: String) -> String {
    let safeObject = safeScriptParameter(object)
    let safeAttribute = safeScriptParameter(attribute)
    let safeValue = safeScriptParameter(value)
    let script = "stxx.setStyle(\"\(safeObject)\",\"\(safeAttribute)\",\"\(safeValue)\");"
    return script
  }

  /// Returns a script that sets a chart property.
  ///
  /// - Parameters:
  ///   - property: The String Object.
  ///   - value: The Any Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForSetChartProperty(_ property: String, value: Any) -> String {
    let safeProperty = safeScriptParameter(property)
    var script = ""
    if value is String {
      let safeValue = safeScriptParameter("\(value)")
      script = "stxx.chart.\(safeProperty) = \"\(safeValue)\";"
    } else {
      script = "stxx.chart\(safeProperty) = \(value);"
    }
    return script
  }

  /// Returns a script that gets a chart property.
  ///
  /// - Parameters:
  ///   - property: The String Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForChartProperty(_ property: String) -> String {
    let safeProperty = safeScriptParameter(property)
    let script = mobileNameSpace + "getChartProperty(\"\(safeProperty)\");"
    return script
  }

  /// Returns a script that sets an engine property.
  ///
  /// - Parameters:
  ///   - property: The String Object.
  ///   - value: The Any Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForSetEngineProperty(_ property: String, value: Any) -> String {
    let safeProperty = safeScriptParameter(property)
    var script = ""
    if value is String {
      let safeValue = safeScriptParameter("\(value)")
      script = "stxx.\(safeProperty) = \"\(safeValue)\";"
    } else {
      script = "stxx.\(safeProperty) = \(value);"
    }
    return script
  }

  /// Returns a script that gets an engine property.
  ///
  /// - Parameters:
  ///   - property: The String Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForEngineProperty(_ property: String) -> String {
    let safeProperty = safeScriptParameter(property)
    let script = mobileNameSpace + "getEngineProperty(\"\(safeProperty)\");"
    return script
  }

  /// Returns a script that enables crosshairs.
  ///
  /// - Parameters:
  ///   - enable: The Bool Value.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForEnableCrosshairs(_ enable: Bool) -> String {
    let script = mobileNameSpace + "enableCrosshairs(\(enable));"
    return script
  }

  /// Returns a script that gets a crosshairs enabled status.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForCrosshairsEnabled() -> String {
    let script = "if (stxx.layout.crosshair == true) { \"true\" } else { \"false\" } "
    return script
  }

  /// Returns a script that gets hud details.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForHudDetails() -> String {
    let script = mobileNameSpace + "getHudDetails();"
    return script
  }

  /// Returns a script that gets a chart available status.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForChartAvailable() -> String {
    let script = "if (" + mobileNameSpace + "isChartAvailable() == true) { \"true\" } else { \"false\" } "
    return script
  }

  /// Returns a script that sets a theme.
  ///
  /// - Parameters:
  ///   - theme: The ChartIQTheme Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForSetTheme(_ theme: ChartIQTheme) -> String {
    let script = mobileNameSpace + "setTheme(\"\(theme.stringValue)\");"
    return script
  }

  /// Returns a script that resizes a chart.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForResizeChart() -> String {
    let script = "stxx.resizeChart();"
    return script
  }

  /// Returns a script that clears a chart.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForClearChart() -> String {
    let script = "stxx.destroy();"
    return script
  }

  /// Returns a script that sets extended hours.
  ///
  /// - Parameters:
  ///   - isExtended: The Bool Value.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForSetExtendHours(_ isExtended: Bool) -> String {
    let script = mobileNameSpace + "toggleExtendedHours(\(isExtended));"
    return script
  }

  /// Returns a script that sets an invert y axis.
  ///
  /// - Parameters:
  ///   - isInverted: The Bool Value.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForSetInvertYAxis(_ isInverted: Bool) -> String {
    let script = "flipChart"
    return script
  }

  /// Returns a script that gets translations.
  ///
  /// - Parameters:
  ///   - languageCode: The String Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForTranslations(_ languageCode: String) -> String {
    let safeProperty = safeScriptParameter(languageCode)
    let script = mobileNameSpace + "getTranslations(\"\(safeProperty)\");"
    return script
  }

  /// Returns a script that sets a language.
  ///
  /// - Parameters:
  ///   - languageCode: The String Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForSetLanguage(_ languageCode: String) -> String {
    let safeProperty = safeScriptParameter(languageCode)
    let script = mobileNameSpace + "setLanguage(\"\(safeProperty)\");"
    return script
  }

  /// Returns a script that pushes a smth.
  ///
  /// - Parameters:
  ///   - jsonString: The String Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForPush(_ jsonString: String) -> String {
    let script = mobileNameSpace + "loadChart(\"\", \(jsonString)); "
    return script
  }

  /// Returns a script that pushes an update.
  ///
  /// - Parameters:
  ///   - jsonString: The String Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForPushUpdate(_ jsonString: String) -> String {
    let script = mobileNameSpace + "parseData('\(jsonString)');"
    return script
  }

  /// Returns a script that gets study parameters.
  ///
  /// - Parameters:
  ///   - studyName: The String Object.
  ///   - type: The ChartIQStudyParametersType Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForStudyParameters(_ studyName: String, type: ChartIQStudyParametersType) -> String {
    let safeStudyName = safeScriptParameter(studyName)
    let script = mobileNameSpace + "getStudyParameters(\"" + safeStudyName + "\" , \"" + type.stringValue + "\");"
    return script
  }

  /// Returns a script that sets a study.
  ///
  /// - Parameters:
  ///   - name: The String Object.
  ///   - key: The String Object.
  ///   - value: The String Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForSetStudy(_ name: String, key: String, value: String) -> String {
    let safeStudyName = safeScriptParameter(name)
    let safeStudyKey = safeScriptParameter(key)
    let safeStudyValue = safeScriptParameter(value)
    let script = mobileNameSpace + "setStudy(\"\(safeStudyName)\", \"\(safeStudyKey)\", \"\(safeStudyValue)\")"
    return script
  }

  /// Returns a script that sets a study.
  ///
  /// - Parameters:
  ///   - name: The String Object.
  ///   - parameters: The Dictionary Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForSetStudy(_ name: String, parameters: [String: String]) -> String {
    let safeStudyName = safeScriptParameter(name)
    var script = getStudyDescriptorScript(safeStudyName) +
      "var helper = new CIQ.Studies.DialogHelper({sd:selectedSd,stx:stxx}); " + "var isFound = false; " +
      "var newInputParameters = {}; " + "var newOutputParameters = {}; " + "var newParameters = {}; "
    parameters.forEach { parameter in
      script += getUpdateStudyParametersScript(parameter.key, value: parameter.value)
    }
    script += "helper.updateStudy({inputs:newInputParameters, outputs:newOutputParameters, parameters:newParameters}); console.log(JSON.stringify(newParameters)) "
    return script
  }

  /// Returns a script that adds a study.
  ///
  /// - Parameters:
  ///   - studyName: The String Object.
  ///   - studyInputs: The String Object.
  ///   - studyOutputs: The String Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForAddStudy(_ studyName: String, studyInputs: String, studyOutputs: String) -> String {
    let safeStudyName = safeScriptParameter(studyName)
    let script = mobileNameSpace + "addStudy('\(safeStudyName)', \(studyInputs), \(studyOutputs));"
    return script
  }

  /// Returns a script that removes a study.
  ///
  /// - Parameters:
  ///   - studyName: The String Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForRemoveStudy(_ studyName: String) -> String {
    let safeStudyName = safeScriptParameter(studyName)
    let script = mobileNameSpace + "removeStudy('\(safeStudyName)');"
    return script
  }

  /// Returns a script that removes all studies.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForRemoveAllStudies() -> String {
    let script = mobileNameSpace + "removeAllStudies();"
    return script
  }

  /// Returns a script that gets active studies.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForActiveStudies() -> String {
    let script = mobileNameSpace + "getActiveStudies();"
    return script
  }

  /// Returns a script that gets a current drawing tool.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForCurrentDrawTool() -> String {
    let script = "currentDrawing"
    return script
  }

  /// Returns a script that enables a drawing.
  ///
  /// - Parameters:
  ///   - tool: The ChartIQDrawingTool Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForEnableDrawing(_ tool: ChartIQDrawingTool) -> String {
    let script = "currentDrawing = \"\(tool.stringValue)\"; " + "stxx.changeVectorType(currentDrawing); "
    return script
  }

  /// Returns a script that restores a default drawing config.
  ///
  /// - Parameters:
  ///   - tool: The ChartIQDrawingTool Object that can be nil.
  ///   - all: The Bool Value.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForRestoreDefaultDrawingConfig(_ tool: ChartIQDrawingTool, all: Bool) -> String {
    var toolName = ""
    if all != true {
      toolName = tool.stringValue
    }
    let script = mobileNameSpace + "restoreDefaultDrawingConfig(\"\(toolName)\", \(all));"
    return script
  }

  /// Returns a script that gets drawing parameters.
  ///
  /// - Parameters:
  ///   - tool: The ChartIQDrawingTool Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForDrawingParameters(_ tool: ChartIQDrawingTool) -> String {
    let safeParameterName = safeScriptParameter(tool.stringValue)
    let script = mobileNameSpace + "getDrawingParameters(\"\(safeParameterName)\");"
    return script
  }

  /// Returns a script that sets a drawing parameter.
  ///
  /// - Parameters:
  ///   - parameterName: The String Object.
  ///   - value: The Any Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForSetDrawingParameter(_ parameterName: String, value: Any) -> String {
    let safeParameterName = safeScriptParameter(parameterName)
    let valueString = "\(value is String ? "\"\(value)\"" : value)"
    let script = mobileNameSpace + "setDrawingParameters(\"\(safeParameterName)\", \(valueString));"
    return script
  }

  /// Returns a script that deletes a drawing.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForDeleteDrawing() -> String {
    let script = mobileNameSpace + "deleteDrawing();"
    return script
  }

  /// Returns a script that clones a drawing.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForCloneDrawing() -> String {
    let script = mobileNameSpace + "cloneDrawing();"
    return script
  }

  /// Returns a script that manages a layer drawing.
  ///
  /// - Parameters:
  ///   - layer: The ChartIQLayer Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForManageLayerDrawing(_ layer: ChartIQLayer) -> String {
    let script = mobileNameSpace + "layerDrawing(\"\(layer.stringValue)\");"
    return script
  }

  /// Returns a script that undoes an action.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForUndo() -> String {
    let script = mobileNameSpace + "undo();"
    return script
  }

  /// Returns a script that redoes an action.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForRedo() -> String {
    let script = mobileNameSpace + "redo();"
    return script
  }

  /// Returns a script that disables a drawing.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForDisableDrawing() -> String {
    let script = "stxx.changeVectorType(null); " + "currentDrawing = \"\" ; "
    return script
  }

  /// Returns a script that clears a drawing.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForClearDrawing() -> String {
    let script = "stxx.clearDrawings();"
    return script
  }

  /// Returns a script that has been invoked.
  ///
  /// - Parameters:
  ///   - functionName: The String Object.
  ///   - jsonString: The String Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForInvoke(_ functionName: String, jsonString: String) -> String {
    let safeFunctionName = safeScriptParameter("\(functionName)")
    let script = "stxx.\(safeFunctionName)(\(jsonString.dropFirst().dropLast()));"
    return script
  }

  /// Returns a script that gets study objects.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForStudyObjects() -> String {
    let script = "JSON.stringify(CIQ.Studies.studyLibrary);"
    return script
  }

  /// Returns a script that loads a default setting.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForLoadDefaultSetting() -> String {
    let script = "stxx.layout.chartScale = \"log\";"
    return script
  }

  /// Returns a script that formats JSQuote data.
  ///
  /// - Parameters:
  ///   - json: The String Object.
  ///   - cb: The String Object.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForFormatJSQuoteData(_ json: String, moreAvailable: Bool, cb: String) -> String {
    let script = mobileNameSpace + "parseData('\(json)', \"\(cb)\", \(moreAvailable));"
    return script
  }

  /// Returns a script that gets a drawing listener.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForAddDrawingListener() -> String {
    let script = mobileNameSpace + "addDrawingListener();"
    return script
  }

  /// Returns a script that gets a measure listener.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForAddMeasureListener() -> String {
    let script = mobileNameSpace + "addMeasureListener();"
    return script
  }

  /// Returns a script that gets a layout listener.
  ///
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getScriptForAddLayoutListener() -> String {
    let script = mobileNameSpace + "addLayoutListener()"
    return script
  }

  /// Uses this method to generate the javascript of getting study descriptor.
  ///
  /// - Parameters:
  ///   - name: The name of study descriptor.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getStudyDescriptorScript(_ name: String) -> String {
    let safeStudyName = safeScriptParameter(name)
    let script = "var s=stxx.layout.studies; " + "var selectedSd = {}; " + "for(var n in s){ " + "   var sd=s[n]; " +
    "if (sd.name === \"\(safeStudyName)\") { selectedSd = sd; }} "
    return script
  }

  /// Uses this method in order to prevent the possibility of Javascript code injections.
  ///
  /// - Parameters:
  ///   - parameter: The javascript string parameter.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func safeScriptParameter(_ parameter: String) -> String {
    let specialCharacters: [ChartIQSpecialCharacter] = [
      .ampersand, .doubleQuote, .singleQuote, .lessThan, .greaterThan
    ]
    var reverseParameter = parameter
    specialCharacters.forEach { reverseParameter = reverseParameter.replace($0.escapingValue, with: $0.originalValue) }
    var safeParameter = reverseParameter
    specialCharacters.forEach { safeParameter = safeParameter.replace($0.originalValue, with: $0.escapingValue) }
    return safeParameter
  }

  /// Uses this method to generate the javascript of updating study parameter.
  ///
  /// - Parameters:
  ///   - parameter: The study parameter name.
  ///   - value: The study parameter value.
  /// - Returns: The String Object that contains a JS script for evaluate in the WebView.
  internal func getUpdateStudyParametersScript(_ parameter: String, value: String) -> String {
    let safeStudyParameter = safeScriptParameter(parameter)
    let safeStudyValue = safeScriptParameter(value)
    let updateParametersScript = "for (x in helper.inputs) {" +
      "   var input = helper.inputs[x]; " +
      "   if (input[\"name\"] === \"\(safeStudyParameter)\") { " +
      "       isFound = true; " +
      "       if (input[\"type\"] === \"text\" || input[\"type\"] === \"select\") { " +
      "           newInputParameters[\"\(safeStudyParameter)\"] = \"\(safeStudyValue)\"; " +
      "       } else if (input[\"type\"] === \"number\") { " +
      "           newInputParameters[\"\(safeStudyParameter)\"] = parseFloat(\"\(safeStudyValue)\"); " +
      "       } else if (input[\"type\"] === \"checkbox\") { " +
      "           newInputParameters[\"\(safeStudyParameter)\"] =" +
      " \(safeStudyValue == "false" || safeStudyValue == "0" ? false : true); " +
      "       } " +
      "   } " +
      "} " +
      "if (isFound == false) { " +
      "   for (x in helper.outputs) { " +
      "       var output = helper.outputs[x]; " +
      "       if (output[\"name\"] === \"\(safeStudyParameter)\") { " +
      "           newOutputParameters[\"\(safeStudyParameter)\"] = \"\(safeStudyValue)\"; " +
      "       } " +
      "   } " +
      "} " +
      "if (isFound == false) { " +
      "   if(\"\(safeStudyParameter)\".includes(\"Color\")) { " +
      "       newParameters[\"\(safeStudyParameter)\"] = \"\(safeStudyValue)\"; " +
      "   } else if(\"\(safeStudyParameter)\".includes(\"Enabled\")) { " +
      "       newParameters[\"\(safeStudyParameter)\"] =" +
      " \(safeStudyValue == "false" || safeStudyValue == "0" ? false : true); " +
      "   } else { " +
      "       newParameters[\"\(safeStudyParameter)\"] = parseFloat(\"\(safeStudyValue)\"); " +
      "   } " +
      "} " + "isFound = false; "
    return updateParametersScript
  }
}
