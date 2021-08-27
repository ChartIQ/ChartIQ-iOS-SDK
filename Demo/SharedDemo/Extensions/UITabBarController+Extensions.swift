//
//  UITabBarController+Extensions.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - UITabBarController Extensions

extension UITabBarController {

  // MARK: - Internal Methods

  internal func setTabBarHidden(_ hidden: Bool, animated: Bool, includingRotation: Bool) {
    if includingRotation {
      setTabBarHidden(hidden, animated: animated)
      setTabBarHiddenWithRotation(hidden, animated: animated, completion: { _ in })
    } else {
      if hidden {
        setTabBarHiddenWithRotation(hidden, animated: animated, completion: { _ in
          self.setTabBarHidden(hidden, animated: animated)
        })
      } else {
        setTabBarHidden(hidden, animated: animated)
        setTabBarHiddenWithRotation(hidden, animated: animated, completion: { _ in })
      }
    }
  }

  // MARK: - Private Methods

  private func setTabBarHidden(_ hidden: Bool, animated: Bool) {
    tabBar.isHidden = hidden
  }

  private func setTabBarHiddenWithRotation(_ hidden: Bool, animated: Bool, completion: ((Bool) -> Void)?) {
    if tabBarIsVisible() == !hidden {
      completion?(true)
      return
    }
    let height = tabBar.frame.size.height
    let offsetY = !hidden ? -height : height
    let duration = animated ? AnimationTime.extremelyFast.rawValue : AnimationTime.slowest.rawValue
    UIView.animate(withDuration: duration, animations: {
      let frame = self.tabBar.frame
      self.tabBar.frame = frame.offsetBy(dx: 0, dy: offsetY)
    }, completion: { (finished: Bool) in
      completion?(finished)
    })
  }

  private func tabBarIsVisible() -> Bool {
    return tabBar.frame.origin.y < view.frame.maxY
  }
}
