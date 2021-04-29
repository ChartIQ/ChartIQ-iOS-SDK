//
//  DataSimulatorService.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import Foundation

// MARK: - DataSimulator Service

class DataSimulatorService {

  // MARK: - Private Properties

  private let uuid = UUID().uuidString
  private let locManager = LocalizationManager.shared()

  // MARK: - Internal Methods

  internal func loadChartData(withParameters parameters: ChartIQQuoteFeedParams,
                              controller: UIViewController,
                              completionHandler: @escaping ([ChartIQData]) -> Void) {
    loadChartData(withParameters: parameters) { chartIQDataArray, errorMessage in
      if errorMessage == nil, let chartIQDataArray = chartIQDataArray {
        completionHandler(chartIQDataArray)
      } else if let errorMessage = errorMessage, chartIQDataArray == nil {
        DispatchQueue.main.async {
          self.showReconnectAlert(controller: controller,
                                  message: errorMessage,
                                  parameters: parameters,
                                  completionHandler: completionHandler)
        }
      }
    }
  }

  internal func loadChartData(withParameters parameters: ChartIQQuoteFeedParams,
                              completionHandler: @escaping ([ChartIQData]?, String?) -> Void) {
    guard let url = getSimulatorURL(withParameters: parameters) else { return }
    let task = URLSession.shared.dataTask(with: url) { data, _, error in
      if let error = error, data == nil {
        completionHandler(nil, error.localizedDescription)
        return
      } else if error == nil, let data = data {
        var chartDatas: [ChartIQData] = []
        do {
          let json = try JSONSerialization.jsonObject(with: data, options: [])
          guard let result = json as? [[String: Any]] else { return }
          result.forEach({ dictionary in
            let chartIQData = ChartIQData(dictionary: dictionary)
            chartDatas.append(chartIQData)
          })
          completionHandler(chartDatas, nil)
        } catch {
          completionHandler(chartDatas, error.localizedDescription)
        }
      }
    }
    task.resume()
  }

  // MARK: - Private Methods

  private func getSimulatorURL(withParameters parameters: ChartIQQuoteFeedParams) -> URL? {
    var parametersEndDate = ""
    if !parameters.endDate.isEmpty {
      parametersEndDate = String(format: Const.DataSimulatorService.simulatorEndDateFormatString, parameters.endDate)
    }
    if let encodedSymbolParameter = parameters.symbol.stringByAddingPercentEncodingForRFC3986() {
      let urlString = String(format: Const.DataSimulatorService.simulatorUrlFormatString,
                             encodedSymbolParameter,
                             parameters.startDate,
                             parametersEndDate,
                             parameters.interval,
                             parameters.period,
                             uuid)
      let simulatorURL = URL(string: urlString)
      return simulatorURL
    }
    return nil
  }

  private func showReconnectAlert(controller: UIViewController,
                                  message: String,
                                  parameters: ChartIQQuoteFeedParams,
                                  completionHandler: @escaping ([ChartIQData]) -> Void) {
    let reconnectTitle = locManager.localize(Const.General.reconnectTitle)
    let reconnectAction = UIAlertAction(title: reconnectTitle, style: .default) { _ in
      self.loadChartData(withParameters: parameters,
                         controller: controller,
                         completionHandler: completionHandler)
    }
    controller.showAlert(title: locManager.localize(Const.DataSimulatorService.errorAlertTitle),
                         message: message,
                         actions: [reconnectAction])
  }
}
