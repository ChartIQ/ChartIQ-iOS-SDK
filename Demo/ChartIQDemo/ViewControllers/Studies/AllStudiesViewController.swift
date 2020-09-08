//
//  AllStudiesViewController.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - AllStudies ViewController

class AllStudiesViewController: BaseViewController {

  // MARK: - IBOutlets

  @IBOutlet private var tableView: UITableView!

  // MARK: - Internal Properties

  internal var allStudies: [ChartIQStudy] = []
  internal var didAddStudies: (([ChartIQStudy]) -> Void)?

  // MARK: - Private Properties

  private var cancelBarButtonItem: UIBarButtonItem?
  private var doneBarButtonItem: UIBarButtonItem?
  private var selectedStudies: [ChartIQStudy] = []
  private var filteredStudies: [ChartIQStudy] = []
  private let searchController = UISearchController(searchResultsController: nil)
  private let locManager = LocalizationManager.shared()
  private var isSearchBarEmpty: Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }
  private var isFiltering: Bool {
    return searchController.isActive && !isSearchBarEmpty
  }

  // MARK: - ViewController Lifecycle Methods

  override func viewDidLoad() {
    super.viewDidLoad()

    updateStudies()
  }

  // MARK: - Setup Methods

  override func setupUI() {
    navigationItem.title = locManager.localize(Const.AllStudies.screenTitle)
    tableView.backgroundColor = .ghostWhiteСhineseBlackColor
    searchController.defaultConfiguration()
    searchController.searchBar.inputAccessoryView = UIView.doneAccessoryView(target: self,
                                                                             action: #selector(doneButtonTapped))
    cancelBarButtonItem = UIBarButtonItem(title: locManager.localize(Const.General.cancelTitle),
                                          style: .plain,
                                          target: self,
                                          action: #selector(cancelButtonTapped))
    doneBarButtonItem = UIBarButtonItem(title: locManager.localize(Const.General.doneTitle),
                                        style: .done,
                                        target: self,
                                        action: #selector(doneButtonTapped))
    navigationItem.leftBarButtonItem = cancelBarButtonItem
    navigationItem.rightBarButtonItem = doneBarButtonItem
  }

  override func setupSettings() {
    tableView.register(nibName: Const.BaseTableCell.cellNibName, cellId: Const.BaseTableCell.cellId)
    tableView.delegate = self
    tableView.dataSource = self

    searchController.searchResultsUpdater = self
    searchController.hidesNavigationBarDuringPresentation = true
    definesPresentationContext = true

    updateSearchBar(isHidden: true)
  }

  override func languageDidChange() {
    navigationItem.title = locManager.localize(Const.AllStudies.screenTitle)
    cancelBarButtonItem?.title = locManager.localize(Const.General.cancelTitle)
    doneBarButtonItem?.title = locManager.localize(Const.General.doneTitle)
  }

  // MARK: - Actions Methods

  @objc private func cancelButtonTapped() {
    dismiss(animated: true, completion: nil)
  }

  @objc private func doneButtonTapped() {
    if searchController.isActive {
      searchController.dismiss(animated: false) {
        self.performDoneButtonAction()
      }
    } else {
      performDoneButtonAction()
    }
  }

  // MARK: - Private Methods

  private func updateStudies() {
    view.startActivityIndicator()
    updateSearchBar(isHidden: allStudies.isEmpty)
    tableView.reloadData()
    view.stopActivityIndicator()
  }

  private func updateSearchBar(isHidden: Bool) {
    if #available(iOS 11.0, *) {
      navigationItem.searchController = isHidden ? nil : searchController
      navigationItem.hidesSearchBarWhenScrolling = false
      navigationController?.view.setNeedsLayout()
    } else {
      tableView.tableHeaderView = isHidden ? nil : searchController.searchBar
    }
  }

  private func filterContentForSearchText(_ searchText: String) {
    filteredStudies = allStudies.filter { (study: ChartIQStudy) -> Bool in
      let localizedStudyName = locManager.localize(study.fullName)
      return localizedStudyName.lowercased().contains(searchText.lowercased())
    }
    tableView.reloadData()
  }

  private func performDoneButtonAction() {
    view.startActivityIndicator()
    didAddStudies?(self.selectedStudies)
    view.stopActivityIndicator()
    dismiss(animated: true, completion: nil)
  }
}

// MARK: - UITableViewDataSource

extension AllStudiesViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return isFiltering ? filteredStudies.count : allStudies.count
  }

  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let studies = isFiltering ? filteredStudies : allStudies
    let study = studies[indexPath.row]
    if selectedStudies.contains(study) {
      tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
    } else {
      tableView.deselectRow(at: indexPath, animated: false)
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let baseTableCell = tableView.dequeueReusableCell(withIdentifier: Const.BaseTableCell.cellId,
                                                            for: indexPath) as? BaseTableCell else {
                                                              return UITableViewCell()
    }
    let studies = isFiltering ? filteredStudies : allStudies
    let study = studies[indexPath.row]
    baseTableCell.textLabel?.text = locManager.localize(study.fullName)
    return baseTableCell
  }
}

// MARK: - UITableViewDelegate

extension AllStudiesViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let cell = tableView.cellForRow(at: indexPath) { cell.accessoryType = .checkmark }
    let studies = isFiltering ? filteredStudies : allStudies
    let selectedStudy = studies[indexPath.row]
    selectedStudies.append(selectedStudy)
  }

  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    if let cell = tableView.cellForRow(at: indexPath) { cell.accessoryType = .none }
    let studies = isFiltering ? filteredStudies : allStudies
    let deSelectedStudy = studies[indexPath.row]
    selectedStudies.removeAll { $0 == deSelectedStudy }
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return Const.BaseTableCell.cellHeight
  }
}

// MARK: - UISearchResultsUpdating

extension AllStudiesViewController: UISearchResultsUpdating {

  func updateSearchResults(for searchController: UISearchController) {
    guard let searchedText = searchController.searchBar.text else { return }
    filterContentForSearchText(searchedText)
  }
}
