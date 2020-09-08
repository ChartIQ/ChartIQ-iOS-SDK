//
//  ChartIQConstants.swift
//  ChartIQ
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import Foundation

// MARK: - ChartIQConstants

/// Provides constants grouped by data structures used in the SDK.
internal struct ChartIQConstants {

  // MARK: - General

  internal struct General {
    static let zwnjSymbol = "\u{200c}"
    static let doubleVerticalLinesSymbol = "||"
    static let newlineSymbol = "\n"
    static let quoteSymbol = "\""
    static let commaSpaceSymbol = ", "
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
    static let inputsParam = "inputs"
    static let outputsParam = "outputs"
    static let parametersParam = "parameters"
    static let nullParam = "null"
  }

  // MARK: - CallbackMessage

  /// Provides constants for ChartIQCallbackMessage.
  internal struct CallbackMessage {
    static let callbackKeyParam = "cb"
  }

  internal struct LogMessage {
    static let argumentsParam = "arguments"
    static let methodParam = "method"
    static let logParam = "LOG"
  }
}
