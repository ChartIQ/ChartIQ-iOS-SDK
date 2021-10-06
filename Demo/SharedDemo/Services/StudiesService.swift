//
//  StudiesService.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - StudyDetailType enum

enum StudyDetailType: String {
  case text
  case number
  case color
  case textColor = "colorText"
  case toggle = "checkbox"
  case select
}

// MARK: - Studies Service

class StudiesService {

  // MARK: - Private Properties

  private var isDarkTheme: Bool = false

  // MARK: - Internal Methods

  internal func getStudyViewModel(from parameters: [String: Any], isDarkTheme: Bool) -> TableCellViewModelProtocol? {
    guard let optionType = getStudyDetailType(from: parameters) else { return nil }
    var viewModel: TableCellViewModelProtocol?
    self.isDarkTheme = isDarkTheme
    switch optionType {
    case .text:
      let title = parameters[ChartIQConst.StudyParameter.nameKey] as? String ?? ""
      let text = parameters[ChartIQConst.StudyParameter.valueKey] as? String ?? ""
      viewModel = TextTableCellViewModel(title: title, text: text)
    case .number:
      let title = parameters[ChartIQConst.StudyParameter.nameKey] as? String ?? ""
      let number = parameters[ChartIQConst.StudyParameter.valueKey] as? Double ?? 0
      viewModel = NumberTableCellViewModel(title: title, number: number)
    case .color:
      let title = parameters[ChartIQConst.StudyParameter.nameKey] as? String ?? ""
      let color = UIColor.getDynamicColor(from: parameters,
                                          colorKey: ChartIQConst.StudyParameter.colorKey,
                                          isDarkTheme: isDarkTheme)
      viewModel = ColorTableCellViewModel(title: title, color: color)
    case .textColor:
      let title = parameters[ChartIQConst.StudyParameter.nameKey] as? String ?? ""
      let number = parameters[ChartIQConst.StudyParameter.valueKey] as? Int ?? 0
      let color = UIColor.getDynamicColor(from: parameters,
                                          colorKey: ChartIQConst.StudyParameter.colorKey,
                                          isDarkTheme: isDarkTheme)
      viewModel = TextColorTableCellViewModel(title: title, number: number, color: color)
    case .toggle:
      let title = parameters[ChartIQConst.StudyParameter.nameKey] as? String ?? ""
      let isToggleOn = parameters[ChartIQConst.StudyParameter.valueKey] as? Bool ?? false
      viewModel = ToggleTableCellViewModel(title: title, isToggleOn: isToggleOn)
    case .select:
      let title = parameters[ChartIQConst.StudyParameter.nameKey] as? String ?? ""
      var detailTitle = ""
      if let value = parameters[ChartIQConst.StudyParameter.valueKey] {
        detailTitle = String(describing: value)
      }
      viewModel = SelectTableCellViewModel(title: title, detailTitle: detailTitle)
    }
    return viewModel
  }

  // MARK: - Private Methods

  private func getStudyDetailType(from parameters: [String: Any]) -> StudyDetailType? {
    var type = ChartIQConst.StudyParameter.colorKey
    if let typeParameter = parameters[ChartIQConst.StudyParameter.typeKey] as? String {
      type = typeParameter
    }
    if parameters[ChartIQConst.StudyParameter.colorKey] != nil,
       parameters[ChartIQConst.StudyParameter.typeKey] != nil,
       parameters[ChartIQConst.StudyParameter.typeKey] as? String == ChartIQConst.StudyParameter.textKey {
      type = ChartIQConst.StudyParameter.colorTextKey
    }
    let optionType = StudyDetailType(rawValue: type)
    return optionType
  }
}
