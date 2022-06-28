//
//  LineTableCell.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - Line TableCell

class LineTableCell: UITableViewCell {

  // MARK: - IBOutlets

  @IBOutlet private var titleLabel: UILabel!
  @IBOutlet private var lineImageView: UIImageView!

  // MARK: - Internal Properties

  internal var didSelectLineButtonTapped: (() -> Void)?

  // MARK: - View Lifecycle Methods

  override func awakeFromNib() {
    super.awakeFromNib()

    titleLabel?.textColor = .darkElectricBlueWhiteColor
    titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)

    backgroundColor = .whiteDarkGunmetalColor
    selectionStyle = .none
  }

  // MARK: - Action Methods

  @IBAction private func selectLineButtonTapped(_ sender: Any) {
    didSelectLineButtonTapped?()
  }

  // MARK: - Internal Methods

  internal func setupCell(withViewModel viewModel: TableCellViewModelProtocol) {
    guard let lineViewModel = viewModel as? LineTableCellViewModel else { return }
    titleLabel?.text = lineViewModel.title.capitalizeFirst()
    lineImageView.image = lineViewModel.lineModel.lineImage
  }
}
