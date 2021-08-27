//
//  DeviceManager.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - Device Model Enum

enum DeviceModel: CGFloat {
  case iPhoneSE = 568.0
  case iPhone7 = 667.0
  case iPhone7Plus = 736.0
  case iPhoneX = 812.0
  case iPhoneXR = 896.0
  case iPad = 1_200.0
  case undefined = 0.0
}

// MARK: - Device Manager

class DeviceManager {

  // MARK: - Singleton

  class func shared() -> DeviceManager { return self.sharedInstance }

  private static let sharedInstance = DeviceManager()

  // MARK: - Internal Properties

  internal let device: DeviceModel = {
    switch UIDevice.current.userInterfaceIdiom {
    case .phone:
      switch UIScreen.main.bounds.height {
      case DeviceModel.iPhoneSE.rawValue:
        return DeviceModel.iPhoneSE
      case DeviceModel.iPhone7.rawValue:
        return DeviceModel.iPhone7
      case DeviceModel.iPhone7Plus.rawValue:
        return DeviceModel.iPhone7Plus
      case DeviceModel.iPhoneX.rawValue:
        return DeviceModel.iPhoneX
      case DeviceModel.iPhoneXR.rawValue:
        return DeviceModel.iPhoneXR
      default:
        return DeviceModel.undefined
      }
    case .pad:
      return DeviceModel.iPad
    default:
      return DeviceModel.undefined
    }
  }()
}
