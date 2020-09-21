//
//  DrawToolsService.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - DrawTools Service

class DrawToolsService {

  // MARK: - Private Properties

  private let chartIQDrawingManager = ChartIQDrawingManager()

  // MARK: - Internal Methods
  // MARK: - DrawTools Collection ViewModels Methods

  internal func getDrawToolCollectionViewModels(from chartIQView: ChartIQView) -> [DrawToolViewModelProtocol] {
    var drawToolViewModels: [DrawToolViewModelProtocol] = []
    guard let tool = chartIQView.getCurrentDrawTool(),
      let parameters = chartIQView.getDrawingParameters(tool) else { return drawToolViewModels }

    let selectedToolViewModel = DrawToolBaseViewModel(type: .selectedTool, image: tool.toolImage)
    drawToolViewModels.append(selectedToolViewModel)

    if chartIQDrawingManager.isSupportingFillColor(tool),
      let fillColor = parameters[Const.DrawToolsService.fillColorKey] as? String {
      var selectedFillColor = UIColor.blackColor
      if fillColor.hasPrefix(Const.General.hashSymbol) {
        selectedFillColor = UIColor(hexString: fillColor.replacingOccurrences(of: Const.General.hashSymbol, with: ""))
      }
      let fillColorViewModel = DrawToolColorViewModel(type: .fillColor,
                                                      image: UIImage.DrawToolControlView.fillColorImage,
                                                      color: selectedFillColor)
      drawToolViewModels.append(fillColorViewModel)
    }

    if chartIQDrawingManager.isSupportingLineColor(tool),
      let lineColor = parameters[Const.DrawToolsService.lineColorKey] as? String {
      var selectedLineColor = UIColor.blackColor
      if lineColor.hasPrefix(Const.General.hashSymbol) {
        selectedLineColor = UIColor(hexString: lineColor.replacingOccurrences(of: Const.General.hashSymbol, with: ""))
      }
      let lineColorViewModel = DrawToolColorViewModel(type: .lineColor,
                                                      image: UIImage.DrawToolControlView.lineColorImage,
                                                      color: selectedLineColor)
      drawToolViewModels.append(lineColorViewModel)
    }

    if chartIQDrawingManager.isSupportingLineType(tool),
      let lineTypeName = parameters[Const.DrawToolsService.patternKey] as? String,
      let lineWidth = parameters[Const.DrawToolsService.lineWidthKey] as? Int,
      let lineType = ChartIQLineType(stringValue: lineTypeName) {
      let selectedLineModel = LineModel(lineType: lineType, lineWidth: lineWidth)
      let lineViewModel = DrawToolBaseViewModel(type: .lineType,
                                                image: selectedLineModel.lineImage,
                                                line: selectedLineModel)
      drawToolViewModels.append(lineViewModel)
    }

    let cloneToolViewModel = DrawToolBaseViewModel(type: .clone,
                                                   image: UIImage.DrawToolControlView.cloneImage)
    drawToolViewModels.append(cloneToolViewModel)

    let deleteToolViewModel = DrawToolBaseViewModel(type: .delete,
                                                    image: UIImage.DrawToolControlView.deleteImage)
    drawToolViewModels.append(deleteToolViewModel)

//    let magnetToolViewModel = DrawToolBaseViewModel(type: .magnet,
//                                                    image: UIImage.DrawToolControlView.magnetImage)
//    drawToolViewModels.append(magnetToolViewModel)

    let manageLayersToolViewModel = DrawToolBaseViewModel(type: .manageLayers,
                                                          image: UIImage.DrawToolControlView.manageLayersImage)
    drawToolViewModels.append(manageLayersToolViewModel)

//    if chartIQDrawingManager.isSupportingSettings(tool) {
//      let settingsToolViewModel = DrawToolBaseViewModel(type: .settings,
//                                                        image: UIImage.DrawToolControlView.settingsImage)
//      drawToolViewModels.append(settingsToolViewModel)
//    }

    return drawToolViewModels
  }

  // MARK: - DrawTools Table ViewModels Methods

  internal func getDrawToolTableViewModels(from chartIQView: ChartIQView) -> [TableCellViewModelProtocol] {
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

    let stdDeviationViewModels = getStdDeviationViewModels(tool: tool, parameters: parameters)
    drawToolViewModels.append(contentsOf: stdDeviationViewModels)

    let fibonacciViewModels = getFibonacciViewModels(tool: tool, parameters: parameters)
    drawToolViewModels.append(contentsOf: fibonacciViewModels)

    let elliottWaveViewModels = getElliottWaveViewModels(tool: tool, parameters: parameters)
    drawToolViewModels.append(contentsOf: elliottWaveViewModels)

    return drawToolViewModels
  }

  // MARK: - Private Methods

  private func getFillColorViewModels(tool: ChartIQDrawingTool,
                                      parameters: [String: Any]) -> [TableCellViewModelProtocol] {
    var drawToolViewModels: [TableCellViewModelProtocol] = []
    if chartIQDrawingManager.isSupportingFillColor(tool),
      let fillColor = parameters[Const.DrawToolsService.fillColorKey] as? String {
      var selectedFillColor = UIColor.blackColor
      if fillColor.hasPrefix(Const.General.hashSymbol) {
        selectedFillColor = UIColor(hexString: fillColor.replacingOccurrences(of: Const.General.hashSymbol, with: ""))
      }
      let fillColorViewModel = ColorTableCellViewModel(title: Const.DrawToolsService.fillColorTitle,
                                                       color: selectedFillColor)
      drawToolViewModels.append(fillColorViewModel)
    }
    return drawToolViewModels
  }

  private func getLineColorViewModels(tool: ChartIQDrawingTool,
                                      parameters: [String: Any]) -> [TableCellViewModelProtocol] {
    var drawToolViewModels: [TableCellViewModelProtocol] = []
    if chartIQDrawingManager.isSupportingLineColor(tool),
      let lineColor = parameters[Const.DrawToolsService.lineColorKey] as? String {
      var selectedLineColor = UIColor.blackColor
      if lineColor.hasPrefix(Const.General.hashSymbol) {
        selectedLineColor = UIColor(hexString: lineColor.replacingOccurrences(of: Const.General.hashSymbol, with: ""))
      }
      let lineColorViewModel = ColorTableCellViewModel(title: Const.DrawToolsService.lineColorTitle,
                                                       color: selectedLineColor)
      drawToolViewModels.append(lineColorViewModel)
    }
    return drawToolViewModels
  }

  private func getLineTypeViewModels(tool: ChartIQDrawingTool,
                                     parameters: [String: Any]) -> [TableCellViewModelProtocol] {
    var drawToolViewModels: [TableCellViewModelProtocol] = []
    if chartIQDrawingManager.isSupportingLineType(tool),
      let lineTypeName = parameters[Const.DrawToolsService.patternKey] as? String,
      let lineWidth = parameters[Const.DrawToolsService.lineWidthKey] as? Int,
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
      let fontDictionary = parameters[Const.DrawToolsService.fontKey] as? [String: Any] {

      if let fontFamily = fontDictionary[Const.DrawToolsService.familyKey] as? String {
        let fontFamilyViewModel = SelectTableCellViewModel(title: Const.DrawToolsService.fontFamilyTitle,
                                                           detailTitle: fontFamily)
        drawToolViewModels.append(fontFamilyViewModel)
      }

      if let fontSize = fontDictionary[Const.DrawToolsService.sizeKey] as? String {
        let fontSizeViewModel = SelectTableCellViewModel(title: Const.DrawToolsService.fontSizeTitle,
                                                         detailTitle: fontSize)
        drawToolViewModels.append(fontSizeViewModel)
      }

      if let fontStyle = fontDictionary[Const.DrawToolsService.styleKey] as? String {
        debugPrint("\(Const.DrawToolsService.styleKey): \(fontStyle)")
        let fontStyleViewModel = FontTableCellViewModel(title: Const.DrawToolsService.fontStyleTitle,
                                                        isBoldSelected: false,
                                                        isItalicSelected: false)
        drawToolViewModels.append(fontStyleViewModel)
      }
    }
    return drawToolViewModels
  }

  private func getAxisLabelViewModels(tool: ChartIQDrawingTool,
                                      parameters: [String: Any]) -> [TableCellViewModelProtocol] {
    var drawToolViewModels: [TableCellViewModelProtocol] = []
    if chartIQDrawingManager.isSupportingAxisLabel(tool),
      let isShowAxisLabel = parameters[Const.DrawToolsService.axisLabelKey] as? Bool {
      let showAxisLabelViewModel = ToggleTableCellViewModel(title: Const.DrawToolsService.axisLabelTitle,
                                                            isToggleOn: isShowAxisLabel)
      drawToolViewModels.append(showAxisLabelViewModel)
    }
    return drawToolViewModels
  }

  private func getStdDeviationViewModels(tool: ChartIQDrawingTool,
                                         parameters: [String: Any]) -> [TableCellViewModelProtocol] {
    let drawToolViewModels: [TableCellViewModelProtocol] = []
    if chartIQDrawingManager.isSupportingStdDeviations(tool) {
    }
    return drawToolViewModels
  }

  private func getFibonacciViewModels(tool: ChartIQDrawingTool,
                                      parameters: [String: Any]) -> [TableCellViewModelProtocol] {
    var drawToolViewModels: [TableCellViewModelProtocol] = []
    if chartIQDrawingManager.isSupportingFibonacci(tool),
      let fibParameters = parameters[Const.DrawToolsService.parametersKey] as? [String: Any],
      let fibParametersArray = fibParameters[Const.DrawToolsService.fibsKey] as? [[String: Any]] {
      debugPrint("\(Const.DrawToolsService.fibsKey): \(fibParametersArray)")
      let fibonacciSettingsViewModel = SelectTableCellViewModel(title: Const.DrawToolsService.fibonacciSettingsTitle)
      drawToolViewModels.append(fibonacciSettingsViewModel)
    }
    return drawToolViewModels
  }

  private func getElliottWaveViewModels(tool: ChartIQDrawingTool,
                                        parameters: [String: Any]) -> [TableCellViewModelProtocol] {
    var drawToolViewModels: [TableCellViewModelProtocol] = []
    if chartIQDrawingManager.isSupportingElliottWave(tool),
      let waveParamsDictionary = parameters[Const.DrawToolsService.waveParametersKey] as? [String: Any] {
      let waveTemplateViewModel = SelectTableCellViewModel(title: Const.DrawToolsService.waveTemplateTitle,
                                                           detailTitle: "")
      drawToolViewModels.append(waveTemplateViewModel)

      let impulseViewModel = SelectTableCellViewModel(title: Const.DrawToolsService.impulseTitle,
                                                      detailTitle: "")
      drawToolViewModels.append(impulseViewModel)

      let correctiveViewModel = SelectTableCellViewModel(title: Const.DrawToolsService.correctiveTitle,
                                                         detailTitle: "")
      drawToolViewModels.append(correctiveViewModel)

      if let isShowLines = waveParamsDictionary[Const.DrawToolsService.showLinesKey] as? Bool {
        let showLinesViewModel = ToggleTableCellViewModel(title: Const.DrawToolsService.showLinesTitle,
                                                          isToggleOn: isShowLines)
        drawToolViewModels.append(showLinesViewModel)
      }
    }
    return drawToolViewModels
  }
}
