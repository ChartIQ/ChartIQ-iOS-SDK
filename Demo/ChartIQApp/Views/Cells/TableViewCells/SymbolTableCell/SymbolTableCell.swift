//
//  SymbolTableCell.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - Symbol TableCell

class SymbolTableCell: UITableViewCell {

  // MARK: - IBOutlets

  @IBOutlet private var symbolNameLabel: UILabel!
  @IBOutlet private var symbolFullNameLabel: UILabel!
  @IBOutlet private var symbolExchangeLabel: UILabel!

  // MARK: - View Lifecycle Methods

  override func awakeFromNib() {
    super.awakeFromNib()

    symbolNameLabel.textColor = .darkElectricBlueWhiteColor
    symbolFullNameLabel.textColor = .cadetBlueColor
    symbolExchangeLabel.textColor = .darkElectricBlueWhiteColor

    backgroundColor = .whiteDarkGunmetalColor
    selectionStyle = .none
  }

  // MARK: - Internal Methods

  internal func setupCell(with symbolModel: SymbolModel) {
    symbolNameLabel.text = symbolModel.name
    symbolFullNameLabel.text = symbolModel.fullName
    symbolExchangeLabel.text = symbolModel.exchange
  }
}
