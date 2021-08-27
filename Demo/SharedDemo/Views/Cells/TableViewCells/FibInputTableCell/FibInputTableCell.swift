//
//  FibInputTableCell.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - FibInput TableCell

class FibInputTableCell: UITableViewCell {

  // MARK: - IBOutlets

  @IBOutlet private var textField: UITextField!
  @IBOutlet private var addButton: UIButton!

  // MARK: - Internal Properties

  internal var didSelectAddButtonTapped: ((String) -> Void)?

  // MARK: - Private Properties

  private let locManager = LocalizationManager.shared()
  private var isAllowNegative: Bool = false

  // MARK: - View Lifecycle Methods

  override func awakeFromNib() {
    super.awakeFromNib()

    backgroundColor = .whiteDarkGunmetalColor
    selectionStyle = .none

    textField.textColor = .darkElectricBlueWhiteColor
    textField.tintColor = .mountainMeadowColor
    textField.font = .systemFont(ofSize: 17, weight: .regular)
    textField.keyboardType = .numbersAndPunctuation
    textField.inputAccessoryView = UIView.doneAccessoryView(target: self, action: #selector(doneButtonTapped))
    textField.delegate = self

    addButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
    addButton.setTitleColor(.white, for: .normal)
    addButton.backgroundColor = .mountainMeadowColor
  }

  // MARK: - Action Methods

  @IBAction private func addButtonTapped(_ sender: Any) {
    textField.resignFirstResponder()
    guard let text = textField.text, !text.isEmpty, Double(text) != nil else { return }
    didSelectAddButtonTapped?(text)
  }

  @objc private func doneButtonTapped() {
    textField.resignFirstResponder()
  }

  // MARK: - Internal Methods

  internal func setupCell(withViewModel viewModel: FibInputTableCellViewModel) {
    isAllowNegative = viewModel.isAllowNegative
    textField.text = viewModel.title
    textField.placeholder = viewModel.placeholder
    addButton.setTitle(viewModel.buttonTitle, for: .normal)
  }

  // MARK: - Private Methods

  private func updateTextFieldText(_ textField: UITextField) {
    if textField.keyboardType == .numbersAndPunctuation {
      guard let textFieldText = textField.text, !textFieldText.isEmpty else { return }
      let text = textFieldText.replace(Const.General.commaSymbol, with: Const.General.dotSymbol)
      textField.text = "\(Double(text) ?? 0.0)"
    }
  }
}

// MARK: - UITextFieldDelegate

extension FibInputTableCell: UITextFieldDelegate {

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
  }

  func textFieldDidEndEditing(_ textField: UITextField) {
    updateTextFieldText(textField)
  }

  func textField(_ textField: UITextField,
                 shouldChangeCharactersIn range: NSRange,
                 replacementString string: String) -> Bool {
    guard textField.keyboardType == .numbersAndPunctuation else { return true }
    let charactersSet = isAllowNegative ? Const.StudyDetail.negativeDoubleDigits : Const.StudyDetail.doubleDigits
    let cs = NSCharacterSet(charactersIn: charactersSet).inverted
    let filtered = string.components(separatedBy: cs).joined()
    return (string == filtered)
  }
}
