//
//  DrawToolColorCell.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
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
  }

  // MARK: - Internal Methods

  internal func setupCell(withViewModel viewModel: DrawToolViewModelProtocol) {
    guard let model = viewModel as? DrawToolColorViewModel else { return }
    imageView.image = model.image
    colorView.backgroundColor = model.color
  }
}
