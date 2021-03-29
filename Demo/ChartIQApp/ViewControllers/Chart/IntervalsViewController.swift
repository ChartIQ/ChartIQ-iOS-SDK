//
//  IntervalsViewController.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - Intervals ViewController

class IntervalsViewController: BaseViewController {

  // MARK: - TableSection Enum

  enum TableSection: Int, CaseIterable {
    case first = 0, second, third, total
  }

  // MARK: - IBOutlets

  @IBOutlet private var tableView: UITableView!

  // MARK: - Internal Properties

  internal var selectedInterval: IntervalModel?
  internal var didSelectInterval: ((IntervalModel) -> Void)?

  // MARK: - Private Properties

  private var cancelBarButtonItem: UIBarButtonItem?
  private var pickerView: UIPickerView?
  private var pickerViewTextFiled: UITextField?
  private let locManager = LocalizationManager.shared()
  private var intervals: [TableSection: [IntervalModel]] = [:]
  private var times: [Int] = []
  private var timeUnits: [TimeUnit] = []
  private var isPickerViewHidden = true
  private var customIntervalString = ""

  // MARK: - ViewController Lifecycle Methods

  override func viewDidLoad() {
    super.viewDidLoad()

    setupIntervals()
    setupTimes()
    setupTimeUnits()
  }

  override func languageDidChange() {
    navigationItem.title = locManager.localize(Const.Intervals.screenTitle)
    customIntervalString = locManager.localize(Const.Intervals.selectCustomCellTitle)
    cancelBarButtonItem?.title = locManager.localize(Const.General.cancelTitle)
    tableView.reloadData()
  }

  // MARK: - Setup Methods

  override func setupUI() {
    navigationItem.title = locManager.localize(Const.Intervals.screenTitle)

    customIntervalString = locManager.localize(Const.Intervals.selectCustomCellTitle)
    tableView.backgroundColor = .ghostWhiteСhineseBlackColor
    cancelBarButtonItem = UIBarButtonItem(title: locManager.localize(Const.General.cancelTitle),
                                          style: .plain,
                                          target: self,
                                          action: #selector(cancelButtonTapped))
    navigationItem.leftBarButtonItem = cancelBarButtonItem

    let pickerViewFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: Const.Intervals.pickerViewHeight)
    pickerView = UIPickerView(frame: pickerViewFrame)
    pickerView?.backgroundColor = .whiteDarkGunmetalColor
    pickerViewTextFiled = UITextField(frame: CGRect.zero)
    pickerViewTextFiled?.alpha = .invisible
    pickerViewTextFiled?.inputView = pickerView
    pickerViewTextFiled?.inputAccessoryView = UIView.doneAccessoryView(target: self,
                                                                       action: #selector(doneButtonTapped))
    if let pickerViewTextFiled = pickerViewTextFiled {
      view.addSubview(pickerViewTextFiled)
    }
  }

  override func setupSettings() {
    tableView.register(nibName: Const.BaseTableCell.cellNibName, cellId: Const.BaseTableCell.cellId)
    tableView.delegate = self
    tableView.dataSource = self

    pickerView?.dataSource = self
    pickerView?.delegate = self
  }

  private func setupIntervals() {
    intervals = [
      .second: [
        IntervalModel(time: 1, timeUnit: .day),
        IntervalModel(time: 1, timeUnit: .week),
        IntervalModel(time: 1, timeUnit: .month)
      ],
      .third: [
        IntervalModel(time: 1, timeUnit: .minute),
        IntervalModel(time: 5, timeUnit: .minute),
        IntervalModel(time: 10, timeUnit: .minute),
        IntervalModel(time: 15, timeUnit: .minute),
        IntervalModel(time: 30, timeUnit: .minute),
        IntervalModel(time: 1, timeUnit: .hour),
        IntervalModel(time: 4, timeUnit: .hour)
      ]
    ]
    tableView.reloadData()
    updateSelectedInterval()
  }

  private func setupTimes() {
    for time in 1...99 {
      times.append(time)
    }
  }

  private func setupTimeUnits() {
    timeUnits = [.minute, .hour, .day, .month]
  }

  // MARK: - Actions Methods

  @objc private func cancelButtonTapped() {
    dismiss(animated: true, completion: nil)
  }

  @objc private func doneButtonTapped() {
    if let intervalModel = getIntervalModelFromPickerView() {
      selectInterval(withModel: intervalModel)
    }
  }

  // MARK: - Private Methods

  private func updateSelectedInterval() {
    guard let selectedInterval = selectedInterval else { return }
    var isCustomInterval = true
    for section in TableSection.allCases {
      if section != .first, let intervals = intervals[section],
        intervals.contains(selectedInterval),
        let index = intervals.firstIndex(of: selectedInterval) {
        isCustomInterval = false
        let selectedIndexPath = IndexPath(item: index, section: section.rawValue)
        tableView.selectRow(at: selectedIndexPath, animated: true, scrollPosition: .top)
      }
    }
    isCustomInterval ? updateCustomInterval(withModel: selectedInterval) : ()
  }

  private func updateCustomInterval(withModel intervalModel: IntervalModel) {
    customIntervalString = intervalModel.getFullDisplayName()
    tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: UITableView.RowAnimation.fade)
    tableView.selectRow(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .top)
  }

  private func selectInterval(withModel intervalModel: IntervalModel) {
    hideIntervalPickerView()
    didSelectInterval?(intervalModel)
    dismiss(animated: true, completion: nil)
  }

  private func showIntervalPickerView() {
    isPickerViewHidden = false
    pickerViewTextFiled?.becomeFirstResponder()
    if let selectedInterval = selectedInterval {
      let time = selectedInterval.time
      if times.contains(time), let index = times.firstIndex(of: time) {
        pickerView?.selectRow(index, inComponent: 0, animated: true)
      }
      let timeUnit = selectedInterval.timeUnit
      if timeUnits.contains(timeUnit), let index = timeUnits.firstIndex(of: timeUnit) {
        pickerView?.selectRow(index, inComponent: 1, animated: true)
      }
    }
  }

  private func hideIntervalPickerView() {
    isPickerViewHidden = true
    pickerViewTextFiled?.resignFirstResponder()
  }

  // MARK: - Private UIPickerView Helper Methods

  private func getPickerViewComponentsCount() -> Int {
    return 2
  }

  private func getPickerViewNumberOfRows(in component: Int) -> Int {
    return component == 0 ? times.count : timeUnits.count
  }

  private func getPickerViewWidth(for component: Int) -> CGFloat {
    let width = pickerView?.frame.size.width ?? 1
    return component == 0 ? 1 / 5 * width : 4 / 5 * width
  }

  private func getPickerViewTitle(forRow row: Int, at component: Int) -> String {
    return component == 0 ? "\(times[row])" : "\(timeUnits[row].fullDisplayName.capitalized)"
  }

  private func getIntervalModelFromPickerView() -> IntervalModel? {
    if let timeSelectedRow = pickerView?.selectedRow(inComponent: 0),
      let timeUnitSelectedRow = pickerView?.selectedRow(inComponent: 1) {
      let time = times[timeSelectedRow]
      let timeUnit = timeUnits[timeUnitSelectedRow]
      return IntervalModel(time: time, timeUnit: timeUnit)
    }
    return nil
  }

  // MARK: - Private UITableView Helper Methods

  private func performSelection(at indexPath: IndexPath) {
    guard let tableSection = TableSection(rawValue: indexPath.section) else { return }
    if tableSection == .first {
      isPickerViewHidden ? showIntervalPickerView() : hideIntervalPickerView()
    } else {
      guard let intervalModel = intervals[tableSection]?[indexPath.row] else { return }
      selectInterval(withModel: intervalModel)
    }
  }
}

// MARK: - UITableViewDataSource

extension IntervalsViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return TableSection.total.rawValue
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let tableSection = TableSection(rawValue: section) else { return 0 }
    return tableSection == .first ? 1 : intervals[tableSection]?.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let baseTableViewCell = tableView.dequeueReusableCell(withIdentifier: Const.BaseTableCell.cellId,
                                                                for: indexPath) as? BaseTableCell,
      let tableSection = TableSection(rawValue: indexPath.section) else { return UITableViewCell() }
    if tableSection == .first {
      baseTableViewCell.textLabel?.text = customIntervalString
    } else {
      guard let interval = intervals[tableSection]?[indexPath.row] else { return UITableViewCell() }
      baseTableViewCell.textLabel?.text = interval.getFullDisplayName()
    }
    return baseTableViewCell
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    guard let tableSection = TableSection(rawValue: section) else { return nil }
    return tableSection == .first ? locManager.localize(Const.Intervals.customConfigHeaderTitle) : nil
  }
}

// MARK: - UITableViewDelegate

extension IntervalsViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let cell = tableView.cellForRow(at: indexPath) { cell.accessoryType = .checkmark }
    if let tableSection = TableSection(rawValue: indexPath.section),
      tableSection == .first, !isPickerViewHidden {
      if let cell = tableView.cellForRow(at: indexPath) { cell.accessoryType = .none }
    }
    performSelection(at: indexPath)
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return Const.BaseTableCell.cellHeight
  }
}

// MARK: - UIPickerViewDataSource

extension IntervalsViewController: UIPickerViewDataSource {

  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return getPickerViewComponentsCount()
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return getPickerViewNumberOfRows(in: component)
  }

  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return getPickerViewTitle(forRow: row, at: component)
  }

  func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
    return getPickerViewWidth(for: component)
  }
}

// MARK: - UIPickerViewDelegate

extension IntervalsViewController: UIPickerViewDelegate {

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if let intervalModel = getIntervalModelFromPickerView() {
      updateCustomInterval(withModel: intervalModel)
    }
  }
}
