//
//  LineModel+Extensions.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import Foundation

// MARK: - LineModel Extension

extension LineModel {

  // MARK: - Internal Methods

  internal static func allLines() -> [LineModel] {
    return [
      LineModel(lineType: .solid, lineWidth: 1),
      LineModel(lineType: .solid, lineWidth: 2),
      LineModel(lineType: .solid, lineWidth: 3),
      LineModel(lineType: .dotted, lineWidth: 1),
      LineModel(lineType: .dotted, lineWidth: 2),
      LineModel(lineType: .dashed, lineWidth: 1),
      LineModel(lineType: .dashed, lineWidth: 2)
    ]
  }
}
