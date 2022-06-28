//
//  ChartIQMarkerOptions.swift
//  ChartIQ
//
//  Copyright 2012-2022 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

/// Encapsulates parameters with additional information for Marker.
public class ChartIQMarkerOptions: NSObject {

  // MARK: - Public Properties

  /// The ChartIQMarkerOptions markerType parameter.
  public var markerType: ChartIQSignalMarkerType

  /// The ChartIQMarkerOptions color parameter.
  public var color: UIColor

  /// The ChartIQMarkerOptions shape parameter.
  public var shape: ChartIQSignalShape

  /// The ChartIQMarkerOptions label parameter.
  public var label: String

  /// The ChartIQMarkerOptions size parameter.
  public var size: ChartIQSignalSize

  /// The ChartIQMarkerOptions position parameter.
  public var position: ChartIQSignalPosition

  // MARK: - Initializers

  /// Init ConditionAppearance model with all parameters.
  ///
  /// - Parameters:
  ///   - markerType: The ChartIQSignalMarkerType Object.
  ///   - color: The UIColor Object.
  ///   - shape: The ChartIQSignalShape Object.
  ///   - label: The String Object.
  ///   - size: The ChartIQSignalSize Object.
  ///   - position: The ChartIQSignalPosition Object.
  public init(markerType: ChartIQSignalMarkerType,
              color: UIColor,
              shape: ChartIQSignalShape,
              label: String,
              size: ChartIQSignalSize,
              position: ChartIQSignalPosition) {
    self.markerType = markerType
    self.color = color
    self.shape = shape
    self.label = label
    self.size = size
    self.position = position
  }

  // MARK: - Helpers

  /// Convert Data model to dictionary.
  ///
  /// - Returns: The dictionary with Data model.
  public func toDictionary() -> [String: String] {
    return [
      "type": markerType.stringValue,
      "shape": shape.stringValue,
      "label": label,
      "size": size.stringValue,
      "position": position.stringValue
    ]
  }
}
