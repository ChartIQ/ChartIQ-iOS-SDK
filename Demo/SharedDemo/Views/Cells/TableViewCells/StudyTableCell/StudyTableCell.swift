//
//  StudyTableCell.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - Study TableCell

class StudyTableCell: UITableViewCell {

  // MARK: - View Lifecycle Methods

  override func awakeFromNib() {
    super.awakeFromNib()

    textLabel?.textColor = .darkElectricBlueWhiteColor
    textLabel?.font = .systemFont(ofSize: 17, weight: .regular)

    detailTextLabel?.textColor = .cadetBlueColor
    detailTextLabel?.font = .systemFont(ofSize: 15, weight: .regular)

    backgroundColor = .whiteDarkGunmetalColor
    selectionStyle = .none
  }

  // MARK: - Internal Methods

  internal func setupCell(withViewModel viewModel: TableCellViewModelProtocol) {
    guard let studyViewModel = viewModel as? StudyTableCellViewModel else { return }
    textLabel?.text = studyViewModel.title
    detailTextLabel?.text = studyViewModel.detailTitle
    accessoryType = .disclosureIndicator
  }
}
