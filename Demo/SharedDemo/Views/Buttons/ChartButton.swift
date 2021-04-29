//
//  ChartButton.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
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
  case more
  case studies
  case settings
  case chartStyle
}

// MARK: - Chart Button

class ChartButton: UIButton {

  // MARK: - Private Properties

  private let locManager = LocalizationManager.shared()
  private var chartButtonType: ChartButtonType?

  // MARK: - View Lifecycle Methods

  override func draw(_ rect: CGRect) {
    alpha = isEnabled ? .visible : .translucent
  }

  // MARK: - Internal Methods

  internal func applyStyle(for chartButtonType: ChartButtonType, target: Any, action: Selector?) {
    self.chartButtonType = chartButtonType
    setupFrame(for: chartButtonType)
    setupImage(for: chartButtonType)
    setupStyle(for: chartButtonType)
    addTarget(target, action: action)
  }

  internal func updateStyle() {
    guard let chartButtonType = chartButtonType else { return }
    setupStyle(for: chartButtonType)
  }

  // MARK: - Private Methods

  private func setupFrame(for buttonType: ChartButtonType) {
    switch buttonType {
    case .symbols:
      frame = CGRect(origin: .zero, size: Const.ChartButton.symbolsButtonSize)
    case .intervals:
      frame = CGRect(origin: .zero, size: Const.ChartButton.intervalsButtonSize)
    case .series, .crosshair, .drawTool, .fullView, .more, .studies, .settings, .chartStyle:
      frame = CGRect(origin: .zero, size: Const.ChartButton.circleButtonSize)
    }
  }

  private func setupImage(for buttonType: ChartButtonType) {
    switch buttonType {
    case .series:
      setImage(UIImage.Chart.seriesImage, for: .normal)
    case .crosshair:
      setImage(UIImage.Chart.crosshairInactiveImage, for: .normal)
    case .drawTool:
      setImage(UIImage.Chart.drawToolInactiveImage, for: .normal)
    case .fullView:
      setImage(UIImage.Chart.fullViewInactiveImage, for: .normal)
    case .more:
      setImage(UIImage.Chart.moreInactiveImage, for: .normal)
    case .studies:
      setImage(UIImage.Chart.studiesImage, for: .normal)
    case .settings:
      setImage(UIImage.Chart.settingsImage, for: .normal)
    default:
      break
    }
  }

  private func setupStyle(for buttonType: ChartButtonType) {
    switch buttonType {
    case .symbols, .intervals:
      backgroundColor = .brightGreyYankeesBlueColor
      setTitleColor(.darkElectricBlueWhiteColor, for: .normal)
      layer.cornerRadius = 3
      clipsToBounds = true
      titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
      translatesAutoresizingMaskIntoConstraints = false
      widthAnchor.constraint(equalToConstant: frame.width).isActive = true
    case .chartStyle:
      layer.cornerRadius = Const.ChartButton.circleButtonSize.height / 2
      clipsToBounds = true
      setBackgroundColor(color: .brightGreyYankeesBlueColor, forState: .normal)
      translatesAutoresizingMaskIntoConstraints = false
      widthAnchor.constraint(equalToConstant: frame.width).isActive = true
      heightAnchor.constraint(equalToConstant: frame.height).isActive = true
    default:
      break
    }
  }

  private func addTarget(_ target: Any, action: Selector?) {
    guard let action = action else { return }
    addTarget(target, action: action, for: .touchUpInside)
  }
}
