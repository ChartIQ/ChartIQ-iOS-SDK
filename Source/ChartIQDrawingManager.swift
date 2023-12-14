//
//  ChartIQDrawingManager.swift
//  ChartIQ
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import Foundation

// MARK: - ChartIQDrawingManager

/// Encapsulates helper methods for working with the ChartIQ drawing tools and does not directly depend on ChartIQView.
public class ChartIQDrawingManager: ChartIQDrawingManagerProtocol {

  // MARK: - Initializers

  public init() {}

  // MARK: - Public Methods

  /// Check if the drawing supports fill color.
  ///
  /// - Parameters:
  ///   - tool: The ChartIQDrawingTool.
  /// - Returns: The Bool Value. True if supports fill color, false if not.
  public func isSupportingFillColor(_ tool: ChartIQDrawingTool) -> Bool {
    switch tool {
    case .arrow, .channel, .callout, .check, .cross, .ellipse, .fibArc, .fibFan, .fibProjection, .fibRetracement,
        .fibTimeZone, .focus, .gannFan, .gartley, .heart, .measurementLine, .quadrantLines, .rectangle, .speedResistanceArc,
        .speedResistanceLine, .star, .timeCycle, .tironeLevels, .trendLine:
      return true
    default:
      return false
    }
  }

  /// Check if the drawing supports line color.
  ///
  /// - Parameters:
  ///   - tool: The ChartIQDrawingTool.
  /// - Returns: The Bool Value. True if supports line color, false if not.
  public func isSupportingLineColor(_ tool: ChartIQDrawingTool) -> Bool {
    return true
  }

  /// Check if the drawing supports line type.
  ///
  /// - Parameters:
  ///   - tool: The ChartIQDrawingTool.
  /// - Returns: The Bool Value. True if supports line type, false if not.
  public func isSupportingLineType(_ tool: ChartIQDrawingTool) -> Bool {
    switch tool {
    case .annotation:
      return false
    default:
      return true
    }
  }

  /// Check if the drawing supports settings.
  ///
  /// - Parameters:
  ///   - tool: The ChartIQDrawingTool.
  /// - Returns: The Bool Value. True if supports pattern, false if not.
  public func isSupportingSettings(_ tool: ChartIQDrawingTool) -> Bool {
    switch tool {
    case .measure:
      return false
    default:
      return true
    }
  }

  /// Check if the drawing supports font.
  ///
  /// - Parameters:
  ///   - tool: The ChartIQDrawingTool.
  /// - Returns: The Bool Value. True if supports font, false if not.
  public func isSupportingFont(_ tool: ChartIQDrawingTool) -> Bool {
    switch tool {
    case .annotation, .callout, .elliottWave, .trendLine:
      return true
    default:
      return false
    }
  }

  /// Check if the drawing supports axis label.
  ///
  /// - Parameters:
  ///   - tool: The ChartIQDrawingTool.
  /// - Returns: The Bool Value. True if supports axis label, false if not.
  public func isSupportingAxisLabel(_ tool: ChartIQDrawingTool) -> Bool {
    switch tool {
    case .average, .crossline, .horizontal, .measurementLine, .vertical:
      return true
    default:
      return false
    }
  }

  /// Check if the drawing supports show callout.
  ///
  /// - Parameters:
  ///   - tool: The ChartIQDrawingTool.
  /// - Returns: The Bool Value. True if show callout, false if not.
  public func isSupportingShowCallout(_ tool: ChartIQDrawingTool) -> Bool {
    switch tool {
    case .trendLine:
      return true
    default:
      return false
    }
  }

  /// Check if the drawing supports std deviations.
  ///
  /// - Parameters:
  ///   - tool: The ChartIQDrawingTool.
  /// - Returns: The Bool Value. True if supports std deviations, false if not.
  public func isSupportingDeviations(_ tool: ChartIQDrawingTool) -> Bool {
    switch tool {
    case .average, .regression:
      return true
    default:
      return false
    }
  }

  /// Check if the drawing supports Fibonacci settings.
  ///
  /// - Parameters:
  ///   - tool: The ChartIQDrawingTool.
  /// - Returns: The Bool Value. True if supports Fibonacci tool, false if not.
  public func isSupportingFibonacci(_ tool: ChartIQDrawingTool) -> Bool {
    switch tool {
    case .fibArc, .fibFan, .fibProjection, .fibRetracement:
      return true
    default:
      return false
    }
  }

  /// Check if the drawing supports ElliotWave settings.
  ///
  /// - Parameters:
  ///   - tool: The ChartIQDrawingTool.
  /// - Returns: The Bool Value. True if supports ElliotWave tool, false if not.
  public func isSupportingElliottWave(_ tool: ChartIQDrawingTool) -> Bool {
    switch tool {
    case .elliottWave:
      return true
    default:
      return false
    }
  }

  /// Check if the drawing supports VolumeProfile settings.
  ///
  /// - Parameters:
  ///   - tool: The ChartIQDrawingTool.
  /// - Returns: The Bool Value. True if supports VolumeProfile tool, false if not.
  public func isSupportingVolumeProfile(_ tool: ChartIQDrawingTool) -> Bool {
    switch tool {
    case .volumeProfile:
      return true
    default:
      return false
    }
  }
}
