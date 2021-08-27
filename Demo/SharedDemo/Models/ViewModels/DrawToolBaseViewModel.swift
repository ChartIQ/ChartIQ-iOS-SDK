//
//  DrawToolBaseViewModel.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - DrawToolBase ViewModel

class DrawToolBaseViewModel: DrawToolViewModelProtocol {

  // MARK: - Internal Properties

  internal var type: DrawToolControlViewType
  internal var image: UIImage?
  internal var line: LineModel?

  // MARK: - Init

  init(type: DrawToolControlViewType, image: UIImage?, line: LineModel? = nil) {
    self.type = type
    self.image = image
    self.line = line
  }
}
