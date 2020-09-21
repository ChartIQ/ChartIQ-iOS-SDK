//
//  HorizontalPickerView.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - HorizontalPickerViewType Enum

enum HorizontalPickerViewType {
  case fillColor
  case lineColor
  case line
}

// MARK: - HorizontalPickerView Protocol

protocol HorizontalPickerViewDelegate: class {
  func horizontalPickerView(_ horizontalPickerView: HorizontalPickerView, didSelect item: PickerViewItem)
}

// MARK: - HorizontalPicker View

class HorizontalPickerView: UIView {

  // MARK: - IBOutlets

  @IBOutlet private var collectionView: UICollectionView!
  @IBOutlet private var topSeparatorView: UIView!

  // MARK: - Internal Properties

  internal var type: HorizontalPickerViewType = .fillColor

  // MARK: - Private Properties

  private weak var delegate: HorizontalPickerViewDelegate?

  private var colors: [UIColor] = []
  private var lines: [LineModel] = []

  // MARK: - View Lifecycle Methods

  static func instantiate(with delegate: HorizontalPickerViewDelegate? = nil) -> HorizontalPickerView {
    let view: HorizontalPickerView = HorizontalPickerView.loadFromNib()
    view.delegate = delegate
    return view
  }

  override func awakeFromNib() {
    super.awakeFromNib()

    backgroundColor = .whiteDarkGunmetalColor
    topSeparatorView.backgroundColor = .brightGreyYankeesBlueColor

    collectionView.register(nibName: Const.ColorPickerCollectionCell.cellNibName,
                            cellId: Const.ColorPickerCollectionCell.cellId)
    collectionView.register(nibName: Const.LinePickerCollectionCell.cellNibName,
                            cellId: Const.LinePickerCollectionCell.cellId)
    collectionView.dataSource = self
    collectionView.delegate = self

    colors = UIColor.allColors()
    lines = LineModel.allLines()
  }

  // MARK: - Internal Methods

  internal func updateView(withType type: HorizontalPickerViewType, color: UIColor? = nil, line: LineModel? = nil) {
    setType(type: type)
    if let color = color {
      setSelectedColor(color: color)
    } else if let line = line {
      setSelectedLine(line: line)
    }
  }

  internal func setType(type horizontalPickerViewType: HorizontalPickerViewType) {
    type = horizontalPickerViewType
    collectionView.reloadData()
  }

  internal func setSelectedColor(color selectedColor: UIColor) {
    if colors.contains(selectedColor), let index = colors.firstIndex(of: selectedColor) {
      let selectedIndexPath = IndexPath(item: index, section: 0)
      collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
  }

  internal func setSelectedLine(line selectedLine: LineModel) {
    if lines.contains(selectedLine), let index = lines.firstIndex(of: selectedLine) {
      let selectedIndexPath = IndexPath(item: index, section: 0)
      collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
  }
}

// MARK: - UICollectionViewDataSource

extension HorizontalPickerView: UICollectionViewDataSource {

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch type {
    case .fillColor, .lineColor:
      return colors.count
    case .line:
      return lines.count
    }
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch type {
    case .fillColor, .lineColor:
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

extension HorizontalPickerView: UICollectionViewDelegate {

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    switch type {
    case .fillColor, .lineColor:
      let selectedColor = colors[indexPath.row]
      let pickerViewItem = PickerViewItem(selectedColor: selectedColor, selectedLine: nil)
      delegate?.horizontalPickerView(self, didSelect: pickerViewItem)
    case .line:
      let selectedLine = lines[indexPath.row]
      let pickerViewItem = PickerViewItem(selectedColor: nil, selectedLine: selectedLine)
      delegate?.horizontalPickerView(self, didSelect: pickerViewItem)
    }
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HorizontalPickerView: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    switch type {
    case .fillColor, .lineColor:
      return Const.HorizontalPickerView.colorPickerCellSize
    case .line:
      return Const.HorizontalPickerView.linePickerCellSize
    }
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return Const.HorizontalPickerView.collectionViewEdgeInsets
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return Const.HorizontalPickerView.collectionViewMinimumLineSpacing
  }
}
