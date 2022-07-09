//
//  ChartIQConst.swift
//  ChartIQ
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import Foundation

// MARK: - Public Constants

/// Provides constants grouped by data structures used in the SDK and Demo App.
public struct ChartIQConst {

  // MARK: - DrawingTool

  /// Provides constants for ChartIQDrawingTool.
  public struct DrawingTool {
    public static let fillColorKey = "fillColor"
    public static let lineColorKey = "color"
    public static let patternKey = "pattern"
    public static let lineWidthKey = "lineWidth"

    public static let fontKey = "font"
    public static let familyKey = "family"
    public static let sizeKey = "size"
    public static let styleKey = "style"
    public static let weightKey = "weight"

    public static let normalKey = "normal"
    public static let italicKey = "italic"
    public static let boldKey = "bold"
    public static let boldOffKey = "300"

    public static let axisLabelKey = "axisLabel"
    public static let parametersKey = "parameters"
    public static let fibsKey = "fibs"
    public static let showLinesKey = "showLines"

    public static let waveParametersKey = "waveParameters"
    public static let waveTemplateKey = "waveTemplate"
    public static let impulseKey = "impulse"
    public static let correctiveKey = "corrective"
    public static let decorationKey = "decoration"

    public static let levelKey = "level"
    public static let displayKey = "display"

    public static let active1Key = "active1"
    public static let active2Key = "active2"
    public static let active3Key = "active3"

    public static let color1Key = "color1"
    public static let color2Key = "color2"
    public static let color3Key = "color3"

    public static let lineWidth1Key = "lineWidth1"
    public static let lineWidth2Key = "lineWidth2"
    public static let lineWidth3Key = "lineWidth3"

    public static let pattern1Key = "pattern1"
    public static let pattern2Key = "pattern2"
    public static let pattern3Key = "pattern3"
  }

  // MARK: - Study

  /// Provides constants for ChartIQStudy.
  public struct Study {
    public static let typeKey = "type"
    public static let colorKey = "color"
    public static let textKey = "text"
    public static let colorTextKey = "colorText"
    public static let nameKey = "name"
    public static let valueKey = "value"
    public static let checkboxKey = "checkbox"
    public static let optionsKey = "options"
    public static let autoColorKey = "auto"

    public static let defaultValueKey = "defaultValue"
    public static let defaultOutputKey = "defaultOutput"
    public static let defaultInputKey = "defaultInput"
    public static let defaultColorKey = "defaultColor"

    public static let enabledAdditionalKey = "Enabled"
    public static let valueAdditionalKey = "Value"
    public static let colorAdditionalKey = "Color"
  }
}

// MARK: - Internal Constants

/// Provides constants grouped by data structures used in the SDK.
internal struct Const {

  // MARK: - General

  /// Provides general constants.
  internal struct General {
    static let zwnjSymbol = "\u{200c}"
    static let doubleVerticalLinesSymbol = "||"
    static let newlineSymbol = "\n"
    static let quoteSymbol = "\""
    static let commaSpaceSymbol = ", "
    static let trueStringValue = "true"
  }

  // MARK: - Core

  /// Provides constants for Core.
  internal struct Core {
    static let baseChartType = ChartIQChartType.bar
    static let baseChartScale = ChartIQScale.linear
  }

  // MARK: - ChartIQCrosshairHUD

  /// Provides constants for ChartIQCrosshairHUD model.
  internal struct CrosshairHUD {
    static let priceParam = "price"
    static let openParam = "open"
    static let highParam = "high"
    static let lowParam = "low"
    static let closeParam = "close"
    static let volumeParam = "volume"

    static let volumePostfixTitle = "M"
  }

  // MARK: - ChartIQQuoteFeedParams

  /// Provides constants for ChartIQQuoteFeedParams model.
  internal struct QuoteFeed {
    static let symbolParam = "symbol"
    static let startDateParam = "startDate"
    static let endDateParam = "endDate"
    static let intervalParam = "interval"
    static let periodParam = "period"
  }

  // MARK: - ChartIQData

  /// Provides constants for ChartIQData model.
  internal struct Data {
    static let dateParam = "DT"
    static let openParam = "Open"
    static let highParam = "High"
    static let lowParam = "Low"
    static let closeParam = "Close"
    static let volumeParam = "Volume"
    static let adjCloseParam = "Adj_Close"
  }

  // MARK: - ChartIQStudy

  /// Provides constants for ChartIQStudy model.
  internal struct Study {
    static let idParam = "id"
    static let displayParam = "display"
    static let nameParam = "name"
    static let studyNameParam = "studyName"
    static let typeParam = "type"
    static let uniqueIdParam = "uniqueId"
    static let inputsParam = "inputs"
    static let outputsParam = "outputs"
    static let parametersParam = "parameters"
    static let nullParam = "null"
  }

  // MARK: - ChartIQSeries

  /// Provides constants for ChartIQSeries model.
  internal struct Series {
    static let colorParam = "color"
  }

  // MARK: - ChartIQMarkerOptions

  /// Provides constants for ChartIQMarkerOptions model.
  internal struct MarkerOptions {
    static let typeParam = "type"
    static let colorParam = "color"
    static let shapeParam = "shape"
    static let labelParam = "label"
    static let sizeParam = "size"
    static let positionParam = "position"
  }

  // MARK: - ChartIQSignal

  /// Provides constants for ChartIQSignal model.
  internal struct Signal {
    static let conditionsParam = "conditions"
    static let joinerParam = "joiner"
    static let nameParam = "name"
    static let signalNameParam = "signalName"
    static let disabledParam = "disabled"
    static let descriptionParam = "description"
  }

  // MARK: - CallbackMessage

  /// Provides constants for ChartIQCallbackMessage.
  internal struct CallbackMessage {
    static let callbackKeyParam = "cb"
  }

  // MARK: - LogMessage

  /// Provides constants for ChartIQLogMessage.
  internal struct LogMessage {
    static let argumentsParam = "arguments"
    static let methodParam = "method"
    static let logParam = "LOG"
  }
}
