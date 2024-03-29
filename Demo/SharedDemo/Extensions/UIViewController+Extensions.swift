//
//  UIViewController+Extensions.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - UIViewController Extensions

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
}

protocol UIViewControllerKeyboardProtocol: AnyObject {

  var scrollView: UIScrollView! { get }

  func addKeyboardObservers()
}

extension UIViewControllerKeyboardProtocol where Self: UIViewController {

  func addKeyboardObservers() {
    let adjustForKeyboardHandler: (Notification) -> Void = { [weak self] notification in
      guard let self = self else { return }
      guard let keyboard = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
      let keyboardScreenEndFrame = keyboard.cgRectValue
      let keyboardViewEndFrame = self.view.convert(keyboardScreenEndFrame, from: self.view.window)
      if notification.name == UIResponder.keyboardWillHideNotification {
        self.scrollView.contentInset = .zero
      } else {
        var bottomHeight = keyboardViewEndFrame.height
        if #available(iOS 11.0, *) {
          bottomHeight -= self.view.safeAreaInsets.bottom
        }
        self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottomHeight, right: 0)
      }
      self.scrollView.scrollIndicatorInsets = self.scrollView.contentInset
    }

    let notificationCenter = NotificationCenter.default
    _ = notificationCenter.addObserver(forName: UIResponder.keyboardWillHideNotification,
                                       object: nil,
                                       queue: .main,
                                       using: adjustForKeyboardHandler)

    _ = notificationCenter.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification,
                                       object: nil,
                                       queue: .main,
                                       using: adjustForKeyboardHandler)
  }
}

extension UIViewController {

  internal var isUserInterfaceStyleDark: Bool {
    if #available(iOS 12.0, *), traitCollection.userInterfaceStyle == .dark {
      return true
    } else {
      return false
    }
  }

  internal var isPresentedModally: Bool {
    if let index = navigationController?.viewControllers.firstIndex(of: self), index > 0 {
      return false
    } else if presentingViewController != nil {
      return true
    } else if navigationController?.presentingViewController?.presentedViewController == navigationController {
      return true
    } else if tabBarController?.presentingViewController is UITabBarController {
      return true
    } else {
      return false
    }
  }

  internal func closeScreen() {
    if isPresentedModally {
      dismiss(animated: true)
    } else {
      navigationController?.popViewController(animated: true)
    }
  }
}
