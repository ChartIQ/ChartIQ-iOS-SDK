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

  /// Init ChartIQMarkerOptions model with all parameters.
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

  /// Init ChartIQMarkerOptions model with dictionary.
  ///
  /// - Parameters:
  ///   - dictionary: The dictionary with data for init Signal model.
  public init?(dictionary: [String: Any]) {
    guard let markerTypeString = dictionary[Const.MarkerOptions.typeParam] as? String,
          let markerType = ChartIQSignalMarkerType(stringValue: markerTypeString),
          let colorHexString = dictionary[Const.MarkerOptions.colorParam] as? String,
          let shapeString = dictionary[Const.MarkerOptions.shapeParam] as? String,
          let shape = ChartIQSignalShape(stringValue: shapeString),
          let labelString = dictionary[Const.MarkerOptions.labelParam] as? String,
          let sizeString = dictionary[Const.MarkerOptions.sizeParam] as? String,
          let size = ChartIQSignalSize(stringValue: sizeString),
          let positionString = dictionary[Const.MarkerOptions.positionParam] as? String,
          let position = ChartIQSignalPosition(stringValue: positionString) else { return nil }
    self.markerType = markerType
    self.color = UIColor(hexString: colorHexString)
    self.shape = shape
    self.label = labelString
    self.size = size
    self.position = position
  }

  // MARK: - Helpers

  /// Convert Data model to dictionary.
  ///
  /// - Returns: The dictionary with Data model.
  public func toDictionary() -> [String: String] {
    return [
      Const.MarkerOptions.typeParam: markerType.stringValue,
      Const.MarkerOptions.colorParam: color.toHexString(),
      Const.MarkerOptions.shapeParam: shape.stringValue,
      Const.MarkerOptions.labelParam: label,
      Const.MarkerOptions.sizeParam: size.stringValue,
      Const.MarkerOptions.positionParam: position.stringValue
    ]
  }
}
