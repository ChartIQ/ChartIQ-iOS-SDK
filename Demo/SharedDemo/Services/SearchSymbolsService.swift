//
//  SearchSymbolsService.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import Foundation

// MARK: - SearchSymbols Service

class SearchSymbolsService {

  // MARK: - Private Properties

  private var task: URLSessionDataTask?

  // MARK: - Internal Methods

  internal func search(with searchedString: String,
                       filterType: SearchSymbolsFilterType,
                       completionHandler: @escaping ([SymbolModel]) -> Void) {
    guard let url = getSearchURL(withSearchedString: searchedString, filterType: filterType) else { return }
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

  private func getSearchURL(withSearchedString searchedString: String,
                            filterType: SearchSymbolsFilterType) -> URL? {
    if let encodedSearchedString = searchedString.stringByAddingPercentEncodingForRFC3986() {
      var searchStringForURL = ""
      if filterType == .all {
        searchStringForURL = String(format: Const.SearchSymbolsService.searchAllSymbolsURLFormatString,
                                    encodedSearchedString)
      } else {
        searchStringForURL = String(format: Const.SearchSymbolsService.searchSymbolsURLFormatString,
                                    encodedSearchedString,
                                    filterType.stringValue)
      }
      if let searchURL = URL(string: searchStringForURL) {
        return searchURL
      }
    }
    return nil
  }
}
