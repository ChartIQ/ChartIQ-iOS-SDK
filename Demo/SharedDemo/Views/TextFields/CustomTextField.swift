//
//  CustomTextField.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

class CustomTextField: UITextField {

  // MARK: - View Lifecycle Methods

  override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    return false
  }
}
