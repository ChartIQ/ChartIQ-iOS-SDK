//
//  ChartIQDrawingManagerProtocol.swift
//  ChartIQ
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import Foundation

// MARK: - ChartIQDrawingManager Protocol

@objc(ChartIQDrawingManagerProtocol)
internal protocol ChartIQDrawingManagerProtocol {

  /// Check if the drawing supports fill color.
  ///
  /// - Parameters:
  ///   - tool: The ChartIQDrawingTool.
  /// - Returns: The Bool Value. True if supports fill color, false if not.
  func isSupportingFillColor(_ tool: ChartIQDrawingTool) -> Bool

  /// Check if the drawing supports line color.
  ///
  /// - Parameters:
  ///   - tool: The ChartIQDrawingTool.
  /// - Returns: The Bool Value. True if supports line color, false if not.
  func isSupportingLineColor(_ tool: ChartIQDrawingTool) -> Bool

  /// Check if the drawing supports line type.
  ///
  /// - Parameters:
  ///   - tool: The ChartIQDrawingTool.
  /// - Returns: The Bool Value. True if supports line type, false if not.
  func isSupportingLineType(_ tool: ChartIQDrawingTool) -> Bool

  /// Check if the drawing supports settings.
  ///
  /// - Parameters:
  ///   - tool: The ChartIQDrawingTool.
  /// - Returns: The Bool Value. True if supports pattern, false if not.
  func isSupportingSettings(_ tool: ChartIQDrawingTool) -> Bool

  /// Check if the drawing supports font.
  ///
  /// - Parameters:
  ///   - tool: The ChartIQDrawingTool.
  /// - Returns: The Bool Value. True if supports font, false if not.
  func isSupportingFont(_ tool: ChartIQDrawingTool) -> Bool

  /// Check if the drawing supports axis label.
  ///
  /// - Parameters:
  ///   - tool: The ChartIQDrawingTool.
  /// - Returns: The Bool Value. True if supports axis label, false if not.
  func isSupportingAxisLabel(_ tool: ChartIQDrawingTool) -> Bool

  /// Check if the drawing supports std deviations.
  ///
  /// - Parameters:
  ///   - tool: The ChartIQDrawingTool.
  /// - Returns: The Bool Value. True if supports std deviations, false if not.
  func isSupportingStdDeviations(_ tool: ChartIQDrawingTool) -> Bool

  /// Check if the drawing supports Fibonacci settings.
  ///
  /// - Parameters:
  ///   - tool: The ChartIQDrawingTool.
  /// - Returns: The Bool Value. True if supports Fibonacci tool, false if not.
  func isSupportingFibonacci(_ tool: ChartIQDrawingTool) -> Bool

  /// Check if the drawing supports ElliotWave settings.
  ///
  /// - Parameters:
  ///   - tool: The ChartIQDrawingTool.
  /// - Returns: The Bool Value. True if supports ElliotWave tool, false if not.
  func isSupportingElliottWave(_ tool: ChartIQDrawingTool) -> Bool
}
