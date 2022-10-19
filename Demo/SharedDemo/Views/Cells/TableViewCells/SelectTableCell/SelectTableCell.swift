//
//  SelectTableCell.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - Select TableCell

class SelectTableCell: UITableViewCell {

  // MARK: - Internal Properties

  internal var didSelectButtonTapped: (() -> Void)?

  // MARK: - View Lifecycle Methods

  override func awakeFromNib() {
    super.awakeFromNib()

    textLabel?.textColor = .darkElectricBlueWhiteColor
    textLabel?.font = .systemFont(ofSize: 17, weight: .regular)

    detailTextLabel?.textColor = .cadetBlueColor
    detailTextLabel?.font = .systemFont(ofSize: 17, weight: .regular)

    backgroundColor = .whiteDarkGunmetalColor
    selectionStyle = .none

    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectButtonTapped))
    addGestureRecognizer(tapGesture)
  }

  // MARK: - Action Methods

  @objc private func selectButtonTapped() {
    didSelectButtonTapped?()
  }

  // MARK: - Internal Methods

  internal func setupCell(withViewModel viewModel: TableCellViewModelProtocol) {
    accessoryType = .disclosureIndicator
    if let selectViewModel = viewModel as? SelectTableCellViewModel {
      textLabel?.text = selectViewModel.title
      detailTextLabel?.text = (selectViewModel.detailTitle ?? "")
    } else if let fibSettingsViewModel = viewModel as? FibSettingsTableCellViewModel {
      textLabel?.text = fibSettingsViewModel.title
      detailTextLabel?.text = nil
    } else if let deviationsViewModel = viewModel as? DeviationsTableCellViewModel {
      textLabel?.text = deviationsViewModel.title
      detailTextLabel?.text = nil
    }
  }
}
