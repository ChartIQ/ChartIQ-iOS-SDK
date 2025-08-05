//
//  UIImage+Extensions.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - UIImage Extensions

extension UIImage {

  // MARK: - ChartIQ Demo Extension Images

  // MARK: - TabBarController Images

  struct TabBar {
    internal static let chartItemImage = UIImage(named: "tabBarChartIcon")
    internal static let settingsItemImage = UIImage(named: "tabBarSettingsIcon")
    internal static let studiesItemImage = UIImage(named: "tabBarStudiesIcon")
  }

  // MARK: - ChartViewController Images

  struct Chart {
    internal static let seriesImage = UIImage(named: "iconSeries")
    internal static let signalsImage = UIImage(named: "iconSignals")
    internal static let studiesImage = UIImage(named: "iconStudies")
    internal static let settingsImage = UIImage(named: "iconSettings")

    internal static let crosshairActiveImage = UIImage(named: "iconTargetActive")
    internal static let crosshairInactiveImage = UIImage(named: "iconTargetInactive")

    internal static let drawToolActiveImage = UIImage(named: "iconDrawActive")
    internal static let drawToolInactiveImage = UIImage(named: "iconDrawInactive")

    internal static let fullViewActiveImage = UIImage(named: "iconFullViewActive")
    internal static let fullViewInactiveImage = UIImage(named: "iconFullViewInactive")

    internal static let moreActiveImage = UIImage(named: "iconMoreActive")
    internal static let moreInactiveImage = UIImage(named: "iconMoreInactive")
  }

  // MARK: - DrawToolsViewController Images

  struct DrawTools {
    internal static let moreOptionsImage = UIImage(named: "moreOptionsIcon")
  }

  // MARK: - StudiesViewController Images

  struct Studies {
    internal static let emptyStateImage = UIImage(named: "studiesEmptyStateIcon")
  }

  // MARK: - ColorPickerCollectionCell Images

  struct ColorPickerCollectionCell {
    internal static let checkmarkImage = UIImage(named: "colorPickerCheckmark")
  }

  // MARK: - DrawToolControlView Images

  struct DrawToolControlView {
    internal static let fillColorImage = UIImage(named: "drawToolFillColorIcon")
    internal static let lineColorImage = UIImage(named: "drawToolLineColorIcon")
    internal static let cloneImage = UIImage(named: "drawToolCloneIcon")
    internal static let deleteImage = UIImage(named: "drawToolDeleteIcon")
    internal static let magnetImage = UIImage(named: "drawToolMagnetIcon")
    internal static let manageLayersImage = UIImage(named: "drawToolManageLayersIcon")
    internal static let settingsImage = UIImage(named: "drawToolSettingsIcon")
  }

  // MARK: - FloatingButton Images

  struct FloatingButton {
    internal static let downArrowImage = UIImage(named: "helperDownArrow")
    internal static let leftArrowImage = UIImage(named: "helperLeftArrow")
  }

  // MARK: - ChartIQ SDK Extension Images

  // MARK: - ChartIQLineType Images

  struct ChartIQLineType {
    internal static let solidLineWidth1Image = UIImage(named: "iconSolidLineWidth1")
    internal static let solidLineWidth2Image = UIImage(named: "iconSolidLineWidth2")
    internal static let solidLineWidth3Image = UIImage(named: "iconSolidLineWidth3")

    internal static let dottedLineWidth1Image = UIImage(named: "iconDottedLineWidth1")
    internal static let dottedLineWidth2Image = UIImage(named: "iconDottedLineWidth2")

    internal static let dashedLineWidth1Image = UIImage(named: "iconDashedLineWidth1")
    internal static let dashedLineWidth2Image = UIImage(named: "iconDashedLineWidth2")
  }

  // MARK: - ChartIQDrawingTool Images

  struct ChartIQDrawingTool {
    internal static let noToolImage = UIImage(named: "drawingToolNoToolIcon")
    internal static let measureImage = UIImage(named: "drawingToolMeasureIcon")
    internal static let annotationImage = UIImage(named: "drawingToolAnnotationIcon")
    internal static let arrowImage = UIImage(named: "drawingToolArrowIcon")
    internal static let averageImage = UIImage(named: "drawingToolAverageLineIcon")
    internal static let calloutImage = UIImage(named: "drawingToolCalloutIcon")
    internal static let channelImage = UIImage(named: "drawingToolChannelIcon")
    internal static let continuousImage = UIImage(named: "drawingToolContinuousLineIcon")
    internal static let crosslineImage = UIImage(named: "drawingToolCrosslineIcon")
    internal static let doodleImage = UIImage(named: "drawingToolDoodleIcon")
    internal static let elliottWaveImage = UIImage(named: "drawingToolElliottWaveIcon")
    internal static let ellipseImage = UIImage(named: "drawingToolElipseIcon")
    internal static let fibArcImage = UIImage(named: "drawingToolFibArcIcon")
    internal static let fibFanImage = UIImage(named: "drawingToolFibFanIcon")
    internal static let fibProjectionImage = UIImage(named: "drawingToolFibProjectionIcon")
    internal static let fibRetracementImage = UIImage(named: "drawingToolFibRetracementIcon")
    internal static let fibTimeZoneImage = UIImage(named: "drawingToolFibTimeZoneIcon")
    internal static let gannFanImage = UIImage(named: "drawingToolGannFanIcon")
    internal static let gartleyImage = UIImage(named: "drawingToolGartleyIcon")
    internal static let horizontalImage = UIImage(named: "drawingToolHorizontalLineIcon")
    internal static let lineImage = UIImage(named: "drawingToolLineIcon")
    internal static let measurementLineImage = UIImage(named: "drawingToolMeasurementLineIcon")
    internal static let pitchforkImage = UIImage(named: "drawingToolPitchforkIcon")
    internal static let quadrantLinesImage = UIImage(named: "drawingToolQuadrantLinesIcon")
    internal static let rayImage = UIImage(named: "drawingToolRayIcon")
    internal static let rectangleImage = UIImage(named: "drawingToolRectangleIcon")
    internal static let regressionImage = UIImage(named: "drawingToolRegressionLineIcon")
    internal static let speedResistanceArcImage = UIImage(named: "drawingToolSpeedResistanceArcIcon")
    internal static let speedResistanceLineImage = UIImage(named: "drawingToolSpeedResistanceLineIcon")
    internal static let timeCycleImage = UIImage(named: "drawingToolTimeCycleIcon")
    internal static let tironeLevelsImage = UIImage(named: "drawingToolTironeLevelsIcon")
    internal static let trendImage = UIImage(named: "drawingToolTrendLineIcon")
    internal static let verticalImage = UIImage(named: "drawingToolVerticallineIcon")
    internal static let volumeProfileImage = UIImage(named: "drawingToolVolumeProfileIcon")
  }

  // MARK: - ChartIQChartType Images

  struct ChartIQChartType {
    internal static let candleImage = UIImage(named: "chartStyleCandlesIcon")
    internal static let barImage = UIImage(named: "chartStyleBarIcon")
    internal static let coloredBarImage = UIImage(named: "chartStyleColoredBarIcon")
    internal static let lineImage = UIImage(named: "chartStyleLineIcon")
    internal static let vertexLineImage = UIImage(named: "chartStyleVertexLineIcon")
    internal static let stepImage = UIImage(named: "chartStyleStepIcon")
    internal static let mountainImage = UIImage(named: "chartStyleMountainIcon")
    internal static let baselineImage = UIImage(named: "chartStyleBaselineIcon")
    internal static let hollowCandleImage = UIImage(named: "chartStyleHollowCandleIcon")
    internal static let volumeCandleImage = UIImage(named: "chartStyleVolumeCandleIcon")
    internal static let coloredHLCBarImage = UIImage(named: "chartStyleColoredHLCBarIcon")
    internal static let scatterplotImage = UIImage(named: "chartStyleScatterplotIcon")
    internal static let histogramImage = UIImage(named: "chartStyleHistogramIcon")
  }

  // MARK: - ChartIQChartAggregationType Images

  struct ChartIQChartAggregationType {
    internal static let heikinashiImage = UIImage(named: "chartStyleHeikinAshiIcon")
    internal static let kagiImage = UIImage(named: "chartStyleKagiIcon")
    internal static let linebreakImage = UIImage(named: "chartStyleLineBreakIcon")
    internal static let renkoImage = UIImage(named: "chartStyleRenkoIcon")
    internal static let rangebarsImage = UIImage(named: "chartStyleRangeBarIcon")
    internal static let pandfImage = UIImage(named: "chartStylePointAndFigureIcon")
  }
}
