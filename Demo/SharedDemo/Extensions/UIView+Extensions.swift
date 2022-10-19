//
//  UIView+Extensions.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - UIView Helpers Extensions

extension UIView {

  // MARK: - Internal Methods

  internal func adjustFrame(inView view: UIView) {
    frame = view.bounds
    view.addSubview(self)
  }

  internal func pinEdges(toView view: UIView) {
    translatesAutoresizingMaskIntoConstraints = false
    leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
    trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
    bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
  }
}

// MARK: - UIView LoadView Extension

extension UIView {

  // MARK: - Internal Methods

  internal static func loadFromNib<T>() -> T where T: UIView {
    let bundle = Bundle(for: self)
    let nib = UINib(nibName: "\(self)", bundle: bundle)
    guard let view = nib.instantiate(withOwner: nil, options: nil).first as? T else {
      fatalError("Could not load view from nib file.")
    }
    return view
  }
}

// MARK: - UIView UIActivityIndicatorView Extension

extension UIView {

  // MARK: - Private Properties

  private var activityIndicatorTag: Int { return 999_998 }

  // MARK: - Internal Methods

  internal func startActivityIndicator(style: UIActivityIndicatorView.Style = .whiteLarge,
                                       color: UIColor = .mountainMeadowColor) {
    stopActivityIndicator()
    DispatchQueue.main.async {
      self.isUserInteractionEnabled = false
      let activityIndicator = UIActivityIndicatorView(style: style)
      activityIndicator.tag = self.activityIndicatorTag
      activityIndicator.color = color
      activityIndicator.hidesWhenStopped = true
      activityIndicator.translatesAutoresizingMaskIntoConstraints = false
      self.addSubview(activityIndicator)
      self.addConstraint(
        NSLayoutConstraint(
          item: activityIndicator,
          attribute: .centerX,
          relatedBy: .equal,
          toItem: self,
          attribute: .centerX,
          multiplier: 1.0,
          constant: 0.0
        )
      )
      self.addConstraint(
        NSLayoutConstraint(
          item: activityIndicator,
          attribute: .centerY,
          relatedBy: .equal,
          toItem: self,
          attribute: .centerY,
          multiplier: 1.0,
          constant: 0.0
        )
      )
      activityIndicator.startAnimating()
    }
  }

  internal func stopActivityIndicator() {
    DispatchQueue.main.async {
      if let activityIndicator = self.subviews.first(where: { $0.tag == self.activityIndicatorTag })
        as? UIActivityIndicatorView {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
        self.isUserInteractionEnabled = true
      }
    }
  }
}

// MARK: - UIView InputAccessoryView Extension

extension UIView {

  // MARK: - Internal Methods

  internal static func doneAccessoryView(target: Any?, action: Selector?) -> UIView {
    let toolbar = UIToolbar()
    toolbar.barTintColor = .ghostWhiteСhineseBlackColor
    toolbar.isTranslucent = false
    let flexibleSpaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let doneButton = UIBarButtonItem(title: LocalizationManager.shared().localize(Const.General.doneTitle),
                                     style: .done,
                                     target: target,
                                     action: action)
    doneButton.tintColor = .mountainMeadowColor
    let font = UIFont.systemFont(ofSize: 15.0, weight: .semibold)
    doneButton.setTitleTextAttributes([.font: font], for: .normal)
    doneButton.setTitleTextAttributes([.font: font], for: .highlighted)
    toolbar.setItems([flexibleSpaceButton, doneButton], animated: false)
    toolbar.sizeToFit()
    return toolbar
  }
}

// MARK: - UIView Shadow Extension

extension UIView {

  func addShadow(radius: CGFloat = 5.0, opacity: Float = 0.7, width: CGFloat = 0.0, height: CGFloat = 5.0) {
    layer.masksToBounds = false
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = CGSize(width: width, height: height)
    layer.shadowRadius = radius
  }
}

// MARK: - UIView Animation Extension

extension UIView {

  func fadeInAnimation() {
    UIView.animate(withDuration: 0.5, animations: {
      self.alpha = 1
    })
  }

  func fadeOutAnimation() {
    UIView.animate(withDuration: 0.5, animations: {
      self.alpha = 0
    })
  }
}

// MARK: - UIView Ultra Thin Line Extension

public extension UIView {

  func dynamicMinimumLineWidth(ultra: Bool) -> CGFloat {
    let currentAppScale: CGFloat = UIScreen.main.scale
    let baseMinimumLineWidth: CGFloat = 0.5
    let minimumLineWidth: CGFloat = 1.0
    let ultraMinimumLineWidth: CGFloat = minimumLineWidth / currentAppScale
    return ultra ? ultraMinimumLineWidth : baseMinimumLineWidth
  }
}
