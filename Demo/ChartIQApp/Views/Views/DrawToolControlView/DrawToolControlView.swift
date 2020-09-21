//
//  DrawingToolControlView.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - DrawToolControlViewType Enum

enum DrawToolControlViewType {
  case selectedTool
  case fillColor
  case lineColor
  case lineType
  case clone
  case delete
  case magnet
  case manageLayers
  case settings
}

// MARK: - DrawToolViewModel Protocol

protocol DrawToolViewModelProtocol: class {
  var type: DrawToolControlViewType { get set }
  var image: UIImage? { get set }
}

// MARK: - DrawToolControlView Protocol

protocol DrawToolControlViewDelegate: class {
  func drawingToolControlView(_ drawingToolControlView: DrawToolControlView, didSelectItemAt indexPath: IndexPath)
}

// MARK: - DrawingToolControl View

class DrawToolControlView: UIView {

  // MARK: - IBOutlets

  @IBOutlet private var collectionView: UICollectionView!

  // MARK: - Private Properties

  private weak var delegate: DrawToolControlViewDelegate?

  private var viewModels: [DrawToolViewModelProtocol] = []

  // MARK: - View Lifecycle Methods

  static func instantiate(with delegate: DrawToolControlViewDelegate? = nil) -> DrawToolControlView {
    let view: DrawToolControlView = DrawToolControlView.loadFromNib()
    view.delegate = delegate
    return view
  }

  override func awakeFromNib() {
    super.awakeFromNib()

    backgroundColor = .brightGreyYankeesBlueColor

    collectionView.register(nibName: Const.DrawToolBaseCell.cellNibName, cellId: Const.DrawToolBaseCell.cellId)
    collectionView.register(nibName: Const.DrawToolColorCell.cellNibName, cellId: Const.DrawToolColorCell.cellId)
    collectionView.dataSource = self
    collectionView.delegate = self
  }

  // MARK: - Internal Methods

  internal func updateView(with drawToolViewModels: [DrawToolViewModelProtocol]) {
    viewModels = drawToolViewModels
    collectionView.reloadData()
  }
}

// MARK: - UICollectionViewDataSource

extension DrawToolControlView: UICollectionViewDataSource {

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModels.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let viewModel = viewModels[indexPath.row]
    if let baseViewModel = viewModel as? DrawToolBaseViewModel {
      guard let baseCell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.DrawToolBaseCell.cellId,
                                                              for: indexPath) as? DrawToolBaseCell else {
                                                                return UICollectionViewCell()
      }
      baseCell.setupCell(withViewModel: baseViewModel)
      return baseCell
    }
    if let colorViewModel = viewModel as? DrawToolColorViewModel {
      guard let colorCell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.DrawToolColorCell.cellId,
                                                               for: indexPath) as? DrawToolColorCell else {
                                                                return UICollectionViewCell()
      }
      colorCell.setupCell(withViewModel: colorViewModel)
      return colorCell
    }
    return UICollectionViewCell()
  }
}

// MARK: - UICollectionViewDelegate

extension DrawToolControlView: UICollectionViewDelegate {

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    delegate?.drawingToolControlView(self, didSelectItemAt: indexPath)
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension DrawToolControlView: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    return Const.DrawToolControlView.cellSize
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return Const.DrawToolControlView.collectionViewEdgeInsets
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return Const.DrawToolControlView.collectionViewMinimumLineSpacing
  }
}
