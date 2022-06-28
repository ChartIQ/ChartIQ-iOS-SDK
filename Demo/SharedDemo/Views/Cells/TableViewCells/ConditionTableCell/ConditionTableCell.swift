//
//  ConditionTableCell.swift
//  ChartIQDemo
//
//  Copyright 2012-2022 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - Condition TableCell

class ConditionTableCell: UITableViewCell {

  // MARK: - IBOutlets

  @IBOutlet private var conditionContentView: UIView!
  @IBOutlet private var segemntContentView: UIView!
  @IBOutlet private var titleLabel: UILabel!
  @IBOutlet private var descriptionLabel: UILabel!
  @IBOutlet private var tagMarkView: UIView!
  @IBOutlet private var tagMarkViewLeadingConstraint: NSLayoutConstraint!
  @IBOutlet private var tagMarkViewLabel: UILabel!
  @IBOutlet private var disclosureIndicatorImageView: UIImageView!
  @IBOutlet private var segmentedControl: UISegmentedControl!
  @IBOutlet private var segmentView: UIView!
  @IBOutlet private var segmentViewLabel: UILabel!

  // MARK: - Internal Properties

  internal var didSegmentedControlValueChanged: ((ConditionJoinerType) -> Void)?

  // MARK: - Private Properties

  private let locManager = LocalizationManager.shared()

  // MARK: - View Lifecycle Methods

  override func awakeFromNib() {
    super.awakeFromNib()

    selectionStyle = .none

    conditionContentView.backgroundColor = .whiteDarkGunmetalColor

    titleLabel.textColor = .darkElectricBlueWhiteColor
    titleLabel.font = .systemFont(ofSize: 17, weight: .regular)

    descriptionLabel.textColor = .cadetBlueColor
    descriptionLabel.font = .systemFont(ofSize: 13, weight: .regular)

    tagMarkView.layer.cornerRadius = 4.0
    tagMarkViewLabel.textColor = .whiteColor
    tagMarkViewLabel.font = .systemFont(ofSize: 17, weight: .regular)

    disclosureIndicatorImageView.tintColor = .arsenicBrightGrayMediumColor.withAlphaComponent(0.3)

    segemntContentView.backgroundColor = .ghostWhiteСhineseBlackColor

    segmentView.backgroundColor = .brightGreyDarkGunmetalColor
    segmentView.layer.cornerRadius = 8.0
    segmentViewLabel.textColor = .darkElectricBlueCadetBlueColor
    segmentViewLabel.font = .systemFont(ofSize: 14, weight: .medium)

    segmentedControl.setTitle(ConditionJoinerType.or.title, forSegmentAt: ConditionJoinerType.or.rawValue)
    segmentedControl.setTitle(ConditionJoinerType.and.title, forSegmentAt: ConditionJoinerType.and.rawValue)

    let attributes: [NSAttributedString.Key: Any] = [
      .foregroundColor: UIColor.darkElectricBlueCadetBlueColor,
      .font: UIFont.systemFont(ofSize: 14, weight: .medium)
    ]
    segmentedControl.setTitleTextAttributes(attributes, for: .normal)
    segmentedControl.setTitleTextAttributes(attributes, for: .selected)

    segmentedControl.backgroundColor = .brightGreyDarkGunmetalColor
    if #available(iOS 13.0, *) {
      segmentedControl.selectedSegmentTintColor = .whiteYankeesBlueColor
    } else {
      segmentedControl.tintColor = .whiteYankeesBlueColor
    }

    segmentedControl.removeSegemntedControlShadow()
    segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
  }

  // MARK: - Internal Methods

  internal func setupCell(withViewModel viewModel: TableCellViewModelProtocol) {
    guard let conditionViewModel = viewModel as? ConditionTableCellViewModel else { return }
    titleLabel.text = conditionViewModel.title.capitalizeFirst()
    descriptionLabel.text = conditionViewModel.description

    tagMarkView.backgroundColor = conditionViewModel.color
    tagMarkViewLabel.text = conditionViewModel.tagMark
    segmentViewLabel.text = conditionViewModel.joinerType.title
    segmentedControl.selectedSegmentIndex = conditionViewModel.joinerType.rawValue

    updateSegmentedControlSettings(segmentType: conditionViewModel.segmentType)
    updateAppearanceSettings(segmentType: conditionViewModel.segmentType,
                             joinerType: conditionViewModel.joinerType)
  }

  // MARK: - Private Methods

  private func updateAppearanceSettings(segmentType: ConditionSegmentType, joinerType: ConditionJoinerType) {
    var isAppearanceSettingsHidden = joinerType == .and
    if segmentType == .both {
      isAppearanceSettingsHidden = false
    }
    tagMarkViewLeadingConstraint.constant = isAppearanceSettingsHidden ? -12 : 20
    tagMarkView.isHidden = isAppearanceSettingsHidden
  }

  private func updateSegmentedControlSettings(segmentType: ConditionSegmentType) {
    switch segmentType {
    case .one:
      segmentView.isHidden = false
      segmentedControl.isHidden = true
    case .both:
      segmentView.isHidden = true
      segmentedControl.isHidden = false
    case .none:
      segmentView.isHidden = true
      segmentedControl.isHidden = true
    }
  }

  @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
    guard let conditionSegmentType = ConditionJoinerType(rawValue: sender.selectedSegmentIndex) else { return }
    didSegmentedControlValueChanged?(conditionSegmentType)
  }
}
