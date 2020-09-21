//
//  StudiesService.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

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
    var type = Const.StudiesService.colorKey
    if let typeParameter = parameter[Const.StudiesService.typeKey] as? String {
      type = typeParameter
    }
    if parameter[Const.StudiesService.colorKey] != nil,
      parameter[Const.StudiesService.typeKey] != nil,
      parameter[Const.StudiesService.typeKey] as? String == Const.StudiesService.textKey {
      type = Const.StudiesService.colorTextKey
    }
    let optionType = StudyDetailType(rawValue: type)
    return optionType
  }

  internal func getStudyViewModel(from parameter: [String: Any]) -> TableCellViewModelProtocol? {
    guard let optionType = getStudyDetailType(from: parameter) else { return nil }
    var viewModel: TableCellViewModelProtocol?
    switch optionType {
    case .text:
      let title = parameter[Const.StudiesService.nameKey] as? String ?? ""
      let text = parameter[Const.StudiesService.valueKey] as? String ?? ""
      viewModel = TextTableCellViewModel(title: title, text: text)
    case .number:
      let title = parameter[Const.StudiesService.nameKey] as? String ?? ""
      let number = parameter[Const.StudiesService.valueKey] as? Double ?? 0
      viewModel = NumberTableCellViewModel(title: title, number: number)
    case .color:
      let title = parameter[Const.StudiesService.nameKey] as? String ?? ""
      var color = UIColor.blackColor
      if let rawColorString = parameter[Const.StudiesService.colorKey] as? String {
        color = UIColor(hexString: rawColorString.replacingOccurrences(of: Const.General.hashSymbol, with: ""))
      }
      viewModel = ColorTableCellViewModel(title: title, color: color)
    case .textColor:
      let title = parameter[Const.StudiesService.nameKey] as? String ?? ""
      let number = parameter[Const.StudiesService.valueKey] as? Int ?? 0
      var color = UIColor.blackColor
      if let rawColorString = parameter[Const.StudiesService.colorKey] as? String {
        color = UIColor(hexString: rawColorString.replacingOccurrences(of: Const.General.hashSymbol, with: ""))
      }
      viewModel = TextColorTableCellViewModel(title: title, number: number, color: color)
    case .toggle:
      let title = parameter[Const.StudiesService.nameKey] as? String ?? ""
      let isToggleOn = parameter[Const.StudiesService.valueKey] as? Bool ?? false
      viewModel = ToggleTableCellViewModel(title: title, isToggleOn: isToggleOn)
    case .select:
      let title = parameter[Const.StudiesService.nameKey] as? String ?? ""
      var detailTitle = ""
      if let value = parameter[Const.StudiesService.valueKey] {
        detailTitle = String(describing: value)
      }
      viewModel = SelectTableCellViewModel(title: title, detailTitle: detailTitle)
    }
    return viewModel
  }
}
