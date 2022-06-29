//
//  ConditionViewModel.swift
//  ChartIQDemo
//
//  Created by Konstantin on 25.06.2022.
//  Copyright © 2022 ChartIQ. All rights reserved.
//

import ChartIQ
import Foundation

// MARK: - Condition ViewModel

struct ConditionViewModel {

  // MARK: - Internal Properties

  internal var id: String = UUID().uuidString
  internal var conditionName: String?
  internal var firstIndicatorName: String
  internal var conditionOperator: ChartIQSignalOperator?
  internal var secondIndicatorName: String?
  internal var secondIndicatorValue: Double?
  internal var markerOptions: ChartIQMarkerOptions?

  internal var studyParameters: String?

  internal var firstIndicatorShortName: String {
    let studyParameters = studyParameters ?? ""
    return firstIndicatorName.replace(studyParameters, with: "")
  }

  internal var secondIndicatorShortName: String? {
    let studyParameters = studyParameters ?? ""
    return secondIndicatorName?.replace(studyParameters, with: "")
  }
}
