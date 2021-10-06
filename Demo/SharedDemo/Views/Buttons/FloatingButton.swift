//
//  FloatingButton.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - FloatingButtonPosition Enum

enum FloatingButtonPosition {
  case rightTop
  case rightBottom
  case leftBottom
  case leftTop
}

// MARK: - FloatingButtonPosition extension

extension FloatingButtonPosition {

  // MARK: - Internal Methods

  internal func cgRectValue(parentView: UIView) -> CGRect {
    var safeAreaRightPadding: CGFloat = 0.0
    var safeAreaLeftPadding: CGFloat = 0.0
    if #available(iOS 11.0, *) {
      let window = UIApplication.shared.keyWindow
      safeAreaRightPadding = window?.safeAreaInsets.right ?? 0.0
      safeAreaLeftPadding = window?.safeAreaInsets.left ?? 0.0
    }

    let topDistance = Const.FloatingButton.topMargin
    let bottomDistance = Const.FloatingButton.bottomMargin + Const.ChartButton.circleButtonSize.width
    let rightDistance = Const.FloatingButton.rightMargin + Const.ChartButton.circleButtonSize.width
      + safeAreaRightPadding
    let leftDistance = Const.FloatingButton.leftMargin + safeAreaLeftPadding

    var parentViewWidth = parentView.frame.width
    var parentViewHeight = parentView.frame.height
    if parentView.frame.height > parentView.frame.width {
      parentViewWidth = parentView.frame.height
      parentViewHeight = parentView.frame.width
    }

    let rightWidthXPosition = parentViewWidth - rightDistance
    let bottomHeightYPosition = parentViewHeight - bottomDistance

    switch self {
    case .rightTop:
      return CGRect(origin: CGPoint(x: rightWidthXPosition, y: topDistance),
                    size: Const.ChartButton.circleButtonSize)
    case .rightBottom:
      return CGRect(origin: CGPoint(x: rightWidthXPosition, y: bottomHeightYPosition),
                    size: Const.ChartButton.circleButtonSize)
    case .leftBottom:
      return CGRect(origin: CGPoint(x: leftDistance, y: bottomHeightYPosition),
                    size: Const.ChartButton.circleButtonSize)
    case .leftTop:
      return CGRect(origin: CGPoint(x: leftDistance, y: topDistance),
                    size: Const.ChartButton.circleButtonSize)
    }
  }
}

// MARK: - Floating Button

class FloatingButton: UIButton {

  // MARK: - Private Properties

  private var floatingButtonPosition: FloatingButtonPosition = .rightTop
  private var parentView: UIView = UIView()
  private var leftArrowImageView: UIImageView?
  private var downArrowImageView: UIImageView?

  // MARK: - View Lifecycle Methods

  required init(parentView: UIView, position: FloatingButtonPosition = .rightTop) {
    super.init(frame: .zero)

    self.parentView = parentView
    self.floatingButtonPosition = position

    setupUI()
    setupSettings()
  }

  required init?(coder: NSCoder) {
    super.init(frame: .zero)

    setupUI()
    setupSettings()
  }

  override var isHidden: Bool {
    didSet {
      if isHidden {
        hideArrows()
      } else {
        showAndHideArrows()
      }
    }
  }

  // MARK: - Setup Methods

  private func setupUI() {
    setImage(UIImage.Chart.fullViewActiveImage, for: .normal)
    addShadow(radius: 3.0, opacity: 0.5, width: 0.0, height: 2.0)
  }

  private func setupSettings() {
    frame = floatingButtonPosition.cgRectValue(parentView: parentView)
    addSwipeGestures()
    addArrows()
    parentView.addSubview(self)
  }

  // MARK: - Internal Methods

  internal func updateFramePosition(parentView: UIView) {
    self.parentView = parentView
    frame = floatingButtonPosition.cgRectValue(parentView: parentView)
    updateArrowsPosition()
  }

  // MARK: - Private Methods

  @objc private func respondToSwipeGesture(gesture: UIGestureRecognizer) {
    guard let swipeGesture = gesture as? UISwipeGestureRecognizer else { return }
    animateArrows(show: false, transition: false, duration: 0.0)
    switch self.floatingButtonPosition {
    case .rightTop:
      performRightTopPosition(withGesture: swipeGesture)
    case .rightBottom:
      performRightBottomPosition(withGesture: swipeGesture)
    case .leftBottom:
      performLeftBottomPosition(withGesture: swipeGesture)
    case .leftTop:
      performLeftTopPosition(withGesture: swipeGesture)
    }
    UIView.animate(withDuration: AnimationTime.veryFast.rawValue) {
      self.frame = self.floatingButtonPosition.cgRectValue(parentView: self.parentView)
    }
  }

  private func performRightTopPosition(withGesture swipeGesture: UISwipeGestureRecognizer) {
    if swipeGesture.direction == .down {
      floatingButtonPosition = .rightBottom
    } else if swipeGesture.direction == .left {
      floatingButtonPosition = .leftTop
    }
  }

  private func performRightBottomPosition(withGesture swipeGesture: UISwipeGestureRecognizer) {
    if swipeGesture.direction == .left {
      floatingButtonPosition = .leftBottom
    } else if swipeGesture.direction == .up {
      floatingButtonPosition = .rightTop
    }
  }

  private func performLeftBottomPosition(withGesture swipeGesture: UISwipeGestureRecognizer) {
    if swipeGesture.direction == .right {
      floatingButtonPosition = .rightBottom
    } else if swipeGesture.direction == .up {
      floatingButtonPosition = .leftTop
    }
  }

  private func performLeftTopPosition(withGesture swipeGesture: UISwipeGestureRecognizer) {
    if swipeGesture.direction == .right {
      floatingButtonPosition = .rightTop
    } else if swipeGesture.direction == .down {
      floatingButtonPosition = .leftBottom
    }
  }

  private func addSwipeGestures() {
    let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
    swipeRight.direction = .right
    addGestureRecognizer(swipeRight)

    let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
    swipeLeft.direction = .left
    addGestureRecognizer(swipeLeft)

    let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
    swipeUp.direction = .up
    addGestureRecognizer(swipeUp)

    let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
    swipeDown.direction = .down
    addGestureRecognizer(swipeDown)
  }

  private func addArrows() {
    let downArrowXPosition = (frame.origin.x) + (frame.width / 2) - (Const.FloatingButton.arrowWidth / 2)
    let downArrowYPosition = frame.origin.y + frame.height + Const.FloatingButton.arrowMargin
    downArrowImageView = UIImageView(frame: CGRect(x: downArrowXPosition,
                                                   y: downArrowYPosition,
                                                   width: Const.FloatingButton.arrowWidth,
                                                   height: Const.FloatingButton.arrowHeight))
    downArrowImageView?.image = UIImage.FloatingButton.downArrowImage

    let leftArrowXPosition = frame.origin.x - Const.FloatingButton.arrowHeight - Const.FloatingButton.arrowMargin
    let leftArrowYPosition = (frame.origin.y) + (frame.width / 2) - (Const.FloatingButton.arrowWidth / 2)
    leftArrowImageView = UIImageView(frame: CGRect(x: leftArrowXPosition,
                                                   y: leftArrowYPosition,
                                                   width: Const.FloatingButton.arrowHeight,
                                                   height: Const.FloatingButton.arrowWidth))
    leftArrowImageView?.image = UIImage.FloatingButton.leftArrowImage

    animateArrows(show: false, transition: false, duration: 0.0)

    if let downArrowImageView = downArrowImageView, let leftArrowImageView = leftArrowImageView {
      parentView.addSubview(downArrowImageView)
      parentView.addSubview(leftArrowImageView)
    }
  }

  private func updateArrowsPosition() {
    let downArrowXPosition = (frame.origin.x) + (frame.width / 2) - (Const.FloatingButton.arrowWidth / 2)
    let downArrowYPosition = frame.origin.y + frame.height + Const.FloatingButton.arrowMargin
    downArrowImageView?.frame = CGRect(x: downArrowXPosition,
                                       y: downArrowYPosition,
                                       width: Const.FloatingButton.arrowWidth,
                                       height: Const.FloatingButton.arrowHeight)

    let leftArrowXPosition = frame.origin.x - Const.FloatingButton.arrowHeight - Const.FloatingButton.arrowMargin
    let leftArrowYPosition = (frame.origin.y) + (frame.width / 2) - (Const.FloatingButton.arrowWidth / 2)
    leftArrowImageView?.frame = CGRect(x: leftArrowXPosition,
                                       y: leftArrowYPosition,
                                       width: Const.FloatingButton.arrowHeight,
                                       height: Const.FloatingButton.arrowWidth)
  }

  private func showAndHideArrows() {
    guard floatingButtonPosition == .rightTop else { return }
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
      !self.isHidden ? self.animateArrows(show: true, transition: false, duration: 0.3) : ()
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
        !self.isHidden ? self.animateArrows(show: false, transition: true, duration: 0.5) : ()
      }
    }
  }

  private func animateArrows(show: Bool, transition: Bool, duration: TimeInterval) {
    guard let downArrowImageView = downArrowImageView, let leftArrowImageView = leftArrowImageView else { return }
    downArrowImageView.isHidden = false
    leftArrowImageView.isHidden = false
    UIView.animate(withDuration: duration, animations: {
      downArrowImageView.alpha = show ? .visible : .invisible
      leftArrowImageView.alpha = show ? .visible : .invisible
      if transition {
        let downArrowYPosition = downArrowImageView.frame.origin.y + Const.FloatingButton.arrowAnimationPadding
        let leftArrowXPosition = leftArrowImageView.frame.origin.x - Const.FloatingButton.arrowAnimationPadding
        downArrowImageView.frame = CGRect(origin: CGPoint(x: downArrowImageView.frame.origin.x,
                                                          y: downArrowYPosition),
                                          size: downArrowImageView.frame.size)
        leftArrowImageView.frame = CGRect(origin: CGPoint(x: leftArrowXPosition,
                                                          y: leftArrowImageView.frame.origin.y),
                                          size: leftArrowImageView.frame.size)
      }
    }, completion: { _ in
      if !show {
        downArrowImageView.isHidden = true
        leftArrowImageView.isHidden = true
      }
    })
  }

  private func hideArrows() {
    guard let downArrowImageView = downArrowImageView, let leftArrowImageView = leftArrowImageView else { return }
    downArrowImageView.isHidden = true
    leftArrowImageView.isHidden = true
    downArrowImageView.alpha = .invisible
    leftArrowImageView.alpha = .invisible
  }
}
