//
//  CustomSearchController.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - CustomSearchController with CustomSearchBar
/// Needs to resolve native issue with not hiding cancel button on different iOS versions.

class CustomSearchBar: UISearchBar {

  override func setShowsCancelButton(_ showsCancelButton: Bool, animated: Bool) {
    super.setShowsCancelButton(false, animated: false)
  }
}

class CustomSearchController: UISearchController, UISearchBarDelegate {

  lazy var customSearchBar: CustomSearchBar = {
    let customSearchBar = CustomSearchBar(frame: CGRect.zero)
    return customSearchBar
  }()

  override var searchBar: UISearchBar {
    return customSearchBar
  }
}
