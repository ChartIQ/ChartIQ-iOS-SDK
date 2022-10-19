//
//  ChartIQSignalEnums.swift
//  ChartIQ
//
//  Copyright 2012-2022 by ChartIQ, Inc.
//  All rights reserved
//

// MARK: - ChartIQSignalOperator Enum

/// Chart signal operator.
@objc public enum ChartIQSignalOperator: Int, CaseIterable {

  /// The isGreaterThan option.
  case isGreaterThan

  /// The isLessThan option.
  case isLessThan

  /// The isEqualTo option.
  case isEqualTo

  /// The crosses option.
  case crosses

  /// The crossesAbove option.
  case crossesAbove

  /// The crossesBelow option.
  case crossesBelow

  /// The turnsUp option.
  case turnsUp

  /// The turnsDown option.
  case turnsDown

  /// The increases option.
  case increases

  /// The decreases option.
  case decreases

  /// The doesNotChange option.
  case doesNotChange

  /// Chart signal operator string value.
  public var stringValue: String {
    switch self {
    case .isGreaterThan:
      return ">"
    case .isLessThan:
      return "<"
    case .isEqualTo:
      return "="
    case .crosses:
      return "x"
    case .crossesAbove:
      return "x+"
    case .crossesBelow:
      return "x-"
    case .turnsUp:
      return "t+"
    case .turnsDown:
      return "t-"
    case .increases:
      return ">p"
    case .decreases:
      return "<p"
    case .doesNotChange:
      return "=p"
    }
  }

  /// Chart signal operator display name.
  public var displayName: String {
    switch self {
    case .isGreaterThan:
      return "Is Greater Than"
    case .isLessThan:
      return "Is Less Than"
    case .isEqualTo:
      return "Is Equal To"
    case .crosses:
      return "Crosses"
    case .crossesAbove:
      return "Crosses Above"
    case .crossesBelow:
      return "Crosses Below"
    case .turnsUp:
      return "Turns Up"
    case .turnsDown:
      return "Turns Down"
    case .increases:
      return "Increases"
    case .decreases:
      return "Decreases"
    case .doesNotChange:
      return "Does Not Change"
    }
  }

  /// Init signal operator with string value.
  ///
  /// - Parameters:
  ///   - stringValue: The String Object.
  public init?(stringValue: String) {
    let dictionary: [String: ChartIQSignalOperator] = [
      ">": .isGreaterThan,
      "<": .isLessThan,
      "=": .isEqualTo,
      "x": .crosses,
      "x+": .crossesAbove,
      "x-": .crossesBelow,
      "t+": .turnsUp,
      "t-": .turnsDown,
      ">p": .increases,
      "<p": .decreases,
      "=p": .doesNotChange
    ]
    if let value = dictionary[stringValue] {
      self = value
    } else {
      return nil
    }
  }
}

// MARK: - ChartIQSignalShape Enum

/// Chart signal shape.
@objc public enum ChartIQSignalShape: Int, CaseIterable {

  /// The circle option.
  case circle

  /// The square option.
  case square

  /// The diamond option.
  case diamond

  /// Chart signal shape string value.
  public var stringValue: String {
    switch self {
    case .circle:
      return "circle"
    case .square:
      return "square"
    case .diamond:
      return "diamond"
    }
  }

  /// Chart signal shape display name.
  public var displayName: String {
    switch self {
    case .circle:
      return "Circle"
    case .square:
      return "Square"
    case .diamond:
      return "Diamond"
    }
  }

  /// Init signal shape with string value.
  ///
  /// - Parameters:
  ///   - stringValue: The String Object.
  public init?(stringValue: String) {
    let dictionary: [String: ChartIQSignalShape] = [
      "circle": .circle,
      "square": .square,
      "diamond": .diamond
    ]
    if let value = dictionary[stringValue] {
      self = value
    } else {
      return nil
    }
  }
}

// MARK: - ChartIQSignalSize Enum

/// Chart signal size.
@objc public enum ChartIQSignalSize: Int, CaseIterable {

  /// The small option.
  case small

  /// The medium option.
  case medium

  /// The large option.
  case large

  /// Chart signal size string value.
  public var stringValue: String {
    switch self {
    case .small:
      return "S"
    case .medium:
      return "M"
    case .large:
      return "L"
    }
  }

  /// Chart signal size display name.
  public var displayName: String {
    switch self {
    case .small:
      return "Small"
    case .medium:
      return "Medium"
    case .large:
      return "Large"
    }
  }

  /// Init signal size with string value.
  ///
  /// - Parameters:
  ///   - stringValue: The String Object.
  public init?(stringValue: String) {
    let dictionary: [String: ChartIQSignalSize] = [
      "S": .small,
      "M": .medium,
      "L": .large
    ]
    if let value = dictionary[stringValue] {
      self = value
    } else {
      return nil
    }
  }
}

// MARK: - ChartIQSignalPosition Enum

/// Chart signal position.
@objc public enum ChartIQSignalPosition: Int, CaseIterable {

  /// The aboveCandle option.
  case aboveCandle

  /// The belowCandle option.
  case belowCandle

  /// The onCandle option.
  case onCandle

  /// Chart signal position string value.
  public var stringValue: String {
    switch self {
    case .aboveCandle:
      return "above_candle"
    case .belowCandle:
      return "below_candle"
    case .onCandle:
      return "on_candle"
    }
  }

  /// Chart signal position display name.
  public var displayName: String {
    switch self {
    case .aboveCandle:
      return "Above Line"
    case .belowCandle:
      return "Below Line"
    case .onCandle:
      return "On Line"
    }
  }

  /// Init signal position with string value.
  ///
  /// - Parameters:
  ///   - stringValue: The String Object.
  public init?(stringValue: String) {
    let dictionary: [String: ChartIQSignalPosition] = [
      "above_candle": .aboveCandle,
      "below_candle": .belowCandle,
      "on_candle": .onCandle
    ]
    if let value = dictionary[stringValue] {
      self = value
    } else {
      return nil
    }
  }
}

// MARK: - ChartIQSignalMarkerType Enum

/// Chart signal marker type.
@objc public enum ChartIQSignalMarkerType: Int, CaseIterable {

  /// The marker option.
  case marker

  /// The paintbar option.
  case paintbar

  /// Chart signal marker type string value.
  public var stringValue: String {
    switch self {
    case .marker:
      return "marker"
    case .paintbar:
      return "paintbar"
    }
  }

  /// Chart signal marker type display name.
  public var displayName: String {
    switch self {
    case .marker:
      return "Chart Marker"
    case .paintbar:
      return "Paintbar"
    }
  }

  /// Init signal marker type with string value.
  ///
  /// - Parameters:
  ///   - stringValue: The String Object.
  public init?(stringValue: String) {
    let dictionary: [String: ChartIQSignalMarkerType] = [
      "marker": .marker,
      "paintbar": .paintbar
    ]
    if let value = dictionary[stringValue] {
      self = value
    } else {
      return nil
    }
  }
}

// MARK: - ChartIQSignalJoiner Enum

/// Chart signal joiner.
@objc public enum ChartIQSignalJoiner: Int, CaseIterable {

  /// The or option.
  case or

  /// The and option.
  case and

  /// Chart signal joiner string value.
  public var stringValue: String {
    switch self {
    case .or:
      return "|"
    case .and:
      return "&"
    }
  }

  /// Chart signal joiner display name.
  public var displayName: String {
    switch self {
    case .or:
      return "Or"
    case .and:
      return "And"
    }
  }

  /// Init signal joiner with string value.
  ///
  /// - Parameters:
  ///   - stringValue: The String Object.
  public init?(stringValue: String) {
    let dictionary: [String: ChartIQSignalJoiner] = [
      "|": .or,
      "&": .and
    ]
    if let value = dictionary[stringValue] {
      self = value
    } else {
      return nil
    }
  }
}
