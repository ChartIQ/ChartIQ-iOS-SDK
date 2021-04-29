//
//  SymbolModel.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - Symbol Model

struct SymbolModel: Equatable {

  // MARK: - Internal Properties

  internal let name: String
  internal let fullName: String
  internal let exchange: String

  // MARK: - Init

  init(name: String, fullName: String, exchange: String) {
    self.name = name
    self.fullName = fullName
    self.exchange = exchange
  }

  internal init?(unparsedString: String) {
    let symbolParamsArray = unparsedString.components(separatedBy: Const.SymbolModel.paramsArraySeparator)
    guard symbolParamsArray.count >= 3 else { return nil }
    self.name = symbolParamsArray[0]
    self.fullName = symbolParamsArray[1]
    self.exchange = symbolParamsArray[2]
  }
}

// MARK: - SearchSymbolsFilterType Enum

enum SearchSymbolsFilterType: Int, CaseIterable {
  case all
  case stocks
  case forex
  case indexes
  case funds
  case futures

  internal var stringValue: String {
    switch self {
    case .all:
      return Const.SearchSymbols.allFilterItemTitle
    case .stocks:
      return Const.SearchSymbols.stocksFilterItemTitle
    case .forex:
      return Const.SearchSymbols.forexFilterItemTitle
    case .indexes:
      return Const.SearchSymbols.indexesFilterItemTitle
    case .funds:
      return Const.SearchSymbols.fundsFilterItemTitle
    case .futures:
      return Const.SearchSymbols.futuresFilterItemTitle
    }
  }

  internal var displayName: String {
    switch self {
    case .all:
      return Const.SearchSymbols.allFilterItemTitle
    case .stocks:
      return Const.SearchSymbols.stocksFilterItemTitle
    case .forex:
      return Const.SearchSymbols.forexFilterItemTitle
    case .indexes:
      return Const.SearchSymbols.indexesFilterItemTitle
    case .funds:
      return Const.SearchSymbols.fundsFilterItemTitle
    case .futures:
      return Const.SearchSymbols.futuresFilterItemTitle
    }
  }

  internal init?(stringValue: String) {
    let dictionary: [String: SearchSymbolsFilterType] = [
      Const.SearchSymbols.allFilterItemTitle: .all,
      Const.SearchSymbols.stocksFilterItemTitle: .stocks,
      Const.SearchSymbols.forexFilterItemTitle: .forex,
      Const.SearchSymbols.indexesFilterItemTitle: .indexes,
      Const.SearchSymbols.fundsFilterItemTitle: .funds,
      Const.SearchSymbols.futuresFilterItemTitle: .futures
    ]
    if let value = dictionary[stringValue] {
      self = value
    } else {
      return nil
    }
  }
}
