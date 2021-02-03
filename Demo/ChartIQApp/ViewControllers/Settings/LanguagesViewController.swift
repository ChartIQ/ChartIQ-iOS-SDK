//
//  LanguagesViewController.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - Languages ViewController

class LanguagesViewController: BaseViewController {

  // MARK: - IBOutlets

  @IBOutlet private var tableView: UITableView!

  // MARK: - Internal Properties

  internal var selectedLanguage: LanguageModel?
  internal var didSelectLanguage: ((LanguageModel) -> Void)?

  // MARK: - Private Properties

  private var languages: [LanguageModel] = []
  private let locManager = LocalizationManager.shared()

  // MARK: - ViewController Lifecycle Methods

  override func viewDidLoad() {
    super.viewDidLoad()

    setupLanguages()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    updateSelectedLanguage()
  }

  override func languageDidChange() {
    navigationItem.title = locManager.localize(Const.Language.screenTitle)
  }

  // MARK: - Setup Methods

  override func setupUI() {
    navigationItem.title = locManager.localize(Const.Language.screenTitle)
    tableView.backgroundColor = .ghostWhiteСhineseBlackColor
  }

  override func setupSettings() {
    tableView.register(nibName: Const.BaseTableCell.cellNibName, cellId: Const.BaseTableCell.cellId)
    tableView.delegate = self
    tableView.dataSource = self
  }

  private func setupLanguages() {
    languages = locManager.languages
    tableView.reloadData()
    updateSelectedLanguage()
  }

  // MARK: - Private Methods

  private func updateSelectedLanguage() {
    if let selectedLanguage = selectedLanguage,
      languages.contains(selectedLanguage),
      let index = languages.firstIndex(of: selectedLanguage) {
      let selectedIndexPath = IndexPath(item: index, section: 0)
      tableView.selectRow(at: selectedIndexPath, animated: true, scrollPosition: .middle)
    }
  }
}

// MARK: - UITableViewDataSource

extension LanguagesViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return languages.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let baseTableCell = tableView.dequeueReusableCell(withIdentifier: Const.BaseTableCell.cellId,
                                                            for: indexPath) as? BaseTableCell else {
                                                              return UITableViewCell()
    }
    let language = languages[indexPath.row]
    baseTableCell.textLabel?.text = locManager.localize(language.displayName)
    return baseTableCell
  }
}

// MARK: - UITableViewDelegate

extension LanguagesViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let cell = tableView.cellForRow(at: indexPath) { cell.accessoryType = .checkmark }
    let language = languages[indexPath.row]
    didSelectLanguage?(language)
    navigationController?.popViewController(animated: true)
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return Const.BaseTableCell.cellHeight
  }
}
