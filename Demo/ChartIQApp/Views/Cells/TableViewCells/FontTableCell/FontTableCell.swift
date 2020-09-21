//
//  FontTableCell.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - Font TableCell

class FontTableCell: UITableViewCell {

  // MARK: - IBOutlets

  @IBOutlet private var titleLabel: UILabel!
  @IBOutlet private var boldButton: UIButton!
  @IBOutlet private var italicButton: UIButton!

  // MARK: - Internal Properties

  internal var didSelectBoldButtonTapped: (() -> Void)?
  internal var didSelectItalicButtonTapped: (() -> Void)?

  // MARK: - Private Properties

  private var isBoldSelected = false
  private var isItalicSelected = false

  // MARK: - View Lifecycle Methods

  override func awakeFromNib() {
    super.awakeFromNib()

    titleLabel?.textColor = .darkElectricBlueWhiteColor
    titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)

    [boldButton, italicButton].forEach { button in
      button?.layer.cornerRadius = 3
      button?.layer.borderColor = UIColor.gainsboroColor.cgColor
      button?.layer.borderWidth = 1.0
      button?.clipsToBounds = true
    }

    backgroundColor = .whiteDarkGunmetalColor
    selectionStyle = .none
  }

  // MARK: - Action Methods

  @IBAction private func boldButtonTapped(_ sender: Any) {
    isBoldSelected.toggle()
    updateButtons()
    didSelectBoldButtonTapped?()
  }

  @IBAction private func italicButtonTapped(_ sender: Any) {
    isItalicSelected.toggle()
    updateButtons()
    didSelectItalicButtonTapped?()
  }

  // MARK: - Private Methods

  private func updateButtons() {
    let boldColor = isBoldSelected ? UIColor.mountainMeadowColor : UIColor.gainsboroColor
    let italicColor = isItalicSelected ? UIColor.mountainMeadowColor : UIColor.gainsboroColor
    boldButton?.layer.borderColor = boldColor.cgColor
    italicButton?.layer.borderColor = italicColor.cgColor
  }

  // MARK: - Internal Methods

  internal func setupCell(withViewModel viewModel: TableCellViewModelProtocol) {
    guard let fontCellViewModel = viewModel as? FontTableCellViewModel else { return }
    titleLabel?.text = fontCellViewModel.title.capitalizeFirst()
    isBoldSelected = fontCellViewModel.isBoldSelected
    isItalicSelected = fontCellViewModel.isItalicSelected
    updateButtons()
  }
}
