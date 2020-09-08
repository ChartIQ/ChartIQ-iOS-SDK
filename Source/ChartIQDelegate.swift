//
//  ChartIQDelegate.swift
//  ChartIQ
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import Foundation

@objc(ChartIQDelegate)
public protocol ChartIQDelegate {

  /// Called when the symbol changes.
  ///
  /// - Parameters:
  ///   - chartIQView: The ChartIQView Object.
  @objc func chartIQViewDidFinishLoading(_ chartIQView: ChartIQView)

  /// Called when the symbol changes
  ///
  /// - Parameters:
  ///   - chartIQView: The ChartIQView Object.
  ///   - symbol: The String Object. The symbol name in String format.
  @objc optional func chartIQView(_ chartIQView: ChartIQView, didUpdateSymbol symbol: String)

  /// Called when the layout changes
  ///
  /// - Parameters:
  ///   - chartIQView: The ChartIQView Object.
  ///   - layout: The layout infomation in JSON format.
  @objc optional func chartIQView(_ chartIQView: ChartIQView, didUpdateLayout layout: Any)

  /// Called when a drawing is added or deleted (all the drawings are returned, not just the new one)
  ///
  /// - Parameters:
  ///   - chartIQView: The ChartIQView Object.
  ///   - drawings: The drawing objects in JSON format.
  @objc optional func chartIQView(_ chartIQView: ChartIQView, didUpdateDrawing drawings: Any)

  /// Called when a measure is updated
  ///
  /// - Parameters:
  ///   - chartIQView: The ChartIQView Object.
  ///   - measure: The String Object. The measure information in String format.
  @objc optional func chartIQView(_ chartIQView: ChartIQView, didUpdateMeasure measure: String)
}
