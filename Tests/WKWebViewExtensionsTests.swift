//
//  WKWebViewExtensionsTests.swift
//  ChartIQTests
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

@testable import ChartIQ
import Foundation
import WebKit
import XCTest

class WKWebViewExtensionsTests: XCTestCase {

  var webView: WKWebView?

  override func setUp() {
    super.setUp()

    let userContentController = WKUserContentController()
    let configuration = WKWebViewConfiguration()
    configuration.userContentController = userContentController
    webView = WKWebView(frame: CGRect(x: 0, y: 0, width: 10, height: 10),
                        configuration: configuration)
  }

  override func tearDown() {
    super.tearDown()
  }

  // MARK: - Tests Evaluate JavaScript with Return

  func testEvaluateJavaScriptReturnNilValue() {
    // Given
    let script = "clear();"
    // When
    let returnNilValue = self.webView?.evaluateJavaScriptWithReturn(script)
    // Then
    XCTAssertNil(returnNilValue)
  }
}
