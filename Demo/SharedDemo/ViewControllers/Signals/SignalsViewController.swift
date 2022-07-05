//
//  SignalsViewController.swift
//  ChartIQDemo
//
//  Copyright 2012-2022 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - Signals ViewController

class SignalsViewController: BaseViewController {

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
  private var signals: [ChartIQSignal] = []
  private let locManager = LocalizationManager.shared()

  // MARK: - ViewController Lifecycle Methods

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    updateSignals()
  }

  override func languageDidChange() {
    navigationItem.title = locManager.localize(Const.Signals.screenTitle)
    emptyStateViewLabel.text = locManager.localize(Const.Signals.emptyStateViewTitle)
    emptyStateViewButton.setTitle(locManager.localize(Const.Signals.emptyStateViewButtonTitle), for: .normal)
    addBarButtonItem?.title = locManager.localize(Const.General.addTitle)
    cancelBarButtonItem?.title = locManager.localize(Const.General.cancelTitle)
    tableView.reloadData()
  }

  // MARK: - Setup Methods

  override func setupUI() {
    navigationItem.title = locManager.localize(Const.Signals.screenTitle)

    tableView.alpha = .invisible
    tableView.backgroundColor = .whiteDarkGunmetalColor

    emptyStateView.alpha = .invisible
    emptyStateView.backgroundColor = .whiteDarkGunmetalColor
    emptyStateViewLabel.text = locManager.localize(Const.Signals.emptyStateViewTitle)
    emptyStateViewLabel.textColor = .cadetBlueColor
    emptyStateViewButton.setTitle(locManager.localize(Const.Signals.emptyStateViewButtonTitle), for: .normal)
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
    tableView.register(nibName: Const.ToggleTableCell.cellNibName, cellId: Const.ToggleTableCell.cellId)
    tableView.delegate = self
    tableView.dataSource = self
  }

  // MARK: - Actions Methods

  @objc private func cancelButtonTapped() {
    dismiss(animated: true, completion: nil)
  }

  @objc private func addButtonTapped() {
    presentSignalDetailViewController()
  }

  @IBAction private func emptyStateAddSignalButtonTapped(_ sender: Any) {
    presentSignalDetailViewController()
  }

  // MARK: - Private Methods

  private func updateSignals() {
    view.startActivityIndicator()
    signals = chartIQView.getActiveSignals()
    let isEmpty = signals.isEmpty
    if isEmpty {
      updateBarButtonItems(isHidden: true)
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

  private func removeActiveSignal(at indexPath: IndexPath) {
    view.startActivityIndicator()
    let deletedSignal = signals[indexPath.row]
    chartIQView.removeSignal(deletedSignal)
    signals.remove(at: indexPath.row)
    tableView.deleteRows(at: [indexPath], with: .fade)
    updateSignals()
  }

  private func updateSelectedToggle(with toggleDisclosureViewModel: ToggleDisclosureTableCellViewModel,
                                    at indexPath: IndexPath) {
    toggleDisclosureViewModel.isToggleOn.toggle()
    let toggledSignal = signals[indexPath.row]
    chartIQView.toggleSignal(toggledSignal)
  }

  // MARK: - Present Controllers Private Methods

  private func presentSignalDetailViewController() {
    guard let controller = UIStoryboard.signalDetailViewController() else { return }
    controller.signalDetailType = .createSignal
    controller.chartIQView = chartIQView
    controller.didSaveSignal = { [weak self] signal, isEdit in
      guard let self = self else { return }
      self.chartIQView.saveSignal(signal, isEdit: isEdit)
      self.updateSignals()
    }
    let navigationController = NavigationController(rootViewController: controller)
    present(navigationController, animated: true, completion: nil)
  }

  // MARK: - Show Controllers Private Methods

  private func showSignalDetailViewController(with signal: ChartIQSignal) {
    guard let controller = UIStoryboard.signalDetailViewController() else { return }
    controller.signalDetailType = .editSignal
    controller.chartIQView = chartIQView
    controller.signal = signal
    controller.didSaveSignal = { [weak self] signal, isEdit in
      guard let self = self else { return }
      self.chartIQView.saveSignal(signal, isEdit: isEdit)
      self.updateSignals()
    }
    navigationController?.pushViewController(controller, animated: true)
  }

  // MARK: - Private UITableView Helper Methods

  private func getDeleteTableAction(at indexPath: IndexPath) -> UITableViewRowAction {
    let deleteActionTitle = locManager.localize(Const.General.deleteTitle)
    let deleteAction = UITableViewRowAction(style: .destructive,
                                            title: deleteActionTitle) { [weak self] _, indexPath in
      self?.removeActiveSignal(at: indexPath)
    }
    deleteAction.backgroundColor = .coralRedColor
    return deleteAction
  }
}

// MARK: - UITableViewDataSource

extension SignalsViewController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    signals.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let toggleCell = tableView.dequeueReusableCell(withIdentifier: Const.ToggleTableCell.cellId,
                                                         for: indexPath) as? ToggleTableCell else {
      return UITableViewCell()
    }
    let signalModel = signals[indexPath.row]
    let toggleDisclosureViewModel = ToggleDisclosureTableCellViewModel(signal: signalModel)
    toggleCell.setupCell(withViewModel: toggleDisclosureViewModel)
    toggleCell.didChangeToggle = { [weak self] _ in
      self?.updateSelectedToggle(with: toggleDisclosureViewModel, at: indexPath)
    }
    return toggleCell
  }
}

// MARK: - UITableViewDelegate

extension SignalsViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedSignal = signals[indexPath.row]
    showSignalDetailViewController(with: selectedSignal)
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return Const.ConditionTableCell.cellHeight
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
