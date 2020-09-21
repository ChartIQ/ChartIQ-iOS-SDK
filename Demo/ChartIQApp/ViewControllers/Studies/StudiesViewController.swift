//
//  StudiesViewController.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - Studies ViewController

class StudiesViewController: BaseViewController {

  // MARK: - IBOutlets

  @IBOutlet private var emptyStateView: UIView!
  @IBOutlet private var emptyStateViewLabel: UILabel!
  @IBOutlet private var emptyStateViewButton: UIButton!
  @IBOutlet private var tableView: UITableView!

  // MARK: - Internal Properties

  internal var chartIQView: ChartIQView!

  // MARK: - Private Properties

  private var editBarButtonItem: UIBarButtonItem?
  private var addBarButtonItem: UIBarButtonItem?
  private var activeStudies: [ChartIQStudy] = []
  private var filteredStudies: [ChartIQStudy] = []
  private let searchController = UISearchController(searchResultsController: nil)
  private let locManager = LocalizationManager.shared()
  private var isTableViewEditing = false
  private var isSearchBarEmpty: Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }
  private var isFiltering: Bool {
    return searchController.isActive && !isSearchBarEmpty
  }

  // MARK: - ViewController Lifecycle Methods

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    updateStudies()
  }

  // MARK: - Setup Methods

  override func setupUI() {
    navigationItem.title = locManager.localize(Const.Studies.screenTitle)

    tableView.alpha = .invisible
    tableView.backgroundColor = .whiteDarkGunmetalColor
    searchController.defaultConfiguration()

    emptyStateView.alpha = .invisible
    emptyStateView.backgroundColor = .whiteDarkGunmetalColor
    emptyStateViewLabel.text = locManager.localize(Const.Studies.emptyStateViewTitle)
    emptyStateViewLabel.textColor = .cadetBlueColor
    emptyStateViewButton.setTitle(locManager.localize(Const.Studies.emptyStateViewButtonTitle), for: .normal)
    emptyStateViewButton.setTitleColor(.white, for: .normal)
    emptyStateViewButton.backgroundColor = .mountainMeadowColor
    emptyStateViewButton.layer.cornerRadius = 6

    editBarButtonItem = UIBarButtonItem(title: locManager.localize(Const.General.editTitle),
                                        style: .plain,
                                        target: self,
                                        action: #selector(editButtonTapped))
    addBarButtonItem = UIBarButtonItem(title: locManager.localize(Const.General.addTitle),
                                       style: .done,
                                       target: self,
                                       action: #selector(addButtonTapped))
    navigationItem.leftBarButtonItem = editBarButtonItem
    navigationItem.rightBarButtonItem = addBarButtonItem

    updateEditState(isEditing: false)
    updateBarButtonItems(isHidden: true)
    updateSearchBar(isHidden: true)
  }

  override func setupSettings() {
    tableView.register(nibName: Const.StudyTableCell.cellNibName, cellId: Const.StudyTableCell.cellId)
    tableView.delegate = self
    tableView.dataSource = self

    searchController.searchResultsUpdater = self
    definesPresentationContext = true
  }

  override func languageDidChange() {
    navigationItem.title = locManager.localize(Const.Studies.screenTitle)
    emptyStateViewLabel.text = locManager.localize(Const.Studies.emptyStateViewTitle)
    emptyStateViewButton.setTitle(locManager.localize(Const.Studies.emptyStateViewButtonTitle), for: .normal)
    editBarButtonItem?.title = locManager.localize(Const.General.editTitle)
    addBarButtonItem?.title = locManager.localize(Const.General.addTitle)
    updateEditState(isEditing: isTableViewEditing)
    tableView.reloadData()
  }

  // MARK: - Actions Methods

  @IBAction private func emptyStateAddStudiesButtonAction(_ sender: Any) {
    presentAllStudiesViewController()
  }

  @objc private func editButtonTapped() {
    isTableViewEditing.toggle()
    updateEditState(isEditing: isTableViewEditing)
  }

  @objc private func addButtonTapped() {
    presentAllStudiesViewController()
  }

  // MARK: - Private Methods

  private func updateStudies() {
    view.startActivityIndicator()
    activeStudies = chartIQView.getActiveStudies()
    let isEmpty = activeStudies.isEmpty
    if isEmpty {
      updateEditState(isEditing: false)
      updateBarButtonItems(isHidden: true)
    } else {
      updateBarButtonItems(isHidden: false)
      updateEditState(isEditing: isTableViewEditing)
    }
    UIView.animate(withDuration: AnimationTime.fast.rawValue) {
      self.emptyStateView.alpha = isEmpty ? .visible : .invisible
      self.tableView.alpha = isEmpty ? .invisible : .visible
    }
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

  private func updateEditState(isEditing: Bool) {
    isTableViewEditing = isEditing
    tableView.setEditing(isEditing, animated: true)
    let doneTitle = locManager.localize(Const.General.doneTitle)
    let editTitle = locManager.localize(Const.General.editTitle)
    editBarButtonItem?.title = isEditing ? doneTitle : editTitle
    editBarButtonItem?.style = isEditing ? .done : .plain
    addBarButtonItem?.isEnabled = !isEditing
  }

  private func updateBarButtonItems(isHidden: Bool) {
    updateBarButtonItems(isEnabled: !isHidden)
    editBarButtonItem?.tintColor = isHidden ? .clear : .mountainMeadowColor
    addBarButtonItem?.tintColor = isHidden ? .clear : .mountainMeadowColor
  }

  private func updateBarButtonItems(isEnabled: Bool) {
    editBarButtonItem?.isEnabled = isEnabled
    addBarButtonItem?.isEnabled = isEnabled
  }

  private func filterContentForSearchText(_ searchText: String) {
    filteredStudies = activeStudies.filter { (study: ChartIQStudy) -> Bool in
      return study.fullName.lowercased().contains(searchText.lowercased())
    }
    tableView.reloadData()
  }

  private func updateStudy(study: ChartIQStudy) {
    view.startActivityIndicator()
    var parameters = [String: String]()
    study.inputs?.forEach({ input in
      parameters[input.key] = String(describing: input.value)
    })
    study.outputs?.forEach({ output in
      parameters[output.key] = String(describing: output.value)
    })
    study.parameters?.forEach({ param in
      parameters[param.key] = String(describing: param.value)
    })
    chartIQView.setStudy(study.fullName, parameters: parameters)
    updateStudies()
  }

  private func removeActiveStudy(study: ChartIQStudy) {
    view.startActivityIndicator()
    chartIQView.removeStudy(study.fullName)
    updateStudies()
  }

  private func removeActiveStudy(at indexPath: IndexPath) {
    view.startActivityIndicator()
    let deletedStudy = activeStudies[indexPath.row]
    chartIQView.removeStudy(deletedStudy.fullName)
    activeStudies.remove(at: indexPath.row)
    tableView.deleteRows(at: [indexPath], with: .fade)
    updateStudies()
  }

  private func cloneActiveStudy(at indexPath: IndexPath) {
    view.startActivityIndicator()
    let clonedStudy = activeStudies[indexPath.row]
    try? chartIQView.addStudy(clonedStudy.originalName)
    updateStudies()
  }

  // MARK: - Present Controllers Private Methods

  private func presentAllStudiesViewController() {
    guard let controller = UIStoryboard.allStudiesViewController() else { return }
    controller.allStudies = chartIQView.getStudyList()
    controller.didAddStudies = { [weak self] studies in
      guard let self = self else { return }
      studies.forEach({ study in
        try? self.chartIQView.addStudy(study.shortName)
      })
      self.updateStudies()
    }
    let navigationController = NavigationController(rootViewController: controller)
    present(navigationController, animated: true, completion: nil)
  }

  // MARK: - Show Controllers Private Methods

  private func showStudyDetailViewController(with study: ChartIQStudy) {
    guard let controller = UIStoryboard.studyDetailViewController() else { return }
    controller.study = study
    let input = chartIQView.getStudyParameters(study.fullName, type: .inputs)
    let output = chartIQView.getStudyParameters(study.fullName, type: .outputs)
    let parameters = chartIQView.getStudyParameters(study.fullName, type: .parameters)
    controller.inputParameters = input as? [[String: Any]] ?? [[String: Any]]()
    controller.outputParameters = output as? [[String: Any]] ?? [[String: Any]]()
    controller.paramParameters = parameters as? [[String: Any]] ?? [[String: Any]]()
    controller.didRemoveStudy = { [weak self] study in
      guard let self = self else { return }
      self.removeActiveStudy(study: study)
    }
    controller.didSaveStudy = { [weak self] study in
      guard let self = self else { return }
      self.updateStudy(study: study)
    }
    navigationController?.show(controller, sender: nil)
  }

  // MARK: - Private UITableView Helper Methods

  private func getCloneTableAction(at indexPath: IndexPath) -> UITableViewRowAction {
    let cloneActionTitle = locManager.localize(Const.General.cloneTitle)
    let cloneAction = UITableViewRowAction(style: .normal,
                                           title: cloneActionTitle) { [weak self] _, indexPath in
      guard let self = self else { return }
      self.cloneActiveStudy(at: indexPath)
    }
    cloneAction.backgroundColor = .brillianteAzureColor
    return cloneAction
  }

  private func getDeleteTableAction(at indexPath: IndexPath) -> UITableViewRowAction {
    let deleteActionTitle = locManager.localize(Const.General.deleteTitle)
    let deleteAction = UITableViewRowAction(style: .destructive,
                                            title: deleteActionTitle) { [weak self] _, indexPath in
      guard let self = self else { return }
      self.removeActiveStudy(at: indexPath)
    }
    deleteAction.backgroundColor = .coralRedColor
    return deleteAction
  }

  private func getStudyViewModel(at indexPath: IndexPath) -> StudyTableCellViewModel {
    let studies = isFiltering ? filteredStudies : activeStudies
    let study = studies[indexPath.row]
    return StudyTableCellViewModel(study: study)
  }
}

// MARK: - UITableViewDataSource

extension StudiesViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return isFiltering ? filteredStudies.count : activeStudies.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let studyCell = tableView.dequeueReusableCell(withIdentifier: Const.StudyTableCell.cellId,
                                                        for: indexPath) as? StudyTableCell else {
                                                          return UITableViewCell()
    }
    let studyViewModel = getStudyViewModel(at: indexPath)
    studyCell.setupCell(withViewModel: studyViewModel)
    return studyCell
  }

  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
}

// MARK: - UITableViewDelegate

extension StudiesViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let studies = isFiltering ? filteredStudies : activeStudies
    let selectedStudy = studies[indexPath.row]
    showStudyDetailViewController(with: selectedStudy)
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return Const.StudyTableCell.cellHeight
  }

  func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
    let cloneTableAction = getCloneTableAction(at: editActionsForRowAt)
    let deleteTableAction = getDeleteTableAction(at: editActionsForRowAt)
    return [deleteTableAction, cloneTableAction]
  }

  func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
    updateBarButtonItems(isEnabled: false)
  }

  func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
    updateBarButtonItems(isEnabled: true)
  }
}

// MARK: - UISearchResultsUpdating

extension StudiesViewController: UISearchResultsUpdating {

  func updateSearchResults(for searchController: UISearchController) {
    guard let searchedText = searchController.searchBar.text else { return }
    filterContentForSearchText(searchedText)
  }
}
