//
//  ChartIQElliottWaveEnums.swift
//  ChartIQ
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import Foundation

// MARK: - ChartIQElliottWaveTemplate Enum

/// Chart Elliott Wave Template.
@objc public enum ChartIQElliottWaveTemplate: Int, CaseIterable {

  /// The grandSupercycle option.
  case grandSupercycle

  /// The supercycle option.
  case supercycle

  /// The cycle option.
  case cycle

  /// The primary option.
  case primary

  /// The intermediate option.
  case intermediate

  /// The minor option.
  case minor

  /// The minute option.
  case minute

  /// The minuette option.
  case minuette

  /// The subMinuette option.
  case subMinuette

  /// The custom option.
  case custom

  /// Chart Elliott Wave Template display name.
  public var displayName: String {
    switch self {
    case .grandSupercycle:
      return "Grand Supercycle"
    case .supercycle:
      return "Supercycle"
    case .cycle:
      return "Cycle"
    case .primary:
      return "Primary"
    case .intermediate:
      return "Intermediate"
    case .minor:
      return "Minor"
    case .minute:
      return "Minute"
    case .minuette:
      return "Minuette"
    case .subMinuette:
      return "Sub-Minuette"
    case .custom:
      return "Custom"
    }
  }
}

// MARK: - ChartIQElliottWaveImpulse Enum

/// Chart Elliott Wave Impulse.
@objc public enum ChartIQElliottWaveImpulse: Int, CaseIterable {

  /// The none option.
  case none

  /// The romanCapital option.
  case romanCapital

  /// The romanNormal option.
  case romanNormal

  /// The arabicNormal option.
  case arabicNormal

  /// The abcdeCapital option.
  case abcdeCapital

  /// The abcdeNormal option.
  case abcdeNormal

  /// The wxyxzCapital option.
  case wxyxzCapital

  /// The wxyxzNormal option.
  case wxyxzNormal

  /// Chart Elliott Wave Impulse display name.
  public var displayName: String {
    switch self {
    case .none:
      return "- - -"
    case .romanCapital:
      return "I II III IV V"
    case .romanNormal:
      return "i ii iii iv v"
    case .arabicNormal:
      return "1 2 3 4 5"
    case .abcdeCapital:
      return "A B C D E"
    case .abcdeNormal:
      return "a b c d e"
    case .wxyxzCapital:
      return "W X Y X Z"
    case .wxyxzNormal:
      return "w x y x z"
    }
  }
}

// MARK: - ChartIQElliottWaveCorrective Enum

/// Chart Elliott Wave Corrective.
@objc public enum ChartIQElliottWaveCorrective: Int, CaseIterable {

  /// The none option.
  case none

  /// The abcCapital option.
  case abcCapital

  /// The abcNormal option.
  case abcNormal

  /// The wxyCapital option.
  case wxyCapital

  /// The wxyNormal option.
  case wxyNormal

  /// Chart Elliott Wave Corrective display name.
  public var displayName: String {
    switch self {
    case .none:
      return "- - -"
    case .abcCapital:
      return "A B C"
    case .abcNormal:
      return "a b c"
    case .wxyCapital:
      return "W X Y"
    case .wxyNormal:
      return "w x y"
    }
  }
}

// MARK: - ChartIQElliottWaveDecoration Enum

/// Chart Elliott Wave Decoration.
@objc public enum ChartIQElliottWaveDecoration: Int, CaseIterable {

  /// The none option.
  case none

  /// The parentheses option.
  case parentheses

  /// The enclosed option.
  case enclosed

  /// Chart Elliott Wave Decoration display name.
  public var displayName: String {
    switch self {
    case .none:
      return "None"
    case .parentheses:
      return "Parentheses"
    case .enclosed:
      return "Enclosed"
    }
  }
}
