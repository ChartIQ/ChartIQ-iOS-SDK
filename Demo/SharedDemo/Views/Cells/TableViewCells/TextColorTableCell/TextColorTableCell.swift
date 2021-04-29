//
//  TextColorTableCell.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - TextColor TableCell

class TextColorTableCell: UITableViewCell {

  // MARK: - IBOutlets

  @IBOutlet private var titleLabel: UILabel!
  @IBOutlet private var textField: CustomTextField!
  @IBOutlet private var colorView: UIView!
  @IBOutlet private var selectColorButton: UIButton!

  // MARK: - Internal Properties

  internal var didTextFieldEndEditing: ((UITextField) -> Void)?
  internal var didSelectColorButtonTapped: (() -> Void)?

  // MARK: - View Lifecycle Methods

  override func awakeFromNib() {
    super.awakeFromNib()

    titleLabel?.textColor = .darkElectricBlueWhiteColor
    titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)

    backgroundColor = .whiteDarkGunmetalColor
    selectionStyle = .none

    colorView.layer.borderColor = UIColor.brightGreyYankeesBlueColor.cgColor
    colorView.layer.borderWidth = 1.0
    colorView.layer.cornerRadius = 2
    colorView.clipsToBounds = true

    textField.textColor = .cadetBlueColor
    textField.tintColor = .mountainMeadowColor
    textField.font = .systemFont(ofSize: 17, weight: .regular)
    textField.delegate = self
  }

  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    if #available(iOS 13.0, *), traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
      updateLayers()
    }
  }

  // MARK: - Action Methods

  @IBAction private func selectColorButtonTapped(_ sender: Any) {
    didSelectColorButtonTapped?()
  }

  // MARK: - Internal Methods

  internal func setupCell(withViewModel viewModel: TableCellViewModelProtocol) {
    titleLabel.text = viewModel.title.capitalizeFirst()
    if let colorCellViewModel = viewModel as? ColorTableCellViewModel {
      colorView.backgroundColor = colorCellViewModel.color
      textField.isHidden = true
    } else if let textColorCellViewModel = viewModel as? TextColorTableCellViewModel {
      colorView.backgroundColor = textColorCellViewModel.color
      textField.isHidden = false
      textField.text = String(textColorCellViewModel.number)
      textField.keyboardType = .numbersAndPunctuation
      textField.inputAccessoryView = UIView.doneAccessoryView(target: self, action: #selector(doneButtonTapped))
    }
  }

  // MARK: - Private Methods

  private func updateLayers() {
    colorView.layer.borderColor = UIColor.brightGreyYankeesBlueColor.cgColor
  }

  @objc private func doneButtonTapped() {
    textField.resignFirstResponder()
  }

  private func updateTextFieldText(_ textField: UITextField) {
    if textField.keyboardType == .numbersAndPunctuation {
      guard let textFieldText = textField.text else { return }
      textField.text = "\(Int(textFieldText) ?? 0)"
    }
  }
}

// MARK: - UITextFieldDelegate

extension TextColorTableCell: UITextFieldDelegate {

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
  }

  func textFieldDidEndEditing(_ textField: UITextField) {
    updateTextFieldText(textField)
    didTextFieldEndEditing?(textField)
  }

  func textField(_ textField: UITextField,
                 shouldChangeCharactersIn range: NSRange,
                 replacementString string: String) -> Bool {
    let cs = NSCharacterSet(charactersIn: Const.StudyDetail.negativeIntDigits).inverted
    let filtered = string.components(separatedBy: cs).joined()
    return (string == filtered)
  }
}
