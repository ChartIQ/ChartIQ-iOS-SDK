//
//  SymbolModel.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
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
