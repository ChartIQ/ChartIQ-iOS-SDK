//
//  WKWebView+Extensions.swift
//  ChartIQ
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit
import WebKit

// MARK: - WKWebView Evaluate JavaScript Extension

/// Extension for WKWebView functionality.
internal extension WKWebView {

  // MARK: - Internal Methods

  func evaluateJavaScriptWithReturn(_ javaScriptString: String) -> String? {
    var finished = false
    var jsValue: String?

    evaluateJavaScript(javaScriptString) { result, error in
      if let error = error {
        debugPrint(error)
        jsValue = nil
      } else if let result = result as? String {
        jsValue = result
      }
      finished = true
    }

    while !finished {
      RunLoop.current.run(mode: RunLoop.Mode.default, before: Date.distantFuture)
    }

    return jsValue
  }
}
