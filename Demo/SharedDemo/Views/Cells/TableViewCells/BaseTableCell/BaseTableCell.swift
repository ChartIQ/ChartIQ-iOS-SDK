//
//  BaseTableCell.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - Base TableCell

class BaseTableCell: UITableViewCell {

  // MARK: - View Lifecycle Methods

  override func awakeFromNib() {
    super.awakeFromNib()

    textLabel?.textColor = .darkElectricBlueWhiteColor
    textLabel?.font = .systemFont(ofSize: 17, weight: .regular)

    backgroundColor = .whiteDarkGunmetalColor
    selectionStyle = .none

    tintColor = .mountainMeadowColor
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    accessoryType = selected ? .checkmark : .none
  }

  // MARK: - Internal Methods

  internal func setupCell(withViewModel viewModel: BaseTableCellViewModel) {
    textLabel?.text = viewModel.title
    imageView?.image = viewModel.image
  }
}
