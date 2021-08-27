//
//  UIStackView+Extensions.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - UIStackView Extensions

extension UIStackView {

  func removeAllArrangedSubviews() {
    // Remove the arrangedSubviews from self
    let removedSubviews = arrangedSubviews.reduce([]) { allSubviews, subview -> [UIView] in
      self.removeArrangedSubview(subview)
      return allSubviews + [subview]
    }

    // Deactivate all constraints
    NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))

    // Remove the views from self
    removedSubviews.forEach({ $0.removeFromSuperview() })
  }

  func addSpacerView() {
    let spacerView = UIView()
    spacerView.setContentHuggingPriority(.defaultLow, for: .horizontal)
    addArrangedSubview(spacerView)
  }
}
