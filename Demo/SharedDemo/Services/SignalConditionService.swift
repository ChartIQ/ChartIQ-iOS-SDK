//
//  SignalConditionService.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - SignalConditionTableSection Enum

enum SignalConditionTableSection: Int, CaseIterable {
  case first = 0, second
}

// MARK: - SignalCondition Service

class SignalConditionService {

  typealias SignalConditionViewModels = [SignalConditionTableSection: [TableCellViewModelProtocol]]

  // MARK: - Private Properties

  private var isAppearanceSettingsHidden: Bool = false
  private let locManager = LocalizationManager.shared()

  private let excludedOperators: [ChartIQSignalOperator] = [
    .increases, .decreases, .doesNotChange, .turnsUp, .turnsDown
  ]

  // MARK: - Init

  init(isAppearanceSettingsHidden: Bool) {
    self.isAppearanceSettingsHidden = isAppearanceSettingsHidden
  }

  // MARK: - Internal Methods

  internal func getConditionViewModels(condition: ConditionViewModel?, study: ChartIQStudy?) -> SignalConditionViewModels {
    let conditionDetailTitle = condition?.conditionOperator?.displayName ?? Const.SignalCondition.selectActionTitle
    var conditionSettingsViewModels: [TableCellViewModelProtocol] = [
      SelectTableCellViewModel(title: locManager.localize(Const.SignalCondition.firstIndicatorTitle),
                               detailTitle: condition?.firstIndicatorShortName),
      SelectTableCellViewModel(title: locManager.localize(Const.SignalCondition.conditionTitle),
                               detailTitle: conditionDetailTitle)
    ]

    if let conditionOperator = condition?.conditionOperator {

      if !excludedOperators.contains(where: { $0 == conditionOperator }) {
        let secondIndicatorTitle = locManager.localize(Const.SignalCondition.secondIndicatorTitle)
        conditionSettingsViewModels.append(SelectTableCellViewModel(title: secondIndicatorTitle,
                                                                    detailTitle: condition?.secondIndicatorShortName))
        if let secondIndicatorName = condition?.secondIndicatorName,
           secondIndicatorName == Const.SignalCondition.valueField {
          var number = 0.0
          if let secondIndicatorValue = condition?.secondIndicatorValue {
            number = secondIndicatorValue
          }
          conditionSettingsViewModels.append(NumberTableCellViewModel(title: Const.SignalCondition.valueField,
                                                                      number: number))
        }
      }

      if !isAppearanceSettingsHidden {
        var appearanceSettingsViewModels: [TableCellViewModelProtocol] = [
          SelectTableCellViewModel(title: locManager.localize(Const.SignalCondition.markerTypeTitle),
                                   detailTitle: condition?.markerOptions?.markerType.displayName),
          ColorTableCellViewModel(title: locManager.localize(Const.SignalCondition.colorTitle),
                                  color: condition?.markerOptions?.color ?? .clear)
        ]

        if condition?.markerOptions?.markerType == .marker {
          let markerSettingsViewModels: [TableCellViewModelProtocol] = [
            SelectTableCellViewModel(title: locManager.localize(Const.SignalCondition.shapeTitle),
                                     detailTitle: condition?.markerOptions?.shape.displayName),
            TextTableCellViewModel(title: locManager.localize(Const.SignalCondition.tagMarkTitle),
                                   text: condition?.markerOptions?.label),
            SelectTableCellViewModel(title: locManager.localize(Const.SignalCondition.sizeTitle),
                                     detailTitle: condition?.markerOptions?.size.displayName),
            SelectTableCellViewModel(title: locManager.localize(Const.SignalCondition.positionTitle),
                                     detailTitle: condition?.markerOptions?.position.displayName)
          ]
          appearanceSettingsViewModels.append(contentsOf: markerSettingsViewModels)
        }

        return [
          .first: conditionSettingsViewModels,
          .second: appearanceSettingsViewModels
        ]
      }
    }

    return [
      .first: conditionSettingsViewModels
    ]
  }

  internal func shouldClearSecondIndicatorValue(condition: ConditionViewModel?) -> Bool {
    if shouldClearSecondIndicatorName(condition: condition) {
      return true
    } else {
      return condition?.secondIndicatorName == Const.SignalCondition.valueField && condition?.secondIndicatorValue == nil
    }
  }

  internal func shouldClearSecondIndicatorName(condition: ConditionViewModel?) -> Bool {
    if let conditionOperator = condition?.conditionOperator,
       excludedOperators.contains(where: { $0 == conditionOperator }) {
      return true
    }
    return false
  }

  internal func getFirstIndicatorName(study: ChartIQStudy?) -> String {
    let firstIndicatorOptions = getFirstIndicatorOptions(study: study)
    var firstIndicatorName: String = ""
    if let firstIndicatorOption = firstIndicatorOptions.first {
      firstIndicatorName = firstIndicatorOption
    }
    return firstIndicatorName
  }

  internal func getFirstIndicatorOptions(study: ChartIQStudy?) -> [String] {
    var options: [String] = []
    if let study = study, let studyOutputs = study.outputs {
      let formattedOutputs = studyOutputs.map({ "\($0.key)" })
      options.append(contentsOf: formattedOutputs)
    }
    return options
  }

  internal func getSecondIndicatorOptions(study: ChartIQStudy?, firstIndicatorName: String?) -> [String] {
    var options: [String] = []
    if let firstIndicatorName = firstIndicatorName {
      let outputs = getFirstIndicatorOptions(study: study)
      let values = outputs.filter({ $0 != firstIndicatorName })
      options.append(contentsOf: values)
    }
    options.append(Const.SignalCondition.valueField)
    options.append(contentsOf: ChartIQQuoteField.conditionCases.map({ $0.displayName }))
    return options
  }

  internal func getOptions(for condition: ConditionViewModel?,
                           with study: ChartIQStudy?,
                           at indexPath: IndexPath) -> (options: [String], selectedOption: String) {
    var options: [String] = []
    var selectedOption: String = ""
    if indexPath.section == 0 {
      if indexPath.row == 0 {
        options = getFirstIndicatorOptions(study: study)
        let key = condition?.firstIndicatorName ?? options.first
        selectedOption = key ?? ""
      } else if indexPath.row == 1 {
        options = ChartIQSignalOperator.allCases.map({ $0.displayName })
        selectedOption = condition?.conditionOperator?.displayName ?? ""
      } else if indexPath.row == 2 {
        options = getSecondIndicatorOptions(study: study, firstIndicatorName: condition?.firstIndicatorName)
        selectedOption = condition?.secondIndicatorName ?? options.first ?? ""
      }
    } else {
      if indexPath.row == 0 {
        options = ChartIQSignalMarkerType.allCases.map({ $0.displayName })
        selectedOption = condition?.markerOptions?.markerType.displayName ?? ""
      } else if indexPath.row == 2 {
        options = ChartIQSignalShape.allCases.map({ $0.displayName })
        selectedOption = condition?.markerOptions?.shape.displayName ?? ""
      } else if indexPath.row == 4 {
        options = ChartIQSignalSize.allCases.map({ $0.displayName })
        selectedOption = condition?.markerOptions?.size.displayName ?? ""
      } else if indexPath.row == 5 {
        options = ChartIQSignalPosition.allCases.map({ $0.displayName })
        selectedOption = condition?.markerOptions?.position.displayName ?? ""
      }
    }
    return (options: options, selectedOption: selectedOption)
  }

  internal func getDefaultSignalColor(outputs: [[String: Any]]) -> UIColor {
    var defaultColor: UIColor = .clear
    if let colorHexString = outputs.first?["color"] as? String {
      defaultColor = UIColor(hexString: colorHexString)
    }
    return defaultColor
  }
}
