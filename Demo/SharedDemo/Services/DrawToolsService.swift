//
//  DrawToolsService.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - DrawTools Service

class DrawToolsService {

  // MARK: - Private Properties

  private let chartIQDrawingManager = ChartIQDrawingManager()
  private var isDarkTheme: Bool = false

  // MARK: - Internal Methods
  // MARK: - DrawTools Collection ViewModels Methods

  internal func getDrawToolCollectionViewModels(from chartIQView: ChartIQView,
                                                isDarkTheme: Bool) -> [DrawToolViewModelProtocol] {
    self.isDarkTheme = isDarkTheme
    var drawToolViewModels: [DrawToolViewModelProtocol] = []
    guard let tool = chartIQView.getCurrentDrawTool(),
          let parameters = chartIQView.getDrawingParameters(tool) else { return drawToolViewModels }

    let selectedToolViewModel = DrawToolBaseViewModel(type: .selectedTool, image: tool.toolImage)
    drawToolViewModels.append(selectedToolViewModel)

    if chartIQDrawingManager.isSupportingFillColor(tool) {
      let fillColor = UIColor.getDynamicColor(from: parameters,
                                              colorKey: ChartIQConst.DrawingTool.fillColorKey,
                                              isDarkTheme: isDarkTheme)
      let fillColorViewModel = DrawToolColorViewModel(type: .fillColor,
                                                      image: UIImage.DrawToolControlView.fillColorImage,
                                                      color: fillColor)
      drawToolViewModels.append(fillColorViewModel)
    }

    if chartIQDrawingManager.isSupportingLineColor(tool) {
      let lineColor = UIColor.getDynamicColor(from: parameters,
                                              colorKey: ChartIQConst.DrawingTool.lineColorKey,
                                              isDarkTheme: isDarkTheme)
      let lineColorViewModel = DrawToolColorViewModel(type: .lineColor,
                                                      image: UIImage.DrawToolControlView.lineColorImage,
                                                      color: lineColor)
      drawToolViewModels.append(lineColorViewModel)
    }

    if chartIQDrawingManager.isSupportingLineType(tool),
       let lineTypeName = parameters[ChartIQConst.DrawingTool.patternKey] as? String,
       let lineWidth = parameters[ChartIQConst.DrawingTool.lineWidthKey] as? Int,
       let lineType = ChartIQLineType(stringValue: lineTypeName) {
      let selectedLineModel = LineModel(lineType: lineType, lineWidth: lineWidth)
      let lineViewModel = DrawToolBaseViewModel(type: .lineType,
                                                image: selectedLineModel.lineImage,
                                                line: selectedLineModel)
      drawToolViewModels.append(lineViewModel)
    }

    if chartIQDrawingManager.isSupportingSettings(tool) {
      let settingsToolViewModel = DrawToolBaseViewModel(type: .settings,
                                                        image: UIImage.DrawToolControlView.settingsImage)
      drawToolViewModels.append(settingsToolViewModel)
    }

    return drawToolViewModels
  }

  // MARK: - DrawTools Table ViewModels Methods

  internal func getDrawToolTableViewModels(from chartIQView: ChartIQView,
                                           isDarkTheme: Bool) -> [TableCellViewModelProtocol] {
    self.isDarkTheme = isDarkTheme
    var drawToolViewModels: [TableCellViewModelProtocol] = []
    guard let tool = chartIQView.getCurrentDrawTool(),
          let parameters = chartIQView.getDrawingParameters(tool) else { return drawToolViewModels }

    let fillColorViewModels = getFillColorViewModels(tool: tool, parameters: parameters)
    drawToolViewModels.append(contentsOf: fillColorViewModels)

    let lineColorViewModels = getLineColorViewModels(tool: tool, parameters: parameters)
    drawToolViewModels.append(contentsOf: lineColorViewModels)

    let lineTypeViewModels = getLineTypeViewModels(tool: tool, parameters: parameters)
    drawToolViewModels.append(contentsOf: lineTypeViewModels)

    let fontViewModels = getFontViewModels(tool: tool, parameters: parameters)
    drawToolViewModels.append(contentsOf: fontViewModels)

    let axisLabelViewModels = getAxisLabelViewModels(tool: tool, parameters: parameters)
    drawToolViewModels.append(contentsOf: axisLabelViewModels)

    let showCalloutViewModels = getShowCalloutViewModels(tool: tool, parameters: parameters)
    drawToolViewModels.append(contentsOf: showCalloutViewModels)

    let deviationViewModels = getDeviationViewModels(tool: tool, parameters: parameters)
    drawToolViewModels.append(contentsOf: deviationViewModels)

    let fibonacciViewModels = getFibonacciViewModels(tool: tool, parameters: parameters)
    drawToolViewModels.append(contentsOf: fibonacciViewModels)

    let elliottWaveViewModels = getElliottWaveViewModels(tool: tool, parameters: parameters)
    drawToolViewModels.append(contentsOf: elliottWaveViewModels)

    let volumeProfileViewModels = getVolumeProfileViewModels(tool: tool, parameters: parameters)
    drawToolViewModels.append(contentsOf: volumeProfileViewModels)

    return drawToolViewModels
  }

  // MARK: - Private Methods

  private func getFillColorViewModels(tool: ChartIQDrawingTool,
                                      parameters: [String: Any]) -> [TableCellViewModelProtocol] {
    var drawToolViewModels: [TableCellViewModelProtocol] = []
    if chartIQDrawingManager.isSupportingFillColor(tool) {
      let fillColor = UIColor.getDynamicColor(from: parameters,
                                              colorKey: ChartIQConst.DrawingTool.fillColorKey,
                                              isDarkTheme: isDarkTheme)
      let fillColorViewModel = ColorTableCellViewModel(title: Const.DrawToolsService.fillColorTitle,
                                                       color: fillColor)
      drawToolViewModels.append(fillColorViewModel)
    }
    return drawToolViewModels
  }

  private func getLineColorViewModels(tool: ChartIQDrawingTool,
                                      parameters: [String: Any]) -> [TableCellViewModelProtocol] {
    var drawToolViewModels: [TableCellViewModelProtocol] = []
    if chartIQDrawingManager.isSupportingLineColor(tool) {
      let lineColor = UIColor.getDynamicColor(from: parameters,
                                              colorKey: ChartIQConst.DrawingTool.lineColorKey,
                                              isDarkTheme: isDarkTheme)
      let lineColorViewModel = ColorTableCellViewModel(title: Const.DrawToolsService.lineColorTitle,
                                                       color: lineColor)
      drawToolViewModels.append(lineColorViewModel)
    }
    return drawToolViewModels
  }

  private func getLineTypeViewModels(tool: ChartIQDrawingTool,
                                     parameters: [String: Any]) -> [TableCellViewModelProtocol] {
    var drawToolViewModels: [TableCellViewModelProtocol] = []
    if chartIQDrawingManager.isSupportingLineType(tool),
       let lineTypeName = parameters[ChartIQConst.DrawingTool.patternKey] as? String,
       let lineWidth = parameters[ChartIQConst.DrawingTool.lineWidthKey] as? Int,
       let lineType = ChartIQLineType(stringValue: lineTypeName) {
      let selectedLineModel = LineModel(lineType: lineType, lineWidth: lineWidth)
      let lineViewModel = LineTableCellViewModel(title: Const.DrawToolsService.lineTypeTitle,
                                                 lineModel: selectedLineModel)
      drawToolViewModels.append(lineViewModel)
    }
    return drawToolViewModels
  }

  private func getFontViewModels(tool: ChartIQDrawingTool,
                                 parameters: [String: Any]) -> [TableCellViewModelProtocol] {
    var drawToolViewModels: [TableCellViewModelProtocol] = []
    if chartIQDrawingManager.isSupportingFont(tool),
       let fontDictionary = parameters[ChartIQConst.DrawingTool.fontKey] as? [String: Any] {

      if let fontFamily = fontDictionary[ChartIQConst.DrawingTool.familyKey] as? String {
        let fontFamilyViewModel = SelectTableCellViewModel(title: Const.DrawToolsService.fontFamilyTitle,
                                                           detailTitle: fontFamily)
        drawToolViewModels.append(fontFamilyViewModel)
      }

      if let fontSize = fontDictionary[ChartIQConst.DrawingTool.sizeKey] as? String {
        let fontSizeViewModel = SelectTableCellViewModel(title: Const.DrawToolsService.fontSizeTitle,
                                                         detailTitle: fontSize)
        drawToolViewModels.append(fontSizeViewModel)
      }

      if let fontStyle = fontDictionary[ChartIQConst.DrawingTool.styleKey] as? String,
         let fontWeight = fontDictionary[ChartIQConst.DrawingTool.weightKey] as? String {
        var isBoldSelected = false, isItalicSelected = false
        if fontStyle == ChartIQConst.DrawingTool.italicKey {
          isItalicSelected = true
        }
        if fontWeight == ChartIQConst.DrawingTool.boldKey {
          isBoldSelected = true
        }
        let fontStyleViewModel = FontTableCellViewModel(title: Const.DrawToolsService.fontStyleTitle,
                                                        isBoldSelected: isBoldSelected,
                                                        isItalicSelected: isItalicSelected)
        drawToolViewModels.append(fontStyleViewModel)
      }
    }
    return drawToolViewModels
  }

  private func getAxisLabelViewModels(tool: ChartIQDrawingTool,
                                      parameters: [String: Any]) -> [TableCellViewModelProtocol] {
    var drawToolViewModels: [TableCellViewModelProtocol] = []
    if chartIQDrawingManager.isSupportingAxisLabel(tool),
       let isShowAxisLabel = parameters[ChartIQConst.DrawingTool.axisLabelKey] as? Bool {
      let showAxisLabelViewModel = ToggleTableCellViewModel(title: Const.DrawToolsService.axisLabelTitle,
                                                            isToggleOn: isShowAxisLabel)
      drawToolViewModels.append(showAxisLabelViewModel)
    }
    return drawToolViewModels
  }

  private func getShowCalloutViewModels(tool: ChartIQDrawingTool,
                                        parameters: [String: Any]) -> [TableCellViewModelProtocol] {
    var drawToolViewModels: [TableCellViewModelProtocol] = []
    if chartIQDrawingManager.isSupportingShowCallout(tool),
       let isShowCallout = parameters[ChartIQConst.DrawingTool.showCalloutKey] as? Bool {
      let showCalloutViewModel = ToggleTableCellViewModel(title: Const.DrawToolsService.showCalloutTitle,
                                                          isToggleOn: isShowCallout)
      drawToolViewModels.append(showCalloutViewModel)
    }
    return drawToolViewModels
  }

  private func getDeviationViewModels(tool: ChartIQDrawingTool,
                                      parameters: [String: Any]) -> [TableCellViewModelProtocol] {
    var drawToolViewModels: [TableCellViewModelProtocol] = []
    if chartIQDrawingManager.isSupportingDeviations(tool) {
      var deviationModels: [DeviationModel] = []
      if let firstDeviationModel = DeviationModel(lineLevel: .first, parameters: parameters, isDarkTheme: isDarkTheme) {
        deviationModels.append(firstDeviationModel)
      }
      if let secondDeviationModel = DeviationModel(lineLevel: .second, parameters: parameters, isDarkTheme: isDarkTheme) {
        deviationModels.append(secondDeviationModel)
      }
      if let thirdDeviationModel = DeviationModel(lineLevel: .third, parameters: parameters, isDarkTheme: isDarkTheme) {
        deviationModels.append(thirdDeviationModel)
      }
      let deviationsViewModel = DeviationsTableCellViewModel(title: Const.DrawToolsService.deviationsSettingsTitle,
                                                             deviationModels: deviationModels)
      drawToolViewModels.append(deviationsViewModel)
    }
    return drawToolViewModels
  }

  private func getFibonacciViewModels(tool: ChartIQDrawingTool,
                                      parameters: [String: Any]) -> [TableCellViewModelProtocol] {
    var drawToolViewModels: [TableCellViewModelProtocol] = []
    if chartIQDrawingManager.isSupportingFibonacci(tool),
       let fibSettingsArray = parameters[ChartIQConst.DrawingTool.fibsKey] as? [[String: Any]] {
      let fibSettingsViewModel = FibSettingsTableCellViewModel(title: Const.DrawToolsService.fibonacciSettingsTitle,
                                                               parameters: fibSettingsArray)
      drawToolViewModels.append(fibSettingsViewModel)
    }
    return drawToolViewModels
  }

  private func getElliottWaveViewModels(tool: ChartIQDrawingTool,
                                        parameters: [String: Any]) -> [TableCellViewModelProtocol] {
    var drawToolViewModels: [TableCellViewModelProtocol] = []
    if chartIQDrawingManager.isSupportingElliottWave(tool),
       let waveParamsDictionary = parameters[ChartIQConst.DrawingTool.waveParametersKey] as? [String: Any] {

      // WaveTemplate - Not comes from JS
      if let waveTemplate = waveParamsDictionary[Const.DrawToolsService.waveTemplateTitle] as? String {
        let waveTemplateViewModel = SelectTableCellViewModel(title: Const.DrawToolsService.waveTemplateTitle,
                                                             detailTitle: waveTemplate)
        drawToolViewModels.append(waveTemplateViewModel)
      }

      if let impulse = waveParamsDictionary[ChartIQConst.DrawingTool.impulseKey] as? String {
        let impulseViewModel = SelectTableCellViewModel(title: Const.DrawToolsService.impulseTitle,
                                                        detailTitle: impulse)
        drawToolViewModels.append(impulseViewModel)
      }

      if let corrective = waveParamsDictionary[ChartIQConst.DrawingTool.correctiveKey] as? String {
        let correctiveViewModel = SelectTableCellViewModel(title: Const.DrawToolsService.correctiveTitle,
                                                           detailTitle: corrective)
        drawToolViewModels.append(correctiveViewModel)
      }

      if let decoration = waveParamsDictionary[ChartIQConst.DrawingTool.decorationKey] as? String {
        let decorationViewModel = SelectTableCellViewModel(title: Const.DrawToolsService.decorationTitle,
                                                           detailTitle: decoration.capitalizeFirst())
        drawToolViewModels.append(decorationViewModel)
      }

      if let isShowLines = waveParamsDictionary[ChartIQConst.DrawingTool.showLinesKey] as? Bool {
        let showLinesViewModel = ToggleTableCellViewModel(title: Const.DrawToolsService.showLinesTitle,
                                                          isToggleOn: isShowLines)
        drawToolViewModels.append(showLinesViewModel)
      }
    }
    return drawToolViewModels
  }

  private func getVolumeProfileViewModels(tool: ChartIQDrawingTool,
                                          parameters: [String: Any]) -> [TableCellViewModelProtocol] {
    var drawToolViewModels: [TableCellViewModelProtocol] = []
    if chartIQDrawingManager.isSupportingVolumeProfile(tool),
       let volumeProfileDict = parameters[ChartIQConst.DrawingTool.volumeProfileKey] as? [String: Any],
       let priceBucketsValue = volumeProfileDict[ChartIQConst.DrawingTool.priceBucketsKey] as? Double {
      let numberViewModel = NumberTableCellViewModel(title: Const.DrawToolsService.priceBucketsTitle,
                                                     number: priceBucketsValue,
                                                     shouldDisplayAsInt: true)
      drawToolViewModels.append(numberViewModel)
    }
    return drawToolViewModels
  }
}
