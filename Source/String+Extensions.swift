//
//  String+Extensions.swift
//  ChartIQ
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import Foundation

// MARK: - String Replace Extension

/// Extension for String functionality.
public extension String {

  // MARK: - Public Methods

  /// Extends the functionality of a String with the ability to replace one string with another string.
  ///
  /// - Parameters:
  ///   - string: The String Object. The string to be replaced.
  ///   - replaceString: The String Object. Whose string will be replaced by the original string.
  /// - Returns: The String Object that contains a string with replaced string.
  func replace(_ string: String, with replaceString: String) -> String {
    return self.replacingOccurrences(of: string, with: replaceString, options: .literal, range: nil)
  }

  /// Extends the functionality of a String with the ability to replace symbol with Zwnj symbol.
  ///
  /// - Parameters:
  ///   - symbol: The String Object.
  /// - Returns: The String Object that contains a string with zwnj symbol replaced with another symbol.
  mutating func replaceSymbolWithZwnj(symbol: String) -> String {
    if self.contains("\(symbol)\(ChartIQConstants.General.zwnjSymbol)") {
      self.remove(at: self.startIndex)
      self.insert(contentsOf: ChartIQConstants.General.zwnjSymbol, at: self.startIndex)
    }
    return self
  }

  /// Extends the functionality of a String with the ability to slice one string from another string.
  ///
  /// - Parameters:
  ///   - from: The String Object. The beginning of the string from which the fragment will be cut.
  ///   - to: The String Object. The end of string to which the fragment will be cut.
  /// - Returns: The String Object that contains a string between from string and to string.
  func slice(from: String, to: String) -> String? {
    return (range(of: from)?.upperBound).flatMap { substringFrom in
      (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
        String(self[substringFrom..<substringTo])
      }
    }
  }
}
