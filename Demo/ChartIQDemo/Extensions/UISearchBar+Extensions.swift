//
//  UISearchBar+Extensions.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - UISearchBar Extension

extension UISearchBar {

  // MARK: - Internal Methods

  internal func defaultConfiguration() {
    setValue(LocalizationManager.shared().localize(Const.General.cancelTitle),
             forKey: Const.SearchBar.searchCancelButtonTitleKey)
    searchBarStyle = .minimal
    placeholder = LocalizationManager.shared().localize(Const.SearchBar.searchTitle)
    tintColor = .mountainMeadowColor
    isTranslucent = true
    barTintColor = .ghostWhiteСhineseBlackColor
    backgroundColor = .ghostWhiteСhineseBlackColor
  }
}
