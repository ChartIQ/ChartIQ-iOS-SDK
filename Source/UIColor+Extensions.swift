//
//  UIColor+Extensions.swift
//  ChartIQ
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - UIColor Hex Extension

/// Extension for UIColor functionality.
public extension UIColor {

  // MARK: - Public Init

  /// Extends the functionality of a UIColor with the ability to init it with hex string.
  ///
  /// - Parameters:
  ///   - hexString: The String Object. The hex string to init UIColor.
  convenience init(hexString: String) {
    let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
    var int = UInt32()
    Scanner(string: hex).scanHexInt32(&int)
    let a, r, g, b: UInt32
    switch hex.count {
    case 3: // RGB (12-bit)
      (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
    case 6: // RGB (24-bit)
      (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
    case 8: // ARGB (32-bit)
      (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
    default:
      (a, r, g, b) = (255, 0, 0, 0)
    }
    self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
  }

  // MARK: - Public Methods

  /// Extends the functionality of a UIColor with the ability to convert it to hex string.
  ///
  /// - Returns: The String Object that contains a color in hex format.
  func toHexString() -> String {
    var r: CGFloat = 0
    var g: CGFloat = 0
    var b: CGFloat = 0
    var a: CGFloat = 0
    getRed(&r, green: &g, blue: &b, alpha: &a)
    let rgb: Int = (Int)(r * 255) << 16 | (Int)(g * 255) << 8 | (Int)(b * 255) << 0
    return String(format: "#%06x", rgb)
  }

  /// Extends the functionality of a UIColor with the ability to use color asset for all iOS Versions, iOS 13+ by name and older by base color.
  ///
  /// - Parameters:
  ///   - colorAssetName: The String Object. The name for color asset used for dark mode in iOS 13 and higher.
  ///   - baseColor: The UIColor Object. The color used as base color for iOS versions below iOS 13.
  /// - Returns: The UIColor Object.
  static func colorAsset(name colorAssetName: String, baseColor: UIColor) -> UIColor {
    if #available(iOS 11.0, *) {
      return UIColor(named: colorAssetName) ?? baseColor
    } else {
      return baseColor
    }
  }
}
