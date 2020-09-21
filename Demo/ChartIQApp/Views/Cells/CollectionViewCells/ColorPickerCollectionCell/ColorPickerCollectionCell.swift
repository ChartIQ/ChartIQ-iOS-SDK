//
//  ColorPickerCollectionCell.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - ColorPicker CollectionCell

class ColorPickerCollectionCell: UICollectionViewCell {

  // MARK: - IBOutlets

  @IBOutlet private var colorView: UIView!
  @IBOutlet private var selectionImageView: UIImageView!

  // MARK: - View Override Properties

  override var isSelected: Bool {
    didSet {
      let color = isSelected ? UIColor.mountainMeadowColor : .brightGreyYankeesBlueColor
      layer.borderColor = color.cgColor
      layer.borderWidth = isSelected ? 2.0 : 1.0

      selectionImageView.image = isSelected ? UIImage.ColorPickerCollectionCell.checkmarkImage : UIImage()
    }
  }

  // MARK: - View Lifecycle Methods

  override func awakeFromNib() {
    super.awakeFromNib()

    isSelected = false

    layer.cornerRadius = 4
    clipsToBounds = true
  }

  // MARK: - Internal Methods

  internal func setupCell(withColor color: UIColor) {
    colorView.backgroundColor = color
  }
}
