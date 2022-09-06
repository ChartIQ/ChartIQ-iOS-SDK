//
//  ChartStyleViewController.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - ChartStyle ViewController

class ChartStyleViewController: BaseViewController {

  // MARK: - IBOutlets

  @IBOutlet private var tableView: UITableView!

  // MARK: - Internal Properties

  internal var selectedChartStyle: ChartStyleModel?
  internal var didSelectChartStyle: ((ChartStyleModel) -> Void)?
  internal var isPresented: Bool = false

  // MARK: - Private Properties

  private var cancelBarButtonItem: UIBarButtonItem?
  private var chartStyles: [ChartStyleModel] = []
  private let locManager = LocalizationManager.shared()

  // MARK: - ViewController Lifecycle Methods

  override func viewDidLoad() {
    super.viewDidLoad()

    setupChartStyles()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    updateSelectedChartStyle()
  }

  override func languageDidChange() {
    navigationItem.title = locManager.localize(Const.ChartStyle.screenTitle)
    cancelBarButtonItem?.title = locManager.localize(Const.General.cancelTitle)
  }

  // MARK: - Setup Methods

  override func setupUI() {
    navigationItem.title = locManager.localize(Const.ChartStyle.screenTitle)
    tableView.backgroundColor = .ghostWhiteСhineseBlackColor

    tableView.tableHeaderView = UIView()
    tableView.tableFooterView = UIView()

    if isPresented {
      cancelBarButtonItem = UIBarButtonItem(title: locManager.localize(Const.General.cancelTitle),
                                            style: .plain,
                                            target: self,
                                            action: #selector(cancelButtonTapped))
      navigationItem.leftBarButtonItem = cancelBarButtonItem
    }
  }

  override func setupSettings() {
    tableView.register(nibName: Const.BaseTableCell.cellNibName, cellId: Const.BaseTableCell.cellId)
    tableView.delegate = self
    tableView.dataSource = self
  }

  private func setupChartStyles() {
    for index in 0...ChartIQChartType.histogram.rawValue {
      if let chartType = ChartIQChartType(rawValue: index) {
        let chartStyleModel = ChartStyleModel(chartType: chartType)
        chartStyles.append(chartStyleModel)
      }
    }
    for index in 0...ChartIQChartAggregationType.pandf.rawValue {
      if let chartAggregationType = ChartIQChartAggregationType(rawValue: index) {
        let chartStyleModel = ChartStyleModel(chartAggregationType: chartAggregationType)
        chartStyles.append(chartStyleModel)
      }
    }
    tableView.reloadData()
    updateSelectedChartStyle()
  }

  // MARK: - Actions Methods

  @objc private func cancelButtonTapped() {
    closeControler()
  }

  // MARK: - Private Methods

  private func updateSelectedChartStyle() {
    var style: ChartStyleModel?
    if let chartAggregationType = selectedChartStyle?.chartAggregationType {
      style = ChartStyleModel(chartAggregationType: chartAggregationType)
    } else if let chartType = selectedChartStyle?.chartType {
      style = ChartStyleModel(chartType: chartType)
    }
    if let selectedChartStyle = style,
      chartStyles.contains(selectedChartStyle),
      let index = chartStyles.firstIndex(of: selectedChartStyle) {
      let selectedIndexPath = IndexPath(item: index, section: 0)
      tableView.selectRow(at: selectedIndexPath, animated: true, scrollPosition: .middle)
    }
  }

  private func closeControler() {
    if isPresented {
      dismiss(animated: true, completion: nil)
    } else {
      navigationController?.popViewController(animated: true)
    }
  }
}

// MARK: - UITableViewDataSource

extension ChartStyleViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return chartStyles.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let baseTableCell = tableView.dequeueReusableCell(withIdentifier: Const.BaseTableCell.cellId,
                                                            for: indexPath) as? BaseTableCell else {
                                                              return UITableViewCell()
    }
    let chartStyle = chartStyles[indexPath.row]
    baseTableCell.textLabel?.text = locManager.localize(chartStyle.displayName)
    baseTableCell.imageView?.image = chartStyle.typeImage
    return baseTableCell
  }
}

// MARK: - UITableViewDelegate

extension ChartStyleViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let cell = tableView.cellForRow(at: indexPath) { cell.accessoryType = .checkmark }
    let chartStyle = chartStyles[indexPath.row]
    didSelectChartStyle?(chartStyle)
    closeControler()
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return Const.BaseTableCell.cellHeight
  }
}
