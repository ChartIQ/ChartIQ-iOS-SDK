//
//  DisclosureTableCell.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
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
    guard let disclosureViewModel = viewModel as? DisclosureTableCellViewModel else { return }
    textLabel?.text = disclosureViewModel.title
    detailTextLabel?.text = disclosureViewModel.detailTitle
    accessoryType = .disclosureIndicator
  }
}
