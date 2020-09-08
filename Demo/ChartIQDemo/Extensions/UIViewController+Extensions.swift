//
//  UIViewController+Extensions.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

extension UIViewController {

  // MARK: - Internal Methods

  internal func showActionSheet(title: String? = nil,
                                message: String? = nil,
                                withCancelAction: Bool = true,
                                sourceView: UIView,
                                actions: [UIAlertAction]) {
    let actionSheetAlertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
    if let presenter = actionSheetAlertController.popoverPresentationController {
      presenter.sourceView = sourceView
      presenter.sourceRect = sourceView.bounds
    }
    if withCancelAction {
      let title = LocalizationManager.shared().localize(Const.General.cancelTitle)
      actionSheetAlertController.addAction(UIAlertAction(title: title, style: .cancel, handler: nil))
    }
    actions.forEach { action in actionSheetAlertController.addAction(action) }
    present(actionSheetAlertController, animated: true, completion: nil)
  }

  internal func showAlert(title: String? = nil,
                          message: String? = nil,
                          withCancelAction: Bool = true,
                          actions: [UIAlertAction]) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    if withCancelAction {
      let title = LocalizationManager.shared().localize(Const.General.cancelTitle)
      alertController.addAction(UIAlertAction(title: title, style: .cancel, handler: nil))
    }
    actions.forEach { action in alertController.addAction(action) }
    present(alertController, animated: true, completion: nil)
  }

  internal func addKeyboardObservers(selector aSelector: Selector) {
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(self,
                                   selector: aSelector,
                                   name: UIResponder.keyboardWillHideNotification,
                                   object: nil)
    notificationCenter.addObserver(self,
                                   selector: aSelector,
                                   name: UIResponder.keyboardWillChangeFrameNotification,
                                   object: nil)
  }
}
