//
//  StudiesService.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
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

  private func getStudyDetailType(from parameter: [String: Any]) -> StudyDetailType? {
    var type = ChartIQConst.StudyParameter.colorKey
    if let typeParameter = parameter[ChartIQConst.StudyParameter.typeKey] as? String {
      type = typeParameter
    }
    if parameter[ChartIQConst.StudyParameter.colorKey] != nil,
      parameter[ChartIQConst.StudyParameter.typeKey] != nil,
      parameter[ChartIQConst.StudyParameter.typeKey] as? String == ChartIQConst.StudyParameter.textKey {
      type = ChartIQConst.StudyParameter.colorTextKey
    }
    let optionType = StudyDetailType(rawValue: type)
    return optionType
  }

  internal func getStudyViewModel(from parameter: [String: Any]) -> TableCellViewModelProtocol? {
    guard let optionType = getStudyDetailType(from: parameter) else { return nil }
    var viewModel: TableCellViewModelProtocol?
    switch optionType {
    case .text:
      let title = parameter[ChartIQConst.StudyParameter.nameKey] as? String ?? ""
      let text = parameter[ChartIQConst.StudyParameter.valueKey] as? String ?? ""
      viewModel = TextTableCellViewModel(title: title, text: text)
    case .number:
      let title = parameter[ChartIQConst.StudyParameter.nameKey] as? String ?? ""
      let number = parameter[ChartIQConst.StudyParameter.valueKey] as? Double ?? 0
      viewModel = NumberTableCellViewModel(title: title, number: number)
    case .color:
      let title = parameter[ChartIQConst.StudyParameter.nameKey] as? String ?? ""
      var color = UIColor.blackColor
      if let rawColorString = parameter[ChartIQConst.StudyParameter.colorKey] as? String {
        color = UIColor(hexString: rawColorString.replacingOccurrences(of: Const.General.hashSymbol, with: ""))
      }
      viewModel = ColorTableCellViewModel(title: title, color: color)
    case .textColor:
      let title = parameter[ChartIQConst.StudyParameter.nameKey] as? String ?? ""
      let number = parameter[ChartIQConst.StudyParameter.valueKey] as? Int ?? 0
      var color = UIColor.blackColor
      if let rawColorString = parameter[ChartIQConst.StudyParameter.colorKey] as? String {
        color = UIColor(hexString: rawColorString.replacingOccurrences(of: Const.General.hashSymbol, with: ""))
      }
      viewModel = TextColorTableCellViewModel(title: title, number: number, color: color)
    case .toggle:
      let title = parameter[ChartIQConst.StudyParameter.nameKey] as? String ?? ""
      let isToggleOn = parameter[ChartIQConst.StudyParameter.valueKey] as? Bool ?? false
      viewModel = ToggleTableCellViewModel(title: title, isToggleOn: isToggleOn)
    case .select:
      let title = parameter[ChartIQConst.StudyParameter.nameKey] as? String ?? ""
      var detailTitle = ""
      if let value = parameter[ChartIQConst.StudyParameter.valueKey] {
        detailTitle = String(describing: value)
      }
      viewModel = SelectTableCellViewModel(title: title, detailTitle: detailTitle)
    }
    return viewModel
  }
}
