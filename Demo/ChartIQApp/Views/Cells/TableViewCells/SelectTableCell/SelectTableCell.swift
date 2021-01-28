//
//  SelectTableCell.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
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
    if let selectCellViewModel = viewModel as? SelectTableCellViewModel {
      textLabel?.text = selectCellViewModel.title
      detailTextLabel?.text = (selectCellViewModel.detailTitle ?? "")
    } else if let fibSettingsCellViewModel = viewModel as? FibSettingsTableCellViewModel {
      textLabel?.text = fibSettingsCellViewModel.title
      detailTextLabel?.text = nil
    } else if let deviationsCellViewModel = viewModel as? DeviationsTableCellViewModel {
      textLabel?.text = deviationsCellViewModel.title
      detailTextLabel?.text = nil
    }
  }
}
