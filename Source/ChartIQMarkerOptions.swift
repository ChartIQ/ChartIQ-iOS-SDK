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
  /// The color of the signal.
  public var color: UIColor?

  /// The ChartIQMarkerOptions shape parameter.
  /// Shape of the signal marker on the chart.
  public var shape: ChartIQSignalShape

  /// The ChartIQMarkerOptions label parameter.
  /// The string to display in the marker.
  public var label: String

  /// The ChartIQMarkerOptions size parameter.
  /// Size of the signal marker on the chart. Possible values are S/M/L.
  public var size: ChartIQSignalSize

  /// The ChartIQMarkerOptions position parameter.
  /// Where to display the signal as a marker in relation to the main plot.
  public var position: ChartIQSignalPosition

  // MARK: - Initializers

  /// Init ChartIQMarkerOptions model with all parameters.
  ///
  /// - Parameters:
  ///   - markerType: The ChartIQSignalMarkerType model.
  ///   - color: The UIColor Object.
  ///   - shape: The ChartIQSignalShape model.
  ///   - label: The String Object.
  ///   - size: The ChartIQSignalSize model.
  ///   - position: The ChartIQSignalPosition model.
  public init(markerType: ChartIQSignalMarkerType,
              color: UIColor?,
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
  ///   - dictionary: The dictionary with data for init MarkerOptions model.
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
    if !colorHexString.isEmpty {
      self.color = UIColor(hexString: colorHexString)
    }
    self.shape = shape
    self.label = labelString
    self.size = size
    self.position = position
  }

  // MARK: - Public Methods

  /// Init ChartIQMarkerOptions model with default options.
  public static func defaultOptions() -> ChartIQMarkerOptions {
    return ChartIQMarkerOptions(markerType: .marker,
                                color: nil,
                                shape: .circle,
                                label: "X",
                                size: .medium,
                                position: .aboveCandle)
  }

  // MARK: - Helpers

  /// Convert MarkerOptions model to dictionary.
  ///
  /// - Returns: The dictionary with MarkerOptions model parameters.
  public func toDictionary() -> [String: String] {
    return [
      Const.MarkerOptions.typeParam: markerType.stringValue,
      Const.MarkerOptions.colorParam: color?.toHexString() ?? "",
      Const.MarkerOptions.shapeParam: shape.stringValue,
      Const.MarkerOptions.labelParam: label,
      Const.MarkerOptions.sizeParam: size.stringValue,
      Const.MarkerOptions.positionParam: position.stringValue
    ]
  }
}
