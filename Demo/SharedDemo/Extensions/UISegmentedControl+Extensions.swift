//
//  UISegmentedControl+Extensions.swift
//  ChartIQDemo
//
//  Copyright 2012-2022 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - UISegmentedControl Extensions

extension UISegmentedControl {

  func removeSegemntedControlShadow() {
    if #available(iOS 13.0, *) {
      // just to be sure it is full loaded
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        for i in 0...(self.numberOfSegments - 1) {
          let backgroundSegmentView = self.subviews[i]
          // it is not enogh changing the background color. It has some kind of shadow layer
          backgroundSegmentView.isHidden = true
        }
      }
    }
  }
}
