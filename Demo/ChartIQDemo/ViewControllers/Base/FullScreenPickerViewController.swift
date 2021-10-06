//
//  FullScreenPickerViewController.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - FullScreenPickerType Enum

enum FullScreenPickerType {
  case color
  case line
}

// MARK: - FullScreenPicker ViewController

class FullScreenPickerViewController: BaseViewController {

  // MARK: - IBOutlets

  @IBOutlet private var collectionView: UICollectionView!

  // MARK: - Internal Properties

  internal var pickerType: FullScreenPickerType = .color
  internal var selectedPickerViewItem: PickerViewItem?
  internal var didSelectPickerViewItem: ((PickerViewItem) -> Void)?

  // MARK: - Private Properties

  private var cancelBarButtonItem: UIBarButtonItem?
  private var colors: [UIColor] = []
  private var lines: [LineModel] = []
  private let locManager = LocalizationManager.shared()

  // MARK: - ViewController Lifecycle Methods

  override func viewDidLoad() {
    super.viewDidLoad()

    setupColorsAndLines()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    updateSelectedPickerViewItem()
  }

  override func languageDidChange() {
    switch pickerType {
    case .color:
      navigationItem.title = locManager.localize(Const.FullScreenPicker.selectColorScreenTitle)
    case .line:
      navigationItem.title = locManager.localize(Const.FullScreenPicker.selectLineScreenTitle)
    }
    cancelBarButtonItem?.title = locManager.localize(Const.General.cancelTitle)
  }

  // MARK: - Setup Methods

  override func setupUI() {
    switch pickerType {
    case .color:
      navigationItem.title = locManager.localize(Const.FullScreenPicker.selectColorScreenTitle)
    case .line:
      navigationItem.title = locManager.localize(Const.FullScreenPicker.selectLineScreenTitle)
    }

    collectionView.backgroundColor = .whiteDarkGunmetalColor

    cancelBarButtonItem = UIBarButtonItem(title: locManager.localize(Const.General.cancelTitle),
                                          style: .plain,
                                          target: self,
                                          action: #selector(cancelButtonTapped))
    navigationItem.leftBarButtonItem = cancelBarButtonItem
  }

  override func setupSettings() {
    collectionView.register(nibName: Const.ColorPickerCollectionCell.cellNibName,
                            cellId: Const.ColorPickerCollectionCell.cellId)
    collectionView.register(nibName: Const.LinePickerCollectionCell.cellNibName,
                            cellId: Const.LinePickerCollectionCell.cellId)
    collectionView.dataSource = self
    collectionView.delegate = self

    let layout = UICollectionViewFlowLayout()
    collectionView.setCollectionViewLayout(layout, animated: true)
  }

  private func setupColorsAndLines() {
    colors = UIColor.allColors()
    lines = LineModel.allLines()

    collectionView.reloadData()
    updateSelectedPickerViewItem()
  }

  // MARK: - Actions Methods

  @objc private func cancelButtonTapped() {
    dismiss(animated: true, completion: nil)
  }

  // MARK: - Private Methods

  private func updateSelectedPickerViewItem() {
    if let color = selectedPickerViewItem?.selectedColor {
      setSelectedColor(color: color)
    } else if let line = selectedPickerViewItem?.selectedLine {
      setSelectedLine(line: line)
    }
  }

  private func setSelectedColor(color selectedColor: UIColor) {
    if colors.contains(selectedColor), let index = colors.firstIndex(of: selectedColor) {
      let selectedIndexPath = IndexPath(item: index, section: 0)
      collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
  }

  private func setSelectedLine(line selectedLine: LineModel) {
    if lines.contains(selectedLine), let index = lines.firstIndex(of: selectedLine) {
      let selectedIndexPath = IndexPath(item: index, section: 0)
      collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
  }

  private func selectPickerViewItem(item pickerViewItem: PickerViewItem) {
    didSelectPickerViewItem?(pickerViewItem)
    dismiss(animated: true, completion: nil)
  }
}

// MARK: - UICollectionViewDataSource

extension FullScreenPickerViewController: UICollectionViewDataSource {

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch pickerType {
    case .color:
      return colors.count
    case .line:
      return lines.count
    }
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch pickerType {
    case .color:
      guard let colorCell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.ColorPickerCollectionCell.cellId,
                                                               for: indexPath) as? ColorPickerCollectionCell else {
                                                                return UICollectionViewCell()
      }
      let color = colors[indexPath.row]
      colorCell.setupCell(withColor: color)
      return colorCell
    case .line:
      guard let lineCell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.LinePickerCollectionCell.cellId,
                                                              for: indexPath) as? LinePickerCollectionCell else {
                                                                return UICollectionViewCell()
      }
      let lineModel = lines[indexPath.row]
      lineCell.setupCell(withLineImage: lineModel.lineImage)
      return lineCell
    }
  }
}

// MARK: - UICollectionViewDelegate

extension FullScreenPickerViewController: UICollectionViewDelegate {

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    switch pickerType {
    case .color:
      let selectedColor = colors[indexPath.row]
      let pickerViewItem = PickerViewItem(selectedColor: selectedColor, selectedLine: nil)
      selectPickerViewItem(item: pickerViewItem)
    case .line:
      let selectedLine = lines[indexPath.row]
      let pickerViewItem = PickerViewItem(selectedColor: nil, selectedLine: selectedLine)
      selectPickerViewItem(item: pickerViewItem)
    }
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FullScreenPickerViewController: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    switch pickerType {
    case .color:
      return Const.FullScreenPicker.colorPickerCellSize
    case .line:
      return Const.FullScreenPicker.linePickerCellSize
    }
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return Const.FullScreenPicker.collectionViewEdgeInsets
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return Const.FullScreenPicker.collectionViewMinimumSpacing
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return Const.FullScreenPicker.collectionViewMinimumSpacing
  }
}
