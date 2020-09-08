//
//  DisclosureTableCell.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - Disclosure TableCell

class DisclosureTableCell: UITableViewCell {

  // MARK: - View Lifecycle Methods

  override func awakeFromNib() {
    super.awakeFromNib()

    textLabel?.textColor = .darkElectricBlueWhiteColor
    textLabel?.font = .systemFont(ofSize: 17, weight: .regular)

    detailTextLabel?.textColor = .cadetBlueColor
    detailTextLabel?.font = .systemFont(ofSize: 17, weight: .regular)

    backgroundColor = .whiteDarkGunmetalColor
    selectionStyle = .none
  }

  // MARK: - Internal Methods

  internal func setupCell(withViewModel viewModel: TableCellViewModelProtocol) {
    guard let disclosureCellViewModel = viewModel as? DisclosureTableCellViewModel else { return }
    textLabel?.text = disclosureCellViewModel.title
    detailTextLabel?.text = disclosureCellViewModel.detailTitle
    accessoryType = .disclosureIndicator
  }
}
