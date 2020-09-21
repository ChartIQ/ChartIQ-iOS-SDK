//
//  LinePickerCollectionCell.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - LinePicker CollectionCell

class LinePickerCollectionCell: UICollectionViewCell {

  // MARK: - IBOutlets

  @IBOutlet private var lineImageView: UIImageView!

  // MARK: - View Override Properties

  override var isSelected: Bool {
    didSet {
      let color = isSelected ? UIColor.mountainMeadowColor : .gainsboroDarkElectricBlueColor
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
  }

  // MARK: - Internal Methods

  internal func setupCell(withLineImage image: UIImage?) {
    lineImageView.image = image
  }
}
