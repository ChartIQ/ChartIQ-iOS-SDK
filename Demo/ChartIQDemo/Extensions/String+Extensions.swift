//
//  String+Extensions.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - String Capitalized Extension

extension String {

  func capitalizeFirst() -> String {
    return prefix(1).capitalized + dropFirst()
  }

  mutating func capitalizeFirst() {
    self = self.capitalizeFirst()
  }
}

// MARK: - String Encoding Extension

extension String {

  func stringByAddingPercentEncodingForRFC3986() -> String? {
    let unreserved = "-._~/?"
    let allowed = NSMutableCharacterSet.alphanumeric()
    allowed.addCharacters(in: unreserved)
    return addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet)
  }
}
