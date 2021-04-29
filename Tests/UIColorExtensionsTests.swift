//
//  UIColorExtensionsTests.swift
//  ChartIQTests
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

@testable import ChartIQ
import Foundation
import XCTest

class UIColorExtensionsTests: XCTestCase {

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Tests Converting 24 bit Hex to UIColor

  func testConvertingHexToUIColorForBlackColor() {
    // Given
    let blackColor = UIColor(hexString: "000000")

    // When // Then
    XCTAssertTrue(UIColor.black == blackColor)
  }

  func testConvertingHexToUIColorForWhiteColor() {
    // Given
    let whiteColor = UIColor(hexString: "ffffff")

    // When // Then
    XCTAssertTrue(UIColor.white == whiteColor)
  }

  func testConvertingHexToUIColorForRedColor() {
    // Given
    let redColor = UIColor(hexString: "ff0000")

    // When // Then
    XCTAssertTrue(UIColor.red == redColor)
  }

  func testConvertingHexToUIColorForGreenColor() {
    // Given
    let greenColor = UIColor(hexString: "00ff00")

    // When // Then
    XCTAssertTrue(UIColor.green == greenColor)
  }

  func testConvertingHexToUIColorForBlueColor() {
    // Given
    let blueColor = UIColor(hexString: "0000ff")

    // When // Then
    XCTAssertTrue(UIColor.blue == blueColor)
  }

  // MARK: - Tests Converting UIColor to 24 bit Hex

  func testConvertingUIColorToHexForBlackColor() {
    // Given
    let blackColor = UIColor.black
    let blackHexString = "#000000"

    // When // Then
    XCTAssertTrue(blackColor.toHexString() == blackHexString)
  }

  func testConvertingUIColorToHexForWhiteColor() {
    // Given
    let whiteColor = UIColor.white
    let whiteHexString = "#ffffff"

    // When // Then
    XCTAssertTrue(whiteColor.toHexString() == whiteHexString)
  }

  func testConvertingUIColorToHexForRedColor() {
    // Given
    let redColor = UIColor.red
    let redHexString = "#ff0000"

    // When // Then
    XCTAssertTrue(redColor.toHexString() == redHexString)
  }

  func testConvertingUIColorToHexForGreenColor() {
    // Given
    let greenColor = UIColor.green
    let greenHexString = "#00ff00"

    // When // Then
    XCTAssertTrue(greenColor.toHexString() == greenHexString)
  }

  func testConvertingUIColorToHexForBlueColor() {
    // Given
    let blueColor = UIColor.blue
    let blueHexString = "#0000ff"

    // When // Then
    XCTAssertTrue(blueColor.toHexString() == blueHexString)
  }

  // MARK: - Tests Converting 32 bit Hex to UIColor

  func testConvertingHexToUIColorForWhiteColor32bit() {
    // Given
    let whiteColor = UIColor(hexString: "FFFFFFFF")

    // When // Then
    XCTAssertTrue(UIColor.white == whiteColor)
  }

   // MARK: - Tests Converting 12 bit Hex to UIColor

  func testConvertingHexToUIColorForWhiteColor12bit() {
    // Given
    let whiteColor = UIColor(hexString: "FFF")

    // When // Then
    XCTAssertTrue(UIColor.white == whiteColor)
  }

  // MARK: - Tests Equal Converting 12, 24, 32 bit Hex and UIColor

  func testEqualConvertingHexToUIColor12bitEqual24bitEqual32bitForWhiteColor() {
    // Given
    let whiteColor32bit = UIColor(hexString: "FFFFFFFF")
    let whiteColor24bit = UIColor(hexString: "FFFFFF")
    let whiteColor12bit = UIColor(hexString: "FFF")

    // When // Then
    XCTAssertTrue(UIColor.white == whiteColor32bit)
    XCTAssertTrue(UIColor.white == whiteColor24bit)
    XCTAssertTrue(UIColor.white == whiteColor12bit)
    XCTAssertTrue(whiteColor32bit == whiteColor24bit)
    XCTAssertTrue(whiteColor32bit == whiteColor12bit)
    XCTAssertTrue(whiteColor24bit == whiteColor12bit)
  }

  // MARK: - Tests Converting Invalid Hex to UIColor

  func testInvalidConvertingHexToUIColorReturnsRedColor() {
    // Given
    let invalidColorHexString = UIColor(hexString: "invalidHexString")
    let blackColorHexString = UIColor(hexString: "000000")

    // When // Then
    XCTAssertTrue(invalidColorHexString == blackColorHexString)
    XCTAssertTrue(invalidColorHexString == UIColor.black)
  }

  func testGetColorAsset() {
    // Given
    let whiteColor = UIColor(hexString: "ffffff")

    // When
    let whiteDarkGunmetalColor = UIColor.colorAsset(name: "whiteDarkGunmetal", baseColor: whiteColor)

    // Then
    XCTAssertEqual(whiteColor, whiteDarkGunmetalColor)
  }

  func testGetColorAssetWithIncorrectName() {
    // Given
    let whiteColor = UIColor(hexString: "ffffff")

    // When
    let whiteDarkGunmetalColor = UIColor.colorAsset(name: "darkGunmetal", baseColor: whiteColor)

    // Then
    XCTAssertEqual(whiteColor, whiteDarkGunmetalColor)
  }

  func testGetColorAssetBelowiOS11() {
    // Given
    let whiteColor = UIColor(hexString: "ffffff")

    // When
    let whiteDarkGunmetalColor = UIColor.colorAsset(name: "whiteDarkGunmetal",
                                                    baseColor: whiteColor,
                                                    aboveiOS11Mock: false)

    // Then
    XCTAssertEqual(whiteColor, whiteDarkGunmetalColor)
  }

  func testGetColorAssetAboveiOS11() {
    // Given
    let whiteColor = UIColor(hexString: "ffffff")

    // When
    let whiteDarkGunmetalColor = UIColor.colorAsset(name: "whiteDarkGunmetal",
                                                    baseColor: whiteColor,
                                                    aboveiOS11Mock: true)

    // Then
    XCTAssertEqual(whiteColor, whiteDarkGunmetalColor)
  }
}

// MARK: - Equal UIColors extension

extension UIColor {

  static func == (l: UIColor, r: UIColor) -> Bool {
    var r1: CGFloat = 0
    var g1: CGFloat = 0
    var b1: CGFloat = 0
    var a1: CGFloat = 0
    l.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
    var r2: CGFloat = 0
    var g2: CGFloat = 0
    var b2: CGFloat = 0
    var a2: CGFloat = 0
    r.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
    return r1 == r2 && g1 == g2 && b1 == b2 && a1 == a2
  }
}
