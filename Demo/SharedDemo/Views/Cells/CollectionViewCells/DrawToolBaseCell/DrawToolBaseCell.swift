//
//  DrawToolBaseCell.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - DrawToolBase Cell

class DrawToolBaseCell: UICollectionViewCell {

  // MARK: - IBOutlets

  @IBOutlet private var imageView: UIImageView!

  // MARK: - View Override Properties

  override var isSelected: Bool {
    didSet {
      let color = isSelected ? UIColor.mountainMeadowColor : .brightGreyYankeesBlueColor
      layer.borderColor = color.cgColor
      layer.borderWidth = isSelected ? 2.0 : 1.0
    }
  }

  // MARK: - View Lifecycle Methods

  override func awakeFromNib() {
    super.awakeFromNib()

    isSelected = false

    layer.cornerRadius = 3
    clipsToBounds = true

    backgroundColor = .whiteDarkGunmetalColor
  }

  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    if #available(iOS 13.0, *), traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
      updateLayers()
    }
  }

  // MARK: - Internal Methods

  internal func setupCell(withViewModel viewModel: DrawToolViewModelProtocol) {
    imageView.image = viewModel.image
  }

  // MARK: - Private Methods

  private func updateLayers() {
    let color = isSelected ? UIColor.mountainMeadowColor : .brightGreyYankeesBlueColor
    layer.borderColor = color.cgColor
  }
}
