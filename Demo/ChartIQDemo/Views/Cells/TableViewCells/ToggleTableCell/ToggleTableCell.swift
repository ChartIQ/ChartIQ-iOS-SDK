//
//  ToggleTableCell.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - Toggle TableCell

class ToggleTableCell: UITableViewCell {

  // MARK: - IBOutlets

  @IBOutlet private var titleLabel: UILabel!
  @IBOutlet private var toggleView: UISwitch!

  // MARK: - Internal Properties

  internal var toggleDidChange: ((Bool) -> Void)?

  // MARK: - View Lifecycle Methods

  override func awakeFromNib() {
    super.awakeFromNib()

    titleLabel?.textColor = .darkElectricBlueWhiteColor
    titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)

    backgroundColor = .whiteDarkGunmetalColor
    selectionStyle = .none

    toggleView.setOn(false, animated: false)
    toggleView.onTintColor = .mountainMeadowColor
    toggleView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
  }

  // MARK: - Action Methods

  @objc private func switchChanged(_ sender: UISwitch) {
    toggleDidChange?(sender.isOn)
  }

  // MARK: - Internal Methods

  internal func setupCell(withViewModel viewModel: TableCellViewModelProtocol) {
    guard let toggleCellViewModel = viewModel as? ToggleTableCellViewModel else { return }
    titleLabel?.text = toggleCellViewModel.title.capitalizeFirst()
    toggleView.setOn(toggleCellViewModel.isToggleOn, animated: false)
  }
}
