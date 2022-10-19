//
//  TextTableCell.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
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
    if let textViewModel = viewModel as? TextTableCellViewModel {
      textField.text = textViewModel.text
      textField.keyboardType = .default
      textField.inputAccessoryView = nil
      if let placeholder = textViewModel.placeholder {
        textField.placeholder = placeholder
      }
    } else if let numberViewModel = viewModel as? NumberTableCellViewModel {
      if numberViewModel.shouldDisplayAsInt {
        textField.text = String(Int(numberViewModel.number))
        textField.keyboardType = .numberPad
      } else {
        textField.text = String(numberViewModel.number)
        textField.keyboardType = numberViewModel.shouldAllowNegative ? .numbersAndPunctuation : .decimalPad
      }
      textField.inputAccessoryView = UIView.doneAccessoryView(target: self, action: #selector(doneButtonTapped))
    }
  }

  // MARK: - Private Methods

  @objc private func doneButtonTapped() {
    textField.resignFirstResponder()
  }

  private func updateTextFieldText(_ textField: UITextField) {
    if textField.keyboardType == .numberPad {
      guard let textFieldText = textField.text else { return }
      textField.text = "\(Int(textFieldText) ?? 0)"
    } else if textField.keyboardType == .decimalPad || textField.keyboardType == .numbersAndPunctuation {
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
    if textField.keyboardType == .decimalPad {
      let cs = NSCharacterSet(charactersIn: Const.StudyDetail.doubleDigits).inverted
      let filtered = string.components(separatedBy: cs).joined()
      return (string == filtered)
    } else if textField.keyboardType == .numbersAndPunctuation {
      let cs = NSCharacterSet(charactersIn: Const.StudyDetail.negativeDoubleDigits).inverted
      let filtered = string.components(separatedBy: cs).joined()
      return (string == filtered)
    }
    return true
  }
}
