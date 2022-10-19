//
//  FontTableCell.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
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

  internal var didSelectBoldButtonTapped: ((Bool) -> Void)?
  internal var didSelectItalicButtonTapped: ((Bool) -> Void)?

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

  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    if #available(iOS 13.0, *), traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
      updateLayers()
    }
  }

  // MARK: - Action Methods

  @IBAction private func boldButtonTapped(_ sender: Any) {
    isBoldSelected.toggle()
    updateButtons()
    didSelectBoldButtonTapped?(isBoldSelected)
  }

  @IBAction private func italicButtonTapped(_ sender: Any) {
    isItalicSelected.toggle()
    updateButtons()
    didSelectItalicButtonTapped?(isItalicSelected)
  }

  // MARK: - Private Methods

  private func updateLayers() {
    updateButtons()
  }

  private func updateButtons() {
    let boldColor = isBoldSelected ? UIColor.mountainMeadowColor : UIColor.gainsboroColor
    let italicColor = isItalicSelected ? UIColor.mountainMeadowColor : UIColor.gainsboroColor
    boldButton?.layer.borderColor = boldColor.cgColor
    italicButton?.layer.borderColor = italicColor.cgColor
  }

  // MARK: - Internal Methods

  internal func setupCell(withViewModel viewModel: TableCellViewModelProtocol) {
    guard let fontViewModel = viewModel as? FontTableCellViewModel else { return }
    titleLabel?.text = fontViewModel.title.capitalizeFirst()
    isBoldSelected = fontViewModel.isBoldSelected
    isItalicSelected = fontViewModel.isItalicSelected
    updateButtons()
  }
}
