//
//  TextViewTableCell.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - TextView TableCell

class TextViewTableCell: UITableViewCell {

  // MARK: - IBOutlets

  @IBOutlet private var titleLabel: UILabel!
  @IBOutlet private var textView: UITextView!

  // MARK: - Internal Properties

  internal var didTextViewBeginEditing: ((String) -> Void)?
  internal var didTextViewEndEditing: ((String) -> Void)?

  // MARK: - Private Properties

  private var placeholder: String?

  // MARK: - View Lifecycle Methods

  override func awakeFromNib() {
    super.awakeFromNib()

    titleLabel?.textColor = .darkElectricBlueWhiteColor
    titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)

    backgroundColor = .whiteDarkGunmetalColor
    selectionStyle = .none

    textView.backgroundColor = .clear
    textView.textColor = .cadetBlueColor
    textView.tintColor = .mountainMeadowColor
    textView.font = .systemFont(ofSize: 17, weight: .regular)
    textView.textContainer.lineFragmentPadding = 0
    textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    textView.delegate = self
  }

  // MARK: - Internal Methods

  internal func setupCell(withViewModel viewModel: TableCellViewModelProtocol) {
    titleLabel.text = viewModel.title.capitalizeFirst()
    if let textViewViewModel = viewModel as? TextViewTableCellViewModel {
      textView.keyboardType = .default
      if let text = textViewViewModel.text, !text.isEmpty {
        updateTitle(text: text)
      } else {
        placeholder = textViewViewModel.placeholder
        updatePlaceholder()
      }
    }
  }

  // MARK: - Private Methods

  @objc private func doneButtonTapped() {
    textView.resignFirstResponder()
  }

  private func updatePlaceholder() {
    textView.text = placeholder
    textView.textColor = .arsenicBrightGrayMediumColor.withAlphaComponent(0.3)
  }

  private func updateTitle(text: String = "") {
    textView.text = text
    textView.textColor = .cadetBlueColor
  }
}

// MARK: - UITextFieldDelegate

extension TextViewTableCell: UITextViewDelegate {

  func textViewDidEndEditing(_ textView: UITextView) {
    var text = ""
    if textView.text.isEmpty {
      updatePlaceholder()
    } else if textView.text != placeholder {
      text = textView.text
    }
    didTextViewEndEditing?(text)
  }

  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.text == placeholder {
      updateTitle()
    }
    didTextViewBeginEditing?(textView.text)
  }

  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    if text == Const.General.newLineSymbol {
      textView.resignFirstResponder()
      return false
    }
    return true
  }
}
