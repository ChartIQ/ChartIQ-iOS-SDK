//
//  SearchSymbolsService.swift
//  ChartIQDemo
//
//  Copyright 2012-2020 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import Foundation

// MARK: - SearchSymbols Service

class SearchSymbolsService {

  // MARK: - Private Properties

  private var task: URLSessionDataTask?

  // MARK: - Internal Methods

  internal func search(with searchedString: String, completionHandler: @escaping ([SymbolModel]) -> Void) {
    guard let url = getSearchURL(withSearchedString: searchedString) else { return }
    task?.cancel()
    task = URLSession.shared.dataTask(with: url) { data, _, error in
      var symbols: [SymbolModel] = []
      guard error == nil, let data = data else {
        if let nsError = error as NSError?, nsError.code != -999 {
          completionHandler(symbols)
        }
        return
      }
      do {
        let json = try JSONSerialization.jsonObject(with: data, options: [])
        guard let resultDictionary = json as? [String: Any],
          let payload = resultDictionary[Const.SearchSymbolsService.payloadKey] as? [String: Any],
          let symbolsData = payload[Const.SearchSymbolsService.symbolsKey] as? [String] else {
            completionHandler(symbols)
            return
        }
        symbolsData.forEach({ unparsedString in
          if let symbolModel = SymbolModel(unparsedString: unparsedString) {
            symbols.append(symbolModel)
          }
        })
        completionHandler(symbols)
      } catch {
        completionHandler(symbols)
      }
    }
    task?.resume()
  }

  // MARK: - Private Methods

  private func getSearchURL(withSearchedString searchedString: String) -> URL? {
    if let encodedSearchedString = searchedString.stringByAddingPercentEncodingForRFC3986() {
      let stringForURL = String(format: Const.SearchSymbolsService.searchSymbolsURLFormatString, encodedSearchedString)
      if let searchURL = URL(string: stringForURL) {
        return searchURL
      }
    }
    return nil
  }
}
