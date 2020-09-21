//
//  CrosshairInfoView.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - CrosshairInfo View

class CrosshairInfoView: UIView {

  // MARK: - IBOutlets

  @IBOutlet private var backgroundView: UIView!

  @IBOutlet private var priceTitleLabel: UILabel!
  @IBOutlet private var priceValueLabel: UILabel!

  @IBOutlet private var volumeTitleLabel: UILabel!
  @IBOutlet private var volumeValueLabel: UILabel!

  @IBOutlet private var openTitleLabel: UILabel!
  @IBOutlet private var openValueLabel: UILabel!

  @IBOutlet private var highTitleLabel: UILabel!
  @IBOutlet private var highValueLabel: UILabel!

  @IBOutlet private var closeTitleLabel: UILabel!
  @IBOutlet private var closeValueLabel: UILabel!

  @IBOutlet private var lowTitleLabel: UILabel!
  @IBOutlet private var lowValueLabel: UILabel!

  // MARK: - Private Properties

  private let locManager = LocalizationManager.shared()

  // MARK: - View Lifecycle Methods

  static func instantiate() -> CrosshairInfoView {
    let view: CrosshairInfoView = CrosshairInfoView.loadFromNib()
    let emptyCrosshairHUD = ChartIQCrosshairHUD(price: "", volume: "", open: "", high: "", close: "", low: "")
    view.updateView(withCrosshairHUD: emptyCrosshairHUD)
    return view
  }

  override func awakeFromNib() {
    super.awakeFromNib()

    backgroundView.backgroundColor = .ghostWhiteСhineseBlackColor
    backgroundView.alpha = 0.85

    [priceTitleLabel, volumeTitleLabel, openTitleLabel,
     highTitleLabel, closeTitleLabel, lowTitleLabel].forEach { label in
      label.textColor = .darkElectricBlueCadetBlueColor
    }

    [priceValueLabel, volumeValueLabel, openValueLabel,
     highValueLabel, closeValueLabel, lowValueLabel].forEach { label in
      label.textColor = .yankeesBlueMayaBlueColor
    }
  }

  // MARK: - Internal Methods

  internal func updateView(withCrosshairHUD crosshairHUD: ChartIQCrosshairHUD) {
    priceTitleLabel.text = decorateTitle(title: Const.CrosshairInfoView.priceTitle)
    volumeTitleLabel.text = decorateTitle(title: Const.CrosshairInfoView.volumeTitle)
    openTitleLabel.text = decorateTitle(title: Const.CrosshairInfoView.openTitle)
    highTitleLabel.text = decorateTitle(title: Const.CrosshairInfoView.highTitle)
    closeTitleLabel.text = decorateTitle(title: Const.CrosshairInfoView.closeTitle)
    lowTitleLabel.text = decorateTitle(title: Const.CrosshairInfoView.lowTitle)

    priceValueLabel.text = crosshairHUD.price.uppercased()
    volumeValueLabel.text = crosshairHUD.volume.uppercased()
    openValueLabel.text = crosshairHUD.open.uppercased()
    highValueLabel.text = crosshairHUD.high.uppercased()
    closeValueLabel.text = crosshairHUD.close.uppercased()
    lowValueLabel.text = crosshairHUD.low.uppercased()
  }

  // MARK: - Internal Methods

  private func decorateTitle(title: String) -> String {
    let localizedTitle = locManager.localize(title)
    let uppercasedTitle = localizedTitle.uppercased()
    let decoratedTitle = uppercasedTitle + Const.General.colonSymbol
    return decoratedTitle
  }
}
