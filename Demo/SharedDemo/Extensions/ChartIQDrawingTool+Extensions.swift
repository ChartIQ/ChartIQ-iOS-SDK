//
//  ChartIQDrawingTool+Extensions.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - ChartIQDrawingTool Image Extensions

extension ChartIQDrawingTool {

  // MARK: - Internal Properties

  internal var toolImage: UIImage? {
    switch self {
    case .annotation:
      return UIImage.ChartIQDrawingTool.annotationImage
    case .arrow:
      return UIImage.ChartIQDrawingTool.arrowImage
    case .average:
      return UIImage.ChartIQDrawingTool.averageImage
    case .callout:
      return UIImage.ChartIQDrawingTool.calloutImage
    case .channel:
      return UIImage.ChartIQDrawingTool.channelImage
    case .check:
      return UIImage.ChartIQDrawingTool.checkImage
    case .continuous:
      return UIImage.ChartIQDrawingTool.continuousImage
    case .cross:
      return UIImage.ChartIQDrawingTool.crossImage
    case .crossline:
      return UIImage.ChartIQDrawingTool.crosslineImage
    case .doodle:
      return UIImage.ChartIQDrawingTool.doodleImage
    case .elliottWave:
      return UIImage.ChartIQDrawingTool.elliottWaveImage
    case .ellipse:
      return UIImage.ChartIQDrawingTool.ellipseImage
    case .fibArc:
      return UIImage.ChartIQDrawingTool.fibArcImage
    case .fibFan:
      return UIImage.ChartIQDrawingTool.fibFanImage
    case .fibProjection:
      return UIImage.ChartIQDrawingTool.fibProjectionImage
    case .fibRetracement:
      return UIImage.ChartIQDrawingTool.fibRetracementImage
    case .fibTimeZone:
      return UIImage.ChartIQDrawingTool.fibTimeZoneImage
    case .focus:
      return UIImage.ChartIQDrawingTool.focusImage
    case .gannFan:
      return UIImage.ChartIQDrawingTool.gannFanImage
    case .gartley:
      return UIImage.ChartIQDrawingTool.gartleyImage
    case .heart:
      return UIImage.ChartIQDrawingTool.heartImage
    case .horizontal:
      return UIImage.ChartIQDrawingTool.horizontalImage
    case .line:
      return UIImage.ChartIQDrawingTool.lineImage
    case .pitchfork:
      return UIImage.ChartIQDrawingTool.pitchforkImage
    case .quadrantLines:
      return UIImage.ChartIQDrawingTool.quadrantLinesImage
    case .ray:
      return UIImage.ChartIQDrawingTool.rayImage
    case .rectangle:
      return UIImage.ChartIQDrawingTool.rectangleImage
    case .regression:
      return UIImage.ChartIQDrawingTool.regressionImage
    case .segment:
      return UIImage.ChartIQDrawingTool.segmentImage
    case .speedResistanceArc:
      return UIImage.ChartIQDrawingTool.speedResistanceArcImage
    case .speedResistanceLine:
      return UIImage.ChartIQDrawingTool.speedResistanceLineImage
    case .star:
      return UIImage.ChartIQDrawingTool.starImage
    case .timeCycle:
      return UIImage.ChartIQDrawingTool.timeCycleImage
    case .tironeLevels:
      return UIImage.ChartIQDrawingTool.tironeLevelsImage
    case .trend:
      return UIImage.ChartIQDrawingTool.trendImage
    case .vertical:
      return UIImage.ChartIQDrawingTool.verticalImage
    case .noTool:
      return UIImage.ChartIQDrawingTool.noToolImage
    case .measure:
      return UIImage.ChartIQDrawingTool.measureImage
    }
  }
}
