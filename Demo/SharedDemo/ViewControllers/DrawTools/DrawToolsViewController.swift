//
//  DrawToolsViewController.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - DrawTools ViewController

class DrawToolsViewController: BaseViewController {

  // MARK: - TableSection Enum

  enum TableSection: Int, CaseIterable {
    case first = 0, second, total
  }

  // MARK: - IBOutlets

  @IBOutlet private var horizontalFilterViewContainer: UIView!
  @IBOutlet private var horizontalFilterSeparatorView: UIView!
  @IBOutlet private var emptyStateView: UIView!
  @IBOutlet private var emptyStateViewTitleLabel: UILabel!
  @IBOutlet private var emptyStateViewDescriptionLabel: UILabel!
  @IBOutlet private var tableView: UITableView!

  // MARK: - Internal Properties

  internal var selectedDrawTool: DrawToolViewModel?
  internal var didSelectDrawTool: ((DrawToolViewModel) -> Void)?
  internal var didClearAllDrawings: (() -> Void)?
  internal var didRestoreToDefaults: (() -> Void)?

  // MARK: - Private Properties

  private var cancelBarButtonItem: UIBarButtonItem?
  private let optionsButton = UIButton(type: .custom)
  private var horizontalFilterView: HorizontalFilterView?
  private var selectedFilterType: DrawToolFilterType = .all
  private var drawTools: [TableSection: [DrawToolViewModel]] = [:]
  private var favoritesDrawingTools: [ChartIQDrawingTool] = []
  private let locManager = LocalizationManager.shared()

  // MARK: - ViewController Lifecycle Methods

  override func viewDidLoad() {
    super.viewDidLoad()

    setupFavoriteDrawingTools()
    setupHorizontalFilterView()
    updateDrawToolsViewModels()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    updateSelectedDrawTool(scrollPosition: .top)
  }

  override func languageDidChange() {
    navigationItem.title = locManager.localize(Const.DrawTools.screenTitle)
    cancelBarButtonItem?.title = locManager.localize(Const.General.cancelTitle)
    emptyStateViewTitleLabel.text = locManager.localize(Const.DrawTools.emptyStateTitle)
    emptyStateViewDescriptionLabel.text = locManager.localize(Const.DrawTools.emptyStateDescription)
    updateDrawToolsViewModels()
  }

  // MARK: - Setup Methods

  override func setupUI() {
    navigationItem.title = locManager.localize(Const.DrawTools.screenTitle)

    horizontalFilterSeparatorView.backgroundColor = .gainsboroDarkYankeesBlueColor
    tableView.backgroundColor = .ghostWhiteСhineseBlackColor

    cancelBarButtonItem = UIBarButtonItem(title: locManager.localize(Const.General.cancelTitle),
                                          style: .plain,
                                          target: self,
                                          action: #selector(cancelButtonTapped))
    optionsButton.frame = CGRect(origin: .zero, size: Const.ChartButton.circleButtonSize)
    optionsButton.setImage(UIImage.DrawTools.moreOptionsImage, for: .normal)
    optionsButton.addTarget(self, action: #selector(optionsButtonTapped), for: .touchUpInside)
    navigationItem.leftBarButtonItem = cancelBarButtonItem
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: optionsButton)

    emptyStateView.backgroundColor = .whiteDarkGunmetalColor
    emptyStateViewTitleLabel.textColor = .cadetBlueColor
    emptyStateViewDescriptionLabel.textColor = .cadetBlueColor
    emptyStateViewTitleLabel.text = locManager.localize(Const.DrawTools.emptyStateTitle)
    emptyStateViewDescriptionLabel.text = locManager.localize(Const.DrawTools.emptyStateDescription)
    updateEmptyStateView(hidden: true)
  }

  override func setupSettings() {
    tableView.register(nibName: Const.DrawToolTableCell.cellNibName, cellId: Const.DrawToolTableCell.cellId)
    tableView.delegate = self
    tableView.dataSource = self
  }

  private func setupFavoriteDrawingTools() {
    favoritesDrawingTools = retrieveFavorites()
  }

  private func setupHorizontalFilterView() {
    horizontalFilterView = HorizontalFilterView.instantiate(with: self)
    horizontalFilterView?.adjustFrame(inView: horizontalFilterViewContainer)
    let filterItems = retrieveFilterItems()
    horizontalFilterView?.updateView(withDataSource: filterItems)
    horizontalFilterView?.setSelectedItem(item: selectedFilterType.displayName)
  }

  // MARK: - Actions Methods

  @objc private func cancelButtonTapped() {
    dismiss(animated: true, completion: nil)
  }

  @objc private func optionsButtonTapped() {
    showMoreOptionsAlert()
  }

  // MARK: - Private Methods

  private func retrieveFilterItems() -> [String] {
    var filterItems: [String] = []
    for filterType in DrawToolFilterType.allCases {
      filterItems.append(filterType.displayName)
    }
    return filterItems
  }

  private func updateDrawToolsViewModels() {
    var customDrawToolViewModels: [DrawToolViewModel] = []
    var drawToolViewModels: [DrawToolViewModel] = []
    if selectedFilterType == .all {
      updateEmptyStateView(hidden: true)
      customDrawToolViewModels = getCustomDrawToolViewModels()
      drawToolViewModels = getFiltredDrawToolViewModels()
    } else if selectedFilterType == .favorites {
      updateEmptyStateView(hidden: !favoritesDrawingTools.isEmpty)
      drawToolViewModels = getFavoriteDrawToolViewModels()
    } else {
      updateEmptyStateView(hidden: true)
      drawToolViewModels = getFiltredDrawToolViewModels()
    }

    drawTools = [
      .first: customDrawToolViewModels,
      .second: drawToolViewModels
    ]

    tableView.reloadData()
    updateSelectedDrawTool(scrollPosition: .top)
  }

  private func updateSelectedDrawTool(scrollPosition: UITableView.ScrollPosition) {
    guard let selectedDrawTool = selectedDrawTool else { return }
    let sectionsCount = getSectionsCount()
    for index in 0..<sectionsCount {
      guard let tableSection = getTableSection(index) else { return }
      let drawToolsViewModels = drawTools[tableSection]
      let tableIndex = drawToolsViewModels?.firstIndex { selectedDrawTool.displayName == $0.displayName }
      if let tableIndex = tableIndex {
        let selectedIndexPath = IndexPath(item: tableIndex, section: index)
        tableView.selectRow(at: selectedIndexPath, animated: true, scrollPosition: scrollPosition)
      }
    }
  }

  private func updateEmptyStateView(hidden isHidden: Bool) {
    emptyStateView.alpha = isHidden ? .invisible : .visible
    tableView.alpha = isHidden ? .visible : .invisible
  }

  private func getCustomDrawToolViewModels() -> [DrawToolViewModel] {
    let customDrawToolViewModels = [
      DrawToolViewModel(drawingTool: ChartIQDrawingTool.measure, isInFavorites: false)
    ]
    return customDrawToolViewModels
  }

  private func getFiltredDrawToolViewModels() -> [DrawToolViewModel] {
    var drawToolViewModels: [DrawToolViewModel] = []
    for index in 0...ChartIQDrawingTool.volumeProfile.rawValue {
      if let drawingTool = ChartIQDrawingTool(rawValue: index) {
        let isInFavorites = isDrawToolInFavorites(drawingTool)
        let drawToolViewModel = DrawToolViewModel(drawingTool: drawingTool, isInFavorites: isInFavorites)
        drawToolViewModels.append(drawToolViewModel)
      }
    }
    if selectedFilterType != .all {
      drawToolViewModels = drawToolViewModels.filter { drawToolViewModel -> Bool in
        drawToolViewModel.drawingTool?.type == selectedFilterType.drawingToolType
      }
    }
    return drawToolViewModels
  }

  // MARK: - Private Favorites Methods

  private func retrieveFavorites() -> [ChartIQDrawingTool] {
    var favorites: [ChartIQDrawingTool] = []
    let defaults = UserDefaults.standard
    if let favoriteToolNames = defaults.array(forKey: Const.UserDefaults.favoriteDrawingToolsKey) as? [String] {
      for drawingToolName in favoriteToolNames {
        if let drawingTool = ChartIQDrawingTool(stringValue: drawingToolName) {
          favorites.append(drawingTool)
        }
      }
    }
    return favorites
  }

  private func saveFavorites() {
    var favoritesDrawingToolNames: [String] = []
    let defaults = UserDefaults.standard
    for drawingTool in favoritesDrawingTools {
      favoritesDrawingToolNames.append(drawingTool.stringValue)
    }
    defaults.set(favoritesDrawingToolNames, forKey: Const.UserDefaults.favoriteDrawingToolsKey)
  }

  private func getFavoriteDrawToolViewModels() -> [DrawToolViewModel] {
    var favoriteDrawToolViewModels: [DrawToolViewModel] = []
    for drawingTool in favoritesDrawingTools {
      let drawToolViewModel = DrawToolViewModel(drawingTool: drawingTool, isInFavorites: true)
      favoriteDrawToolViewModels.append(drawToolViewModel)
    }
    return favoriteDrawToolViewModels
  }

  private func isDrawToolInFavorites(_ drawingTool: ChartIQDrawingTool) -> Bool {
    return favoritesDrawingTools.contains { favDrawToolViewModel -> Bool in
      favDrawToolViewModel == drawingTool
    }
  }

  private func addToFavorites(_ drawingTool: ChartIQDrawingTool) {
    favoritesDrawingTools.append(drawingTool)
    saveFavorites()
    updateDrawToolsViewModels()
  }

  private func removeFromFavorites(_ drawingTool: ChartIQDrawingTool) {
    favoritesDrawingTools.removeAll { $0 == drawingTool }
    saveFavorites()
    updateDrawToolsViewModels()
  }

  // MARK: - Private Alert Methods

  private func showMoreOptionsAlert() {
    let restoreTitle = locManager.localize(Const.DrawTools.restoreParametersActionTitle)
    let clearTitle = locManager.localize(Const.DrawTools.clearDrawingsActionTitle)
    let restoreAction = UIAlertAction(title: restoreTitle, style: .default) { _ in
      self.showRestoreDefaultsConfirmationAlert()
    }
    let clearAction = UIAlertAction(title: clearTitle, style: .destructive) { _ in
      self.showClearDrawingsConfirmationAlert()
    }
    showActionSheet(sourceView: optionsButton, actions: [restoreAction, clearAction])
  }

  private func showClearDrawingsConfirmationAlert() {
    let clearTitle = locManager.localize(Const.DrawTools.clearDrawingsAlertTitle)
    let clearMessage = locManager.localize(Const.DrawTools.clearDrawingsAlertMessage)
    let clearActionTitle = locManager.localize(Const.General.clearTitle)
    let clearAction = UIAlertAction(title: clearActionTitle, style: .destructive) { _ in
      self.didClearAllDrawings?()
      self.dismiss(animated: true, completion: nil)
    }
    showAlert(title: clearTitle, message: clearMessage, actions: [clearAction])
  }

  private func showRestoreDefaultsConfirmationAlert() {
    let restoreTitle = locManager.localize(Const.DrawTools.restoreDefaultsAlertTitle)
    let restoreMessage = locManager.localize(Const.DrawTools.restoreDefaultsAlertMessage)
    let restoreActionTitle = locManager.localize(Const.General.restoreTitle)
    let restoreAction = UIAlertAction(title: restoreActionTitle, style: .destructive) { _ in
      self.didRestoreToDefaults?()
      self.dismiss(animated: true, completion: nil)
    }
    showAlert(title: restoreTitle, message: restoreMessage, actions: [restoreAction])
  }

  // MARK: - Private UITableView Helper Methods

  private func getSectionsCount() -> Int {
    let filterSections = selectedFilterType == .all ? 2 : 1
    return filterSections
  }

  private func getFilterSection(_ section: Int) -> Int {
    let filteredTableSection = selectedFilterType == .all ? section : section + 1
    return filteredTableSection
  }

  private func getTableSection(_ section: Int) -> TableSection? {
    let section = getFilterSection(section)
    return TableSection(rawValue: section)
  }

  private func getDrawToolViewModel(at indexPath: IndexPath) -> DrawToolViewModel? {
    if let tableSection = getTableSection(indexPath.section),
      let drawToolViewModel = drawTools[tableSection]?[indexPath.row] {
      return drawToolViewModel
    }
    return nil
  }

  private func getAddTableAction(_ drawingTool: ChartIQDrawingTool) -> UITableViewRowAction {
    let localizedAddActionTitle = locManager.localize(Const.General.addTitle)
    let addActionTitle = "\(Const.General.filledStarSymbol) \(localizedAddActionTitle)"
    let addAction = UITableViewRowAction(style: .normal, title: addActionTitle) { [weak self] _, _ in
      self?.addToFavorites(drawingTool)
    }
    addAction.backgroundColor = .brillianteAzureColor
    return addAction
  }

  private func getRemoveTableAction(_ drawingTool: ChartIQDrawingTool) -> UITableViewRowAction {
    let localizedRemoveActionTitle = locManager.localize(Const.General.removeTitle)
    let removeActionTitle = "\(Const.General.unfilledStarSymbol) \(localizedRemoveActionTitle)"
    let removeAction = UITableViewRowAction(style: .destructive, title: removeActionTitle) { [weak self] _, _ in
      self?.removeFromFavorites(drawingTool)
    }
    removeAction.backgroundColor = .brillianteAzureColor
    return removeAction
  }
}

// MARK: - UITableViewDataSource

extension DrawToolsViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return getSectionsCount()
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let tableSection = getTableSection(section) else { return 0 }
    return drawTools[tableSection]?.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let drawToolViewModel = getDrawToolViewModel(at: indexPath),
      let drawToolCell = tableView.dequeueReusableCell(withIdentifier: Const.DrawToolTableCell.cellId,
                                                       for: indexPath) as? DrawToolTableCell else {
                                                        return UITableViewCell()
    }
    drawToolCell.setupCell(withViewModel: drawToolViewModel)
    return drawToolCell
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    guard let tableSection = getTableSection(section) else { return nil }
    let sectionTitle = tableSection == .first ? Const.DrawTools.otherToolsTitle : Const.DrawTools.mainToolsTitle
    return locManager.localize(sectionTitle)
  }

  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    guard let tableSection = getTableSection(indexPath.section) else { return false }
    return tableSection == .first ? false : true
  }
}

// MARK: - UITableViewDelegate

extension DrawToolsViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let cell = tableView.cellForRow(at: indexPath) { cell.accessoryType = .checkmark }
    guard let drawToolViewModel = getDrawToolViewModel(at: indexPath) else { return }
    didSelectDrawTool?(drawToolViewModel)
    dismiss(animated: true, completion: nil)
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return Const.BaseTableCell.cellHeight
  }

  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return Const.DrawTools.headerHeight
  }

  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return Const.DrawTools.footerHeight
  }

  func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
    guard let drawToolViewModel = getDrawToolViewModel(at: editActionsForRowAt),
      let isInFavorites = drawToolViewModel.isInFavorites,
      let drawingTool = drawToolViewModel.drawingTool else { return nil }
    let tableAction = isInFavorites ? getRemoveTableAction(drawingTool) : getAddTableAction(drawingTool)
    return [tableAction]
  }

  func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
    updateSelectedDrawTool(scrollPosition: .none)
  }
}

// MARK: - HorizontalFilterViewDelegate

extension DrawToolsViewController: HorizontalFilterViewDelegate {

  func horizontalFilterView(_ horizontalFilterView: HorizontalFilterView, didSelect item: String) {
    guard let drawToolFilterType = DrawToolFilterType(stringValue: item) else { return }
    selectedFilterType = drawToolFilterType
    updateDrawToolsViewModels()
  }
}
