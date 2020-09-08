//
//  ChartIQEnums.swift
//  ChartIQ
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import Foundation

// MARK: - ChartIQEnums Enums
// MARK: - Public Enums
// MARK: - ChartIQDataMethod

/// Chart data method.
@objc public enum ChartIQDataMethod: Int {

  /// The push option.
  case push

  /// The pull option.
  case pull
}

// MARK: - ChartIQScale

/// Chart scale.
@objc public enum ChartIQScale: Int {

  /// The log option.
  case log

  /// The linear option.
  case linear

  /// Chart scale string value.
  public var stringValue: String {
    switch self {
    case .log:
      return "log"
    case .linear:
      return "linear"
    }
  }

  /// Init chart scale with string value.
  ///
  /// - Parameters:
  ///   - stringValue: The String Object.
  public init?(stringValue: String) {
    let dictionary: [String: ChartIQScale] = [
      "log": .log,
      "linear": .linear
    ]
    if let value = dictionary[stringValue] {
      self = value
    } else {
      return nil
    }
  }
}

// MARK: - ChartIQStudyError

/// Chart study error.
public enum ChartIQStudyError: Error {

  /// The invalidInput option.
  case invalidInput

  /// The invalidOutput option.
  case invalidOutput

  /// The studyNotFound option.
  case studyNotFound
}

// MARK: - ChartIQDrawingToolType

/// Chart drawing tool type.
@objc public enum ChartIQDrawingToolType: Int {

  /// The text option.
  case text

  /// The statistics option.
  case statistics

  /// The technicals option.
  case technicals

  /// The fibonacci option.
  case fibonacci

  /// The markings option.
  case markings

  /// The lines option.
  case lines

  /// Chart drawing tool type display name.
  public var displayName: String {
    switch self {
    case .text:
      return "Text"
    case .statistics:
      return "Statistics"
    case .technicals:
      return "Technicals"
    case .fibonacci:
      return "Fibonacci"
    case .markings:
      return "Markings"
    case .lines:
      return "Lines"
    }
  }
}

// MARK: - ChartIQFontFamily

/// Chart font family type.
@objc public enum ChartIQFontFamily: Int, CaseIterable {

  /// The default option.
  case `default`

  /// The helvetica option.
  case helvetica

  /// The courier option.
  case courier

  /// The garamond option.
  case garamond

  /// The palatino option.
  case palatino

  /// The timesNewRoman option.
  case timesNewRoman

  /// Chart font family type display name.
  public var displayName: String {
    switch self {
    case .default:
      return "Default"
    case .helvetica:
      return "Helvetica"
    case .courier:
      return "Courier"
    case .garamond:
      return "Garamond"
    case .palatino:
      return "Palatino"
    case .timesNewRoman:
      return "Times New Roman"
    }
  }
}

// MARK: - ChartIQFontSize

/// Chart font size type.
@objc public enum ChartIQFontSize: Int, CaseIterable {

  /// The font of size 8 option.
  case fontOfSize8

  /// The font of size 10 option.
  case fontOfSize10

  /// The font of size 12 option.
  case fontOfSize12

  /// The font of size 13 option.
  case fontOfSize13

  /// The font of size 14 option.
  case fontOfSize14

  /// The font of size 16 option.
  case fontOfSize16

  /// The font of size 20 option.
  case fontOfSize20

  /// The font of size 28 option.
  case fontOfSize28

  /// The font of size 36 option.
  case fontOfSize36

  /// The font of size 48 option.
  case fontOfSize48

  /// The font of size 64 option.
  case fontOfSize64

  /// Chart font size type display name.
  public var displayName: String {
    switch self {
    case .fontOfSize8:
      return "8px"
    case .fontOfSize10:
      return "10px"
    case .fontOfSize12:
      return "12px"
    case .fontOfSize13:
      return "13px"
    case .fontOfSize14:
      return "14px"
    case .fontOfSize16:
      return "16px"
    case .fontOfSize20:
      return "20px"
    case .fontOfSize28:
      return "28px"
    case .fontOfSize36:
      return "36px"
    case .fontOfSize48:
      return "48px"
    case .fontOfSize64:
      return "64px"
    }
  }
}

// MARK: - ChartIQFontStyle

/// Chart font style type.
@objc public enum ChartIQFontStyle: Int {

  /// The none option.
  case none

  /// The bold option.
  case bold

  /// The italic option.
  case italic

  /// Chart font style type display name.
  public var displayName: String {
    switch self {
    case .none:
      return "None"
    case .bold:
      return "Bold"
    case .italic:
      return "Italic"
    }
  }
}

// MARK: - ChartIQLineType

/// Chart line type.
@objc public enum ChartIQLineType: Int {

  /// The solid option.
  case solid

  /// The dotted option.
  case dotted

  /// The dashed option.
  case dashed

  /// Chart line type string value.
  public var stringValue: String {
    switch self {
    case .solid:
      return "solid"
    case .dotted:
      return "dotted"
    case .dashed:
      return "dashed"
    }
  }

  /// Init chart line type with string value.
  ///
  /// - Parameters:
  ///   - stringValue: The String Object.
  public init?(stringValue: String) {
    let dictionary: [String: ChartIQLineType] = [
      "solid": .solid,
      "dotted": .dotted,
      "dashed": .dashed
    ]
    if let value = dictionary[stringValue] {
      self = value
    } else {
      return nil
    }
  }
}

// MARK: - ChartIQTheme

/// Chart theme.
@objc public enum ChartIQTheme: Int {

  /// The day option.
  case day

  /// The night option.
  case night

  /// The none option.
  case none

  /// Chart theme string value.
  public var stringValue: String {
    switch self {
    case .day:
      return "day"
    case .night:
      return "night"
    case .none:
      return "none"
    }
  }
}

// MARK: - ChartIQLayer

/// Chart layer.
@objc public enum ChartIQLayer: Int {

  /// The top option.
  case top

  /// The up option.
  case up

  /// The back option.
  case back

  /// The bottom option.
  case bottom

  /// Chart layer string value.
  public var stringValue: String {
    switch self {
    case .top:
      return "top"
    case .up:
      return "up"
    case .back:
      return "back"
    case .bottom:
      return "bottom"
    }
  }
}

// MARK: - ChartIQQuoteFields

/// Chart quote field.
@objc public enum ChartIQQuoteField: Int {

  /// The date option.
  case date

  /// The close option.
  case close

  /// The open option.
  case open

  /// The high option.
  case high

  /// The low option.
  case low

  /// The volume option.
  case volume

  /// Chart quote field string value.
  public var stringValue: String {
    switch self {
    case .date:
      return "Date"
    case .close:
      return "Close"
    case .open:
      return "Open"
    case .high:
      return "High"
    case .low:
      return "Low"
    case .volume:
      return "Volume"
    }
  }
}

// MARK: - ChartIQStudyParametersType

/// Chart study parameters type.
@objc public enum ChartIQStudyParametersType: Int {

  /// The inputs option.
  case inputs

  /// The outputs option.
  case outputs

  /// The parameters option.
  case parameters

  /// Chart study parameters string value.
  public var stringValue: String {
    switch self {
    case .inputs:
      return "inputs"
    case .outputs:
      return "outputs"
    case .parameters:
      return "parameters"
    }
  }
}

// MARK: - ChartIQTimeUnit

/// Chart time unit.
@objc public enum ChartIQTimeUnit: Int {

  /// The millisecond option.
  case millisecond

  /// The second option.
  case second

  /// The minute option.
  case minute

  /// The day option.
  case day

  /// The week option.
  case week

  /// The month option.
  case month

  /// Chart time unit string value.
  public var stringValue: String {
    switch self {
    case .millisecond:
      return "millisecond"
    case .second:
      return "second"
    case .minute:
      return "minute"
    case .day:
      return "day"
    case .week:
      return "week"
    case .month:
      return "month"
    }
  }

  /// Init time unit with string value.
  ///
  /// - Parameters:
  ///   - stringValue: The String Object.
  public init?(stringValue: String) {
    let dictionary: [String: ChartIQTimeUnit] = [
      "millisecond": .millisecond,
      "second": .second,
      "minute": .minute,
      "day": .day,
      "week": .week,
      "month": .month
    ]
    if let value = dictionary[stringValue] {
      self = value
    } else {
      return nil
    }
  }
}

// MARK: - Internal Enums
// MARK: - ChartIQCallbackMessage

/// Chart callback message.
internal enum ChartIQCallbackMessage: Int {

  /// The newSymbol option.
  case newSymbol

  /// The pullInitialData option.
  case pullInitialData

  /// The pullUpdateData option.
  case pullUpdateData

  /// The pullPaginationData option.
  case pullPaginationData

  /// The layout option.
  case layout

  /// The drawing option.
  case drawing

  /// The measure option.
  case measure

  /// The accessibility option.
  case accessibility

  /// The log option.
  case log

  /// All chart callback message handler values.
  internal static func allMessageHandlers() -> [ChartIQCallbackMessage] {
    let messageHandlers: [ChartIQCallbackMessage] = [
      .accessibility,
      .newSymbol,
      .pullInitialData,
      .pullUpdateData,
      .pullPaginationData,
      .layout,
      .drawing,
      .measure,
      .log
    ]
    return messageHandlers
  }

  /// Chart callback message string value.
  internal var stringValue: String {
    switch self {
    case .newSymbol:
      return "newSymbolCallbackHandler"
    case .pullInitialData:
      return "pullInitialDataHandler"
    case .pullUpdateData:
      return "pullUpdateDataHandler"
    case .pullPaginationData:
      return "pullPaginationDataHandler"
    case .layout:
      return "layoutHandler"
    case .drawing:
      return "drawingHandler"
    case .measure:
      return "measureHandler"
    case .accessibility:
      return "accessibilityHandler"
    case .log:
      return "logHandler"
    }
  }

  /// Init chart callback message with string value.
  ///
  /// - Parameters:
  ///   - stringValue: The String Object.
  internal init?(stringValue: String) {
    let dictionary: [String: ChartIQCallbackMessage] = [
      "newSymbolCallbackHandler": .newSymbol,
      "pullInitialDataHandler": .pullInitialData,
      "pullUpdateDataHandler": .pullUpdateData,
      "pullPaginationDataHandler": .pullPaginationData,
      "layoutHandler": .layout,
      "drawingHandler": .drawing,
      "measureHandler": .measure,
      "accessibilityHandler": .accessibility,
      "logHandler": .log
    ]
    if let value = dictionary[stringValue] {
      self = value
    } else {
      return nil
    }
  }
}

// MARK: - SpecialCharacters

/// Special character for safe script method.
@objc internal enum SpecialCharacter: Int {

  /// The ampersand (&) option.
  case ampersand

  /// The doubleQuote (") option.
  case doubleQuote

  /// The singleQuote (') option.
  case singleQuote

  /// The lessThan () option.
  case lessThan

  /// The greaterThan (>) option.
  case greaterThan

  /// Special character string value.
  internal var stringValue: String {
    switch self {
    case .ampersand:
      return "ampersand"
    case .doubleQuote:
      return "doubleQuote"
    case .singleQuote:
      return "singleQuote"
    case .lessThan:
      return "lessThan"
    case .greaterThan:
      return "greaterThan"
    }
  }

  /// Special character original value.
  internal var originalValue: String {
    switch self {
    case .ampersand:
      return "&"
    case .doubleQuote:
      return "\""
    case .singleQuote:
      return "'"
    case .lessThan:
      return "<"
    case .greaterThan:
      return ">"
    }
  }

  /// Special character escaping value.
  internal var escapingValue: String {
    switch self {
    case .ampersand:
      return "&amp;"
    case .doubleQuote:
      return "&quot;"
    case .singleQuote:
      return "&apos;"
    case .lessThan:
      return "&lt;"
    case .greaterThan:
      return "&gt;"
    }
  }
}
