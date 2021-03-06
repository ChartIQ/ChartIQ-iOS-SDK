//
//  UIColor+Extensions.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - UIColor Static Colors Extension

extension UIColor {

  // MARK: - Internal Properties

  internal static let whiteColor = UIColor(hexString: "ffffff")
  internal static let blackColor = UIColor(hexString: "000000")
  internal static let ghostWhiteColor = UIColor(hexString: "f9f9f9")
  internal static let brightGreyColor = UIColor(hexString: "ebeff3")
  internal static let cadetBlueColor = UIColor(hexString: "abb0ba")
  internal static let mountainMeadowColor = UIColor(hexString: "27cc8d")
  internal static let darkElectricBlueColor = UIColor(hexString: "53627C")
  internal static let gainsboroColor = UIColor(hexString: "dadfe3")
  internal static let darkGunmetalColor = UIColor(hexString: "18252e")
  internal static let chineseBlackColor = UIColor(hexString: "091924")
  internal static let yankeesBlueColor = UIColor(hexString: "153246")
  internal static let coralRedColor = UIColor(hexString: "ff3b30")
  internal static let brillianteAzureColor = UIColor(hexString: "3a8eff")
  internal static let outerSpace = UIColor(hexString: "273843")
  internal static let charlestonGreen = UIColor(hexString: "1F2A34")
}

// MARK: - UIColor Dynamic Colors Extension

extension UIColor {

  // MARK: - Internal Properties

  internal class var whiteDarkGunmetalColor: UIColor {
    return colorAsset(name: "whiteDarkGunmetal", baseColor: UIColor.whiteColor)
  }

  internal class var whiteCharlestonGreenColor: UIColor {
    return colorAsset(name: "whiteCharlestonGreen", baseColor: UIColor.whiteColor)
  }

  internal class var whiteYankeesBlueColor: UIColor {
    return colorAsset(name: "whiteYankeesBlue", baseColor: UIColor.whiteColor)
  }

  internal class var ghostWhiteСhineseBlackColor: UIColor {
    return colorAsset(name: "ghostWhiteСhineseBlack", baseColor: UIColor.ghostWhiteColor)
  }

  internal class var brightGreyYankeesBlueColor: UIColor {
    return colorAsset(name: "brightGreyYankeesBlue", baseColor: UIColor.brightGreyColor)
  }

  internal class var darkElectricBlueWhiteColor: UIColor {
    return colorAsset(name: "darkElectricBlueWhite", baseColor: UIColor.darkElectricBlueColor)
  }

  internal class var darkElectricBlueCadetBlueColor: UIColor {
    return colorAsset(name: "darkElectricBlueCadetBlue", baseColor: UIColor.darkElectricBlueColor)
  }

  internal class var gainsboroDarkElectricBlueColor: UIColor {
    return colorAsset(name: "gainsboroDarkElectricBlue", baseColor: UIColor.gainsboroColor)
  }

  internal class var gainsboroDarkYankeesBlueColor: UIColor {
    return colorAsset(name: "gainsboroDarkYankeesBlue", baseColor: UIColor.gainsboroColor)
  }

  internal class var yankeesBlueMayaBlueColor: UIColor {
    return colorAsset(name: "yankeesBlueMayaBlue", baseColor: UIColor.yankeesBlueColor)
  }
}

// MARK: - UIColor Picker Colors Extension

extension UIColor {

  // MARK: - Internal Methods

  internal static func allColors() -> [UIColor] {
    return [
      UIColor(hexString: "960616"),
      UIColor(hexString: "ea1d2c"),
      UIColor(hexString: "ef6c53"),
      UIColor(hexString: "e4977c"),
      UIColor(hexString: "ffffff"),
      UIColor(hexString: "a16118"),
      UIColor(hexString: "f4932f"),
      UIColor(hexString: "f8ae63"),
      UIColor(hexString: "fbc58d"),
      UIColor(hexString: "cccccc"),
      UIColor(hexString: "cbb920"),
      UIColor(hexString: "fff126"),
      UIColor(hexString: "fff371"),
      UIColor(hexString: "fff69e"),
      UIColor(hexString: "b7b7b7"),
      UIColor(hexString: "007238"),
      UIColor(hexString: "00a553"),
      UIColor(hexString: "43b77a"),
      UIColor(hexString: "85c99e"),
      UIColor(hexString: "898989"),
      UIColor(hexString: "00746a"),
      UIColor(hexString: "00a99c"),
      UIColor(hexString: "2ebbb3"),
      UIColor(hexString: "7fcdc7"),
      UIColor(hexString: "707070"),
      UIColor(hexString: "004c7f"),
      UIColor(hexString: "0073ba"),
      UIColor(hexString: "4a8dc8"),
      UIColor(hexString: "7DA6F5"),
      UIColor(hexString: "555555"),
      UIColor(hexString: "62095f"),
      UIColor(hexString: "912a8e"),
      UIColor(hexString: "a665a7"),
      UIColor(hexString: "bb8dbe"),
      UIColor(hexString: "1d1d1d"),
      UIColor(hexString: "9c005d"),
      UIColor(hexString: "e9088c"),
      UIColor(hexString: "ee6fa9"),
      UIColor(hexString: "f29bc1"),
      UIColor(hexString: "000000")
    ]
  }

  internal static func allSeriesColors() -> [UIColor] {
    return [
      UIColor(hexString: "#8ec648"),
      UIColor(hexString: "#00afed"),
      UIColor(hexString: "#ee652e"),
      UIColor(hexString: "#912a8e"),
      UIColor(hexString: "#fff126"),
      UIColor(hexString: "#e9088c"),
      UIColor(hexString: "#ea1d2c"),
      UIColor(hexString: "#00a553"),
      UIColor(hexString: "#00a99c"),
      UIColor(hexString: "#0056a4"),
      UIColor(hexString: "#f4932f"),
      UIColor(hexString: "#0073ba"),
      UIColor(hexString: "#66308f"),
      UIColor(hexString: "#323390")
    ]
  }
}
