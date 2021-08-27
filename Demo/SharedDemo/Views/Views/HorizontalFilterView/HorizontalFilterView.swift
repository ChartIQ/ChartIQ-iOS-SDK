//
//  HorizontalFilterView.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - HorizontalFilterView Protocol

protocol HorizontalFilterViewDelegate: AnyObject {
  func horizontalFilterView(_ horizontalFilterView: HorizontalFilterView, didSelect item: String)
}

// MARK: - HorizontalFilter View

class HorizontalFilterView: UIView {

  // MARK: - IBOutlets

  @IBOutlet private var collectionView: UICollectionView!

  // MARK: - Private Properties

  private weak var delegate: HorizontalFilterViewDelegate?
  private var dataSource: [String] = []

  // MARK: - View Lifecycle Methods

  static func instantiate(with delegate: HorizontalFilterViewDelegate? = nil) -> HorizontalFilterView {
    let view: HorizontalFilterView = HorizontalFilterView.loadFromNib()
    view.delegate = delegate
    return view
  }

  override func awakeFromNib() {
    super.awakeFromNib()

    backgroundColor = .ghostWhiteСhineseBlackColor

    collectionView.register(nibName: Const.FilterCollectionCell.cellNibName,
                            cellId: Const.FilterCollectionCell.cellId)
    collectionView.dataSource = self
    collectionView.delegate = self
  }

  // MARK: - Internal Methods

  internal func updateView(withDataSource dataSource: [String]) {
    setDataSource(dataSource)
  }

  internal func setSelectedItem(item selectedItem: String) {
    if dataSource.contains(selectedItem), let index = dataSource.firstIndex(of: selectedItem) {
      let selectedIndexPath = IndexPath(item: index, section: 0)
      collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
  }

  // MARK: - Private Methods

  private func setDataSource(_ newDataSource: [String]) {
    dataSource = newDataSource
    collectionView.reloadData()
  }

  private func calculateCellSize(at indexPath: IndexPath) -> CGSize {
    let selectedItem = dataSource[indexPath.row]
    let dynamicCellSize = selectedItem.size(withAttributes: [
      NSAttributedString.Key.font: Const.FilterCollectionCell.cellTitleFont
    ])
    let dynamicCellWidth = dynamicCellSize.width + Const.HorizontalFilterView.filterCellMargin * 2
    let dynamicCellHeight = Const.HorizontalFilterView.filterCellHeight
    return CGSize(width: dynamicCellWidth, height: dynamicCellHeight)
  }
}

// MARK: - UICollectionViewDataSource

extension HorizontalFilterView: UICollectionViewDataSource {

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return dataSource.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let filterCell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.FilterCollectionCell.cellId,
                                                              for: indexPath) as? FilterCollectionCell else {
                                                                return UICollectionViewCell()
    }
    let filterItem = dataSource[indexPath.row]
    let localizedItem = LocalizationManager.shared().localize(filterItem)
    let filterItemName = localizedItem.capitalized
    filterCell.setupCell(withFilterItem: filterItemName)
    return filterCell
  }
}

// MARK: - UICollectionViewDelegate

extension HorizontalFilterView: UICollectionViewDelegate {

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let selectedItem = dataSource[indexPath.row]
    delegate?.horizontalFilterView(self, didSelect: selectedItem)
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HorizontalFilterView: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    return calculateCellSize(at: indexPath)
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return Const.HorizontalFilterView.collectionViewEdgeInsets
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return Const.HorizontalFilterView.collectionViewMinimumLineSpacing
  }
}
