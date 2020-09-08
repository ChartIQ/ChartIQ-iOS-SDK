//
//  TextTableCell.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - Text TableCell

class TextTableCell: UITableViewCell {

  // MARK: - IBOutlets

  @IBOutlet private var titleLabel: UILabel!
  @IBOutlet private var textField: CustomTextField!

  // MARK: - Internal Properties

  internal var didTextFieldEndEditing: ((UITextField) -> Void)?

  // MARK: - View Lifecycle Methods

  override func awakeFromNib() {
    super.awakeFromNib()

    titleLabel?.textColor = .darkElectricBlueWhiteColor
    titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)

    backgroundColor = .whiteDarkGunmetalColor
    selectionStyle = .none

    textField.textColor = .cadetBlueColor
    textField.tintColor = .mountainMeadowColor
    textField.font = .systemFont(ofSize: 17, weight: .regular)

    textField.delegate = self
  }

  // MARK: - Internal Methods

  internal func setupCell(withViewModel viewModel: TableCellViewModelProtocol) {
    titleLabel.text = viewModel.title.capitalizeFirst()
    if let textCellViewModel = viewModel as? TextTableCellViewModel {
      textField.text = textCellViewModel.text
      textField.keyboardType = .default
      textField.inputAccessoryView = nil
    } else if let textColorCellViewModel = viewModel as? NumberTableCellViewModel {
      textField.text = String(textColorCellViewModel.number)
      textField.keyboardType = .decimalPad
      textField.inputAccessoryView = UIView.doneAccessoryView(target: self, action: #selector(doneButtonTapped))
    }
  }

  // MARK: - Private Methods

  @objc private func doneButtonTapped() {
    textField.resignFirstResponder()
  }

  private func updateTextFieldText(_ textField: UITextField) {
    if textField.keyboardType == .decimalPad {
      guard let textFieldText = textField.text else { return }
      let text = textFieldText.replace(Const.General.commaSymbol, with: Const.General.dotSymbol)
      textField.text = "\(Double(text) ?? 0.0)"
    }
  }
}

// MARK: - UITextFieldDelegate

extension TextTableCell: UITextFieldDelegate {

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
    guard textField.keyboardType == .decimalPad else { return true }
    let cs = NSCharacterSet(charactersIn: Const.StudyDetail.doubleAcceptableCharacters).inverted
    let filtered = string.components(separatedBy: cs).joined()
    return (string == filtered)
  }
}
