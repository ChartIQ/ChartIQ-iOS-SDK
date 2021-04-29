//
//  ChartIQLineType+Extensions.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - ChartIQLineType Image Extensions

extension ChartIQLineType {

  // MARK: - Internal Methods

  internal func lineImage(forLineWidth lineWidth: Int) -> UIImage? {
    switch self {
    case .solid:
      switch lineWidth {
      case 2:
        return UIImage.ChartIQLineType.solidLineWidth2Image
      case 3:
        return UIImage.ChartIQLineType.solidLineWidth3Image
      default:
        return UIImage.ChartIQLineType.solidLineWidth1Image
      }
    case .dotted:
      switch lineWidth {
      case 2:
        return UIImage.ChartIQLineType.dottedLineWidth2Image
      default:
        return UIImage.ChartIQLineType.dottedLineWidth1Image
      }
    case .dashed:
      switch lineWidth {
      case 2:
        return UIImage.ChartIQLineType.dashedLineWidth2Image
      default:
        return UIImage.ChartIQLineType.dashedLineWidth1Image
      }
    }
  }
}
