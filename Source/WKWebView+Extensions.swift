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
      if error == nil {
        if result != nil {
          jsValue = result as? String
        }
      } else {
        jsValue = nil
      }
      finished = true
    }

    while !finished {
      RunLoop.current.run(mode: RunLoop.Mode.default, before: Date.distantFuture)
    }

    return jsValue
  }
}
