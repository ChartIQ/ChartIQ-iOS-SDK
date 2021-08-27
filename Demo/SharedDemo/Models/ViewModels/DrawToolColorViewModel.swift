//
//  DrawToolColorViewModel.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - DrawToolColor ViewModel

class DrawToolColorViewModel: DrawToolViewModelProtocol {

  // MARK: - Internal Properties

  internal var type: DrawToolControlViewType
  internal var image: UIImage?
  internal var color: UIColor

  // MARK: - Init

  init(type: DrawToolControlViewType, image: UIImage?, color: UIColor) {
    self.type = type
    self.image = image
    self.color = color
  }
}
