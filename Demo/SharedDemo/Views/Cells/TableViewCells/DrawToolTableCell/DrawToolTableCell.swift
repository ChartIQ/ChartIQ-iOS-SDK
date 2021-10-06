//
//  DrawToolTableCell.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - DrawTool TableCell

class DrawToolTableCell: UITableViewCell {

  // MARK: - IBOutlets

  @IBOutlet private var toolImageView: UIImageView!
  @IBOutlet private var titleLabel: UILabel!
  @IBOutlet private var starImageView: UIImageView!

  // MARK: - Private Properties

  private let locManager = LocalizationManager.shared()

  // MARK: - View Lifecycle Methods

  override func awakeFromNib() {
    super.awakeFromNib()

    starImageView.isHidden = true

    titleLabel?.textColor = .darkElectricBlueWhiteColor
    titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)

    backgroundColor = .whiteDarkGunmetalColor
    selectionStyle = .none

    tintColor = .mountainMeadowColor

    starImageView.isHidden = true
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    accessoryType = selected ? .checkmark : .none
  }

  // MARK: - Internal Methods

  internal func setupCell(withViewModel viewModel: DrawToolViewModel) {
    titleLabel?.text = locManager.localize(viewModel.displayName)
    toolImageView.image = viewModel.toolImage
    if let isInFavorites = viewModel.isInFavorites {
      starImageView.isHidden = !isInFavorites
    }
  }
}
