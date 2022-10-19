//
//  ConditionMarkerService.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - SignalCondition Service

class ConditionMarkerService {

    // MARK: - Internal Methods

    internal func getDefaultSignalColor(condition: ConditionViewModel, outputs: [[String: Any]]) -> UIColor {
        var defaultColor: UIColor = .clear
        let output = outputs.first(where: { output in
            if let name = output["name"] as? String,
               condition.firstIndicatorName.contains(name) {
                return true
            }
            return false
        })
        if let colorHexString = output?["color"] as? String {
            defaultColor = UIColor(hexString: colorHexString)
        }
        return defaultColor
    }
}
