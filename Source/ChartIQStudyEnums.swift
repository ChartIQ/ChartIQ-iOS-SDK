//
//  ChartIQStudyEnums.swift
//  ChartIQ
//
//  Copyright 2012-2022 by ChartIQ, Inc.
//  All rights reserved
//

import Foundation

// MARK: - ChartIQStudyParametersType Enum

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
