//
//  SeriesViewController.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - Series ViewController

class SeriesViewController: BaseViewController {

  // MARK: - IBOutlets

  @IBOutlet private var emptyStateView: UIView!
  @IBOutlet private var emptyStateViewLabel: UILabel!
  @IBOutlet private var emptyStateViewButton: UIButton!
  @IBOutlet private var tableView: UITableView!

  // MARK: - Internal Properties

  internal var chartIQView: ChartIQView!

  // MARK: - Private Properties

  private var cancelBarButtonItem: UIBarButtonItem?
  private var addBarButtonItem: UIBarButtonItem?
  private var series: [ChartIQSeries] = []
  private let locManager = LocalizationManager.shared()
  private var currentColorIndex: Int = .zero

  // MARK: - ViewController Lifecycle Methods

  override func viewDidLoad() {
    super.viewDidLoad()

    setupColorIndex()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    updateSeries()
  }

  override func languageDidChange() {
    navigationItem.title = locManager.localize(Const.Series.screenTitle)
    emptyStateViewLabel.text = locManager.localize(Const.Series.emptyStateViewTitle)
    emptyStateViewButton.setTitle(locManager.localize(Const.Series.emptyStateViewButtonTitle), for: .normal)
    addBarButtonItem?.title = locManager.localize(Const.General.addTitle)
    cancelBarButtonItem?.title = locManager.localize(Const.General.cancelTitle)
    tableView.reloadData()
  }

  // MARK: - Setup Methods

  override func setupUI() {
    navigationItem.title = locManager.localize(Const.Series.screenTitle)

    tableView.alpha = .invisible
    tableView.backgroundColor = .whiteDarkGunmetalColor

    emptyStateView.alpha = .invisible
    emptyStateView.backgroundColor = .whiteDarkGunmetalColor
    emptyStateViewLabel.text = locManager.localize(Const.Series.emptyStateViewTitle)
    emptyStateViewLabel.textColor = .cadetBlueColor
    emptyStateViewButton.setTitle(locManager.localize(Const.Series.emptyStateViewButtonTitle), for: .normal)
    emptyStateViewButton.setTitleColor(.white, for: .normal)
    emptyStateViewButton.backgroundColor = .mountainMeadowColor
    emptyStateViewButton.layer.cornerRadius = 6

    cancelBarButtonItem = UIBarButtonItem(title: locManager.localize(Const.General.cancelTitle),
                                          style: .plain,
                                          target: self,
                                          action: #selector(cancelButtonTapped))
    navigationItem.leftBarButtonItem = cancelBarButtonItem
    addBarButtonItem = UIBarButtonItem(title: locManager.localize(Const.General.addTitle),
                                       style: .done,
                                       target: self,
                                       action: #selector(addButtonTapped))
    navigationItem.rightBarButtonItem = addBarButtonItem

    updateBarButtonItems(isHidden: true)
  }

  override func setupSettings() {
    tableView.register(nibName: Const.TextColorTableCell.cellNibName, cellId: Const.TextColorTableCell.cellId)
    tableView.delegate = self
    tableView.dataSource = self
  }

  // MARK: - Actions Methods

  @objc private func cancelButtonTapped() {
    dismiss(animated: true, completion: nil)
  }

  @objc private func addButtonTapped() {
    presentSearchSymbolsViewController()
  }

  @IBAction private func emptyStateAddSeriesButtonTapped(_ sender: Any) {
    presentSearchSymbolsViewController()
  }

  // MARK: - Private Methods

  private func updateSeries() {
    view.startActivityIndicator()
    series = chartIQView.getActiveSeries()
    let isEmpty = series.isEmpty
    if isEmpty {
      updateBarButtonItems(isHidden: true)
      currentColorIndex = .zero
    } else {
      updateBarButtonItems(isHidden: false)
    }
    UIView.animate(withDuration: AnimationTime.fast.rawValue) {
      self.emptyStateView.alpha = isEmpty ? .visible : .invisible
      self.tableView.alpha = isEmpty ? .invisible : .visible
    }
    tableView.reloadData()
    view.stopActivityIndicator()
  }

  private func updateBarButtonItems(isHidden: Bool) {
    updateBarButtonItems(isEnabled: !isHidden)
    addBarButtonItem?.tintColor = isHidden ? .clear : .mountainMeadowColor
  }

  private func updateBarButtonItems(isEnabled: Bool) {
    addBarButtonItem?.isEnabled = isEnabled
  }

  private func removeActiveSeries(at indexPath: IndexPath) {
    view.startActivityIndicator()
    let deletedSeries = series[indexPath.row]
    chartIQView.removeSeries(deletedSeries.symbolName)
    series.remove(at: indexPath.row)
    tableView.deleteRows(at: [indexPath], with: .fade)
    updateSeries()
  }

  private func updateSelectedColorParameters(selectedColor: UIColor, seriesModel: ChartIQSeries) {
    let colorHexString = selectedColor.toHexString()
    chartIQView?.setSeriesParameter(seriesModel.symbolName, parameterName: Const.Series.colorKey, value: colorHexString)
    updateSeries()
  }

  private func setupColorIndex() {
    guard let color = chartIQView.getActiveSeries().last?.color,
          let index = UIColor.allSeriesColors().firstIndex(of: color) else { return }
    currentColorIndex = index + 1
  }

  private func nextColor() -> UIColor {
    let colors = UIColor.allSeriesColors()
    if currentColorIndex > colors.count - 1 {
      currentColorIndex = .zero
    }
    let nextColor = colors[currentColorIndex]
    currentColorIndex += 1
    return nextColor
  }

  // MARK: - Present Controllers Private Methods

  private func presentSearchSymbolsViewController() {
    guard let controller = UIStoryboard.searchSymbolsViewController() else { return }
    controller.didSelectSymbol = { [weak self] symbol in
      guard let self = self else { return }
      let series = ChartIQSeries(symbolName: symbol.name, color: self.nextColor())
      self.chartIQView.addSeries(series, isComparison: true)
      self.updateSeries()
    }
    let navigationController = NavigationController(rootViewController: controller)
    present(navigationController, animated: true, completion: nil)
  }

  private func presentFullScreenPickerController(with pickerType: FullScreenPickerType,
                                                 seriesModel: ChartIQSeries) {
    guard let controller = UIStoryboard.fullScreenPickerViewController() else { return }
    controller.selectedPickerViewItem = PickerViewItem(selectedColor: seriesModel.color, selectedLine: nil)
    controller.pickerType = pickerType
    controller.didSelectPickerViewItem = { [weak self] item in
      guard let selectedColor = item.selectedColor else { return }
      self?.updateSelectedColorParameters(selectedColor: selectedColor, seriesModel: seriesModel)
    }
    let navigationController = NavigationController(rootViewController: controller)
    present(navigationController, animated: true, completion: nil)
  }

  // MARK: - Private UITableView Helper Methods

  private func getDeleteTableAction(at indexPath: IndexPath) -> UITableViewRowAction {
    let deleteActionTitle = locManager.localize(Const.General.deleteTitle)
    let deleteAction = UITableViewRowAction(style: .destructive,
                                            title: deleteActionTitle) { [weak self] _, indexPath in
      self?.removeActiveSeries(at: indexPath)
    }
    deleteAction.backgroundColor = .coralRedColor
    return deleteAction
  }
}

// MARK: - UITableViewDataSource

extension SeriesViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    series.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let textColorCell = tableView.dequeueReusableCell(withIdentifier: Const.TextColorTableCell.cellId,
                                                            for: indexPath) as? TextColorTableCell else {
      return UITableViewCell()
    }
    let seriesModel = series[indexPath.row]
    let colorViewModel = ColorTableCellViewModel(title: seriesModel.symbolName, color: seriesModel.color)
    textColorCell.setupCell(withViewModel: colorViewModel)
    textColorCell.didSelectColorButtonTapped = { [weak self] in
      self?.presentFullScreenPickerController(with: .color, seriesModel: seriesModel)
    }
    return textColorCell
  }
}

// MARK: - UITableViewDelegate

extension SeriesViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return Const.BaseTableCell.cellHeight
  }

  func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
    let deleteTableAction = getDeleteTableAction(at: editActionsForRowAt)
    return [deleteTableAction]
  }

  func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
    updateBarButtonItems(isEnabled: false)
  }

  func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
    updateBarButtonItems(isEnabled: true)
  }
}
