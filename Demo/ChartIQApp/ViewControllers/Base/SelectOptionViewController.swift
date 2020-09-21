//
//  SelectOptionViewController.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - SelectOption ViewController

class SelectOptionViewController: BaseViewController {

  // MARK: - IBOutlets

  @IBOutlet private var tableView: UITableView!

  // MARK: - Internal Properties

  internal var options: [String] = []
  internal var selectedOption: String?
  internal var didSelectOption: ((String) -> Void)?

  // MARK: - Private Properties

  private let locManager = LocalizationManager.shared()

  // MARK: - ViewController Lifecycle Methods

  override func viewDidLoad() {
    super.viewDidLoad()

    updateOptions()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    updateSelectedOption()
  }

  // MARK: - Setup Methods

  override func setupUI() {
    navigationItem.title = locManager.localize(Const.SelectOption.screenTitle)
    tableView.backgroundColor = .ghostWhiteСhineseBlackColor
  }

  override func setupSettings() {
    tableView.register(nibName: Const.BaseTableCell.cellNibName, cellId: Const.BaseTableCell.cellId)
    tableView.delegate = self
    tableView.dataSource = self
  }

  override func languageDidChange() {
    navigationItem.title = locManager.localize(Const.SelectOption.screenTitle)
  }

  // MARK: - Private Methods

  private func updateOptions() {
    tableView.reloadData()
    updateSelectedOption()
  }

  private func updateSelectedOption() {
    if let selectedOption = selectedOption,
      options.contains(selectedOption),
      let index = options.firstIndex(of: selectedOption) {
      let selectedIndexPath = IndexPath(item: index, section: 0)
      tableView.selectRow(at: selectedIndexPath, animated: true, scrollPosition: .middle)
    }
  }
}

// MARK: - UITableViewDataSource

extension SelectOptionViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return options.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let baseTableCell = tableView.dequeueReusableCell(withIdentifier: Const.BaseTableCell.cellId,
                                                            for: indexPath) as? BaseTableCell else {
                                                              return UITableViewCell()
    }
    let option = options[indexPath.row]
    baseTableCell.textLabel?.text = option
    return baseTableCell
  }
}

// MARK: - UITableViewDelegate

extension SelectOptionViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let cell = tableView.cellForRow(at: indexPath) { cell.accessoryType = .checkmark }
    let option = options[indexPath.row]
    didSelectOption?(option)
    navigationController?.popViewController(animated: true)
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return Const.BaseTableCell.cellHeight
  }
}
