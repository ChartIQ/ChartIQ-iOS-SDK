//
//  SearchSymbolsViewController.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - SearchSymbols ViewController

class SearchSymbolsViewController: BaseViewController {

  // MARK: - IBOutlets

  @IBOutlet private var emptyStateView: UIView!
  @IBOutlet private var emptyStateViewTitleLabel: UILabel!
  @IBOutlet private var emptyStateViewDescriptionLabel: UILabel!
  @IBOutlet private var emptyStateViewButton: UIButton!
  @IBOutlet private var tableView: UITableView!

  // MARK: - Internal Properties

  internal var didSelectSymbol: ((SymbolModel) -> Void)?

  // MARK: - Private Properties

  private var cancelBarButtonItem: UIBarButtonItem?
  private var symbols: [SymbolModel] = []
  private let searchController = CustomSearchController(searchResultsController: nil)
  private let searchSymbolsService = SearchSymbolsService()
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
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    searchController.isActive = true
  }

  // MARK: - Setup Methods

  override func setupUI() {
    tableView.alpha = .invisible
    tableView.backgroundColor = .ghostWhiteСhineseBlackColor
    cancelBarButtonItem = UIBarButtonItem(title: locManager.localize(Const.General.cancelTitle),
                                          style: .plain,
                                          target: self,
                                          action: #selector(cancelButtonTapped))
    navigationItem.rightBarButtonItem = cancelBarButtonItem
    searchController.defaultConfiguration()

    emptyStateView.alpha = .invisible
    emptyStateView.backgroundColor = .whiteDarkGunmetalColor
    emptyStateViewTitleLabel.textColor = .cadetBlueColor
    emptyStateViewDescriptionLabel.textColor = .cadetBlueColor
    emptyStateViewButton.setTitle(locManager.localize(Const.SearchSymbols.emptyStateViewButtonTitle), for: .normal)
    emptyStateViewButton.setTitleColor(.white, for: .normal)
    emptyStateViewButton.backgroundColor = .mountainMeadowColor
    emptyStateViewButton.layer.cornerRadius = 6
  }

  override func setupSettings() {
    tableView.register(nibName: Const.SymbolTableCell.cellNibName, cellId: Const.SymbolTableCell.cellId)
    tableView.delegate = self
    tableView.dataSource = self

    searchController.delegate = self
    searchController.searchResultsUpdater = self
    definesPresentationContext = true

    updateSearchBar(isHidden: false)
    updateSymbols()
  }

  override func languageDidChange() {
    cancelBarButtonItem?.title = locManager.localize(Const.General.cancelTitle)
    emptyStateViewButton.setTitle(locManager.localize(Const.SearchSymbols.emptyStateViewButtonTitle), for: .normal)
    updateSymbols()
  }

  // MARK: - Actions Methods

  @IBAction private func emptyStateApplySymbolButtonAction(_ sender: Any) {
    if let symbolString = searchController.searchBar.text {
      let symbol = SymbolModel(name: symbolString, fullName: symbolString, exchange: symbolString)
      searchController.dismiss(animated: false) {
        self.didSelectSymbol?(symbol)
        self.dismiss(animated: true, completion: nil)
      }
    }
  }

  @objc private func cancelButtonTapped() {
    if searchController.isActive {
      searchController.dismiss(animated: false) {
        self.dismiss(animated: true, completion: nil)
      }
    } else {
      dismiss(animated: true, completion: nil)
    }
  }

  // MARK: - Private Methods

  private func updateSymbols() {
    tableView.reloadData()
    var isEmpty = false
    let isEnteredTextEmpty = searchController.searchBar.text?.isEmpty ?? true
    let isSearchedResultsEmpty = symbols.isEmpty
    if isEnteredTextEmpty {
      isEmpty = true
      emptyStateViewTitleLabel.text = locManager.localize(Const.SearchSymbols.emptyStateTitle)
      emptyStateViewDescriptionLabel.text = ""
      emptyStateViewButton.isHidden = true
    } else if !isEnteredTextEmpty && isSearchedResultsEmpty {
      isEmpty = true
      let emptyStateNotFoundTitle = locManager.localize(Const.SearchSymbols.emptyStateNotFoundTitle)
      let emptyStateNotFoundDescription = locManager.localize(Const.SearchSymbols.emptyStateNotFoundDescription)
      emptyStateViewTitleLabel.text = emptyStateNotFoundTitle
      emptyStateViewDescriptionLabel.text = emptyStateNotFoundDescription
      emptyStateViewButton.isHidden = false
    }
    UIView.animate(withDuration: AnimationTime.quiteFast.rawValue) {
      self.emptyStateView.alpha = isEmpty ? .visible : .invisible
      self.tableView.alpha = isEmpty ? .invisible : .visible
    }
  }

  private func updateSearchBar(isHidden: Bool) {
    searchController.searchBar.showsCancelButton = false
    navigationItem.titleView = isHidden ? nil : searchController.searchBar
  }

  private func searchContentForSearchText(_ searchText: String) {
    let formattedSearchText = searchText.trimmingCharacters(in: .whitespaces)
    searchSymbolsService.search(with: formattedSearchText) { [weak self] symbols in
      guard let self = self else { return }
      DispatchQueue.main.async {
        self.symbols = symbols
        self.updateSymbols()
      }
    }
  }
}

// MARK: - UITableViewDataSource

extension SearchSymbolsViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return symbols.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let symbolCell = tableView.dequeueReusableCell(withIdentifier: Const.SymbolTableCell.cellId,
                                                         for: indexPath) as? SymbolTableCell else {
                                                          return UITableViewCell()
    }
    let symbol = symbols[indexPath.row]
    symbolCell.setupCell(with: symbol)
    return symbolCell
  }
}

// MARK: - UITableViewDelegate

extension SearchSymbolsViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let symbol = symbols[indexPath.row]
    searchController.dismiss(animated: false) {
      self.didSelectSymbol?(symbol)
      self.dismiss(animated: true, completion: nil)
    }
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
}

// MARK: - UISearchResultsUpdating

extension SearchSymbolsViewController: UISearchResultsUpdating {

  func updateSearchResults(for searchController: UISearchController) {
    guard let searchedText = searchController.searchBar.text else { return }
    searchContentForSearchText(searchedText)
  }
}

// MARK: - UISearchControllerDelegate

extension SearchSymbolsViewController: UISearchControllerDelegate {

  func presentSearchController(_ searchController: UISearchController) {
    searchController.searchBar.becomeFirstResponder()
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
      searchController.searchBar.becomeFirstResponder()
    }
  }
}

// MARK: - CustomSearchController with CustomSearchBar
/// Needs to resolve native issue with not hiding cancel button on different iOS versions.

class CustomSearchBar: UISearchBar {

  override func setShowsCancelButton(_ showsCancelButton: Bool, animated: Bool) {
    super.setShowsCancelButton(false, animated: false)
  }
}

class CustomSearchController: UISearchController, UISearchBarDelegate {

  lazy var customSearchBar: CustomSearchBar = { [weak self] in
    let customSearchBar = CustomSearchBar(frame: CGRect.zero)
    return customSearchBar
    }()

  override var searchBar: UISearchBar {
    return customSearchBar
  }
}
