//
//  NavigationView.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - Navigation View

class NavigationView: UIView {

  // MARK: - IBOutlets

  @IBOutlet private var stackView: UIStackView!
  @IBOutlet private var separatorView: UIView!

  // MARK: - Internal Properties

  internal var buttons: [UIButton] = [] {
    willSet {
      stackView.removeAllArrangedSubviews()
      stackView.addSpacerView()
      newValue.reversed().forEach { button in
        stackView.addArrangedSubview(button)
      }
    }
  }

  // MARK: - Private Properties

  // MARK: - View Lifecycle Methods

  static func instantiate() -> NavigationView {
    let view: NavigationView = NavigationView.loadFromNib()
    return view
  }

  override func awakeFromNib() {
    super.awakeFromNib()

    backgroundColor = .ghostWhiteСhineseBlackColor

    separatorView.alpha = 0.7
    separatorView.backgroundColor = .lightGrayOuterSpaceColor
  }
}
