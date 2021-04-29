//
//  FilterCollectionCell.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - Filter CollectionCell

class FilterCollectionCell: UICollectionViewCell {

  // MARK: - IBOutlets

  @IBOutlet private var titleLabel: UILabel!

  // MARK: - View Override Properties

  override var isSelected: Bool {
    didSet {
      let color = isSelected ? UIColor.mountainMeadowColor : .gainsboroDarkYankeesBlueColor
      layer.borderColor = color.cgColor
      layer.borderWidth = isSelected ? 2.0 : 1.0
    }
  }

  // MARK: - View Lifecycle Methods

  override func awakeFromNib() {
    super.awakeFromNib()

    titleLabel?.textColor = .darkElectricBlueWhiteColor
    titleLabel?.font = Const.FilterCollectionCell.cellTitleFont

    isSelected = false

    backgroundColor = .whiteDarkGunmetalColor
    layer.cornerRadius = 3
    clipsToBounds = true
  }

  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    if #available(iOS 13.0, *), traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
      updateLayers()
    }
  }

  // MARK: - Internal Methods

  internal func setupCell(withFilterItem filterItem: String) {
    titleLabel.text = filterItem
  }

  // MARK: - Private Methods

  private func updateLayers() {
    let color = isSelected ? UIColor.mountainMeadowColor : .gainsboroDarkYankeesBlueColor
    layer.borderColor = color.cgColor
  }
}
