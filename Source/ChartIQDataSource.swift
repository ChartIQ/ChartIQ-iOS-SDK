//
//  ChartIQDataSource.swift
//  ChartIQ
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import Foundation

@objc(ChartIQDataSource)
public protocol ChartIQDataSource {

  /// Called when chart pull initial data.
  ///
  /// - Parameters:
  ///   - params: The ChartIQQuoteFeedParams.
  ///   - completionHandler: The Completion Handler.
  func pullInitialData(by params: ChartIQQuoteFeedParams, completionHandler: @escaping ([ChartIQData]) -> Void)

  /// Called when chart pull update data.
  ///
  /// - Parameters:
  ///   - params: The ChartIQQuoteFeedParams.
  ///   - completionHandler: The Completion Handler.
  func pullUpdateData(by params: ChartIQQuoteFeedParams, completionHandler: @escaping ([ChartIQData]) -> Void)

  /// Called when chart pull pagination data.
  ///
  /// - Parameters:
  ///   - params: The ChartIQQuoteFeedParams.
  ///   - completionHandler: The Completion Handler.
  func pullPaginationData(by params: ChartIQQuoteFeedParams, completionHandler: @escaping ([ChartIQData]) -> Void)
}
