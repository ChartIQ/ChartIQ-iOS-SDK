//
//  UIVisualEffectView+Extensions.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - UIVisualEffectView Extensions

extension UIVisualEffectView {

  convenience init(style: UIBlurEffect.Style) {
    let blurEffect = UIBlurEffect(style: style)
    self.init(effect: blurEffect)
    self.backgroundColor = .whiteYankeesBlueColor
    self.alpha = 1
  }
}
