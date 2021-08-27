//
//  LanguageModel.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - Language Model

struct LanguageModel: Equatable {

  // MARK: - Internal Properties

  internal let displayName: String
  internal let languageCode: String

  // MARK: - Init

  init(name: String, languageCode: String) {
    self.displayName = name
    self.languageCode = languageCode
  }
}
