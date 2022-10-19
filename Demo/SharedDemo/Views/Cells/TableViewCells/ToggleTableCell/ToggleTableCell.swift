//
//  ToggleTableCell.swift
//  ChartIQDemo
//
//  Copyright 2012-2022 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - Toggle TableCell

class ToggleTableCell: UITableViewCell {

  // MARK: - IBOutlets

  @IBOutlet private var titleLabel: UILabel!
  @IBOutlet private var toggle: UISwitch!
  @IBOutlet private var toggleTrailingConstraint: NSLayoutConstraint!
  @IBOutlet private var disclosureIndicatorImageView: UIImageView!

  // MARK: - Internal Properties

  internal var didChangeToggle: ((Bool) -> Void)?

  // MARK: - View Lifecycle Methods

  override func awakeFromNib() {
    super.awakeFromNib()

    backgroundColor = .whiteDarkGunmetalColor
    selectionStyle = .none

    titleLabel.textColor = .darkElectricBlueWhiteColor
    titleLabel.font = .systemFont(ofSize: 17, weight: .regular)

    toggle.setOn(false, animated: false)
    toggle.onTintColor = .mountainMeadowColor
    toggle.addTarget(self, action: #selector(self.toggleChanged(_:)), for: .valueChanged)

    disclosureIndicatorImageView.tintColor = .arsenicBrightGrayMediumColor.withAlphaComponent(0.3)
  }

  // MARK: - Action Methods

  @objc private func toggleChanged(_ sender: UISwitch) {
    didChangeToggle?(sender.isOn)
  }

  // MARK: - Internal Methods

  internal func setupCell(withViewModel viewModel: TableCellViewModelProtocol) {
    if let toggleViewModel = viewModel as? ToggleTableCellViewModel {
      titleLabel?.text = toggleViewModel.title.capitalizeFirst()
      toggle.setOn(toggleViewModel.isToggleOn, animated: false)
      toggleTrailingConstraint.constant = 20.0
      disclosureIndicatorImageView.isHidden = true
    } else if let toggleDisclosureViewModel = viewModel as? ToggleDisclosureTableCellViewModel {
      titleLabel?.text = toggleDisclosureViewModel.title.capitalizeFirst()
      toggle.setOn(toggleDisclosureViewModel.isToggleOn, animated: false)
      toggleTrailingConstraint.constant = 42.0
      disclosureIndicatorImageView.isHidden = false
    }
  }
}
