//
//  DrawToolColorCell.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - DrawToolColor Cell

class DrawToolColorCell: UICollectionViewCell {

  // MARK: - IBOutlets

  @IBOutlet private var imageView: UIImageView!
  @IBOutlet private var colorView: UIView!

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

    colorView.layer.cornerRadius = 2
    colorView.layer.borderColor = UIColor.brightGreyYankeesBlueColor.cgColor
    colorView.layer.borderWidth = dynamicMinimumLineWidth(ultra: false)
  }

  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    if #available(iOS 13.0, *), traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
      updateLayers()
    }
  }

  // MARK: - Internal Methods

  internal func setupCell(withViewModel viewModel: DrawToolViewModelProtocol) {
    guard let model = viewModel as? DrawToolColorViewModel else { return }
    imageView.image = model.image
    colorView.backgroundColor = model.color
  }

  // MARK: - Private Methods

  private func updateLayers() {
    let color = isSelected ? UIColor.mountainMeadowColor : .brightGreyYankeesBlueColor
    layer.borderColor = color.cgColor
    colorView.layer.borderColor = UIColor.brightGreyYankeesBlueColor.cgColor
  }
}
