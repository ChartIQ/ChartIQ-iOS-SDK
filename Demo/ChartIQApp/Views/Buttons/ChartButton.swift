//
//  ChartButton.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - ChartButtonType Enum

enum ChartButtonType {
  case symbols
  case intervals
  case series
  case drawTool
  case crosshair
  case fullView
}

// MARK: - Chart Button

class ChartButton: UIButton {

  // MARK: - Private Properties

  private let locManager = LocalizationManager.shared()

  // MARK: - View Lifecycle Methods

  override func draw(_ rect: CGRect) {
    alpha = isEnabled ? .visible : .translucent
  }

  // MARK: - Internal Methods

  internal func applyStyle(for buttonType: ChartButtonType, target: Any, action: Selector) {
    switch buttonType {
    case .symbols:
      applyBaseStyle()
    case .intervals:
      applyBaseStyle()
    case .series:
      setImage(UIImage.Chart.seriesImage, for: .normal)
      contentEdgeInsets = Const.ChartButton.seriesEdgeInsets
    case .crosshair:
      setImage(UIImage.Chart.crosshairInactiveImage, for: .normal)
      contentEdgeInsets = Const.ChartButton.crosshairEdgeInsets
    case .drawTool:
      setImage(UIImage.Chart.drawToolInactiveImage, for: .normal)
      contentEdgeInsets = Const.ChartButton.drawToolEdgeInsets
    case .fullView:
      setImage(UIImage.Chart.fullViewInactiveImage, for: .normal)
      contentEdgeInsets = Const.ChartButton.fullViewEdgeInsets
    }
    addTarget(target, action: action, for: .touchUpInside)
  }

  // MARK: - Private Methods

  private func applyBaseStyle() {
    backgroundColor = .brightGreyYankeesBlueColor
    setTitleColor(.darkElectricBlueWhiteColor, for: .normal)
    layer.cornerRadius = 3
    clipsToBounds = true
    titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
    translatesAutoresizingMaskIntoConstraints = false
    widthAnchor.constraint(equalToConstant: frame.width).isActive = true
  }
}
