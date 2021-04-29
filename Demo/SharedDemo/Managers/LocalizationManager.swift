//
//  LocalizationManager.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import ChartIQ
import UIKit

// MARK: - Localization Manager

class LocalizationManager {

  // MARK: - Singleton

  class func shared() -> LocalizationManager { return self.sharedInstance }

  private static let sharedInstance = LocalizationManager()

  // MARK: - Internal Properties

  internal var languages: [LanguageModel] {
    return supportedLanguages
  }

  internal var currentLanguage: LanguageModel {
    return language ?? getCurrentLanguage()
  }

  // MARK: - Private Properties

  private var chartIQView: ChartIQView?
  private var supportedLanguages: [LanguageModel] = []
  private var language: LanguageModel?
  private var translations: [String: Any] = [:]

  // MARK: - Init Methods

  private init() {
    setupLanguages()
    restoreTranslations()
  }

  // MARK: - Internal Methods

  internal func setChartIQView(_ chartIQView: ChartIQView) {
    self.chartIQView = chartIQView
  }

  internal func performTranslations() {
    let currentLanguage = getCurrentLanguage()
    setLanguage(currentLanguage)
  }

  internal func setLanguage(_ newLanguage: LanguageModel) {
    guard let chartIQView = chartIQView else { return }

    setCurrentLanguage(newLanguage)
    translations = chartIQView.getTranslations(currentLanguage.languageCode)
    saveTranslations()
    reloadAllTranlsations()
  }

  internal func localize(_ localizationKeyString: String) -> String {
    if currentLanguage.languageCode == Const.LocalizationManager.baseLanguageModel.languageCode {
      return localizationKeyString
    } else {
      if let localizedString = translations[localizationKeyString] as? String {
        return localizedString
      } else {
        let languageCodeDebugPrefix = String(currentLanguage.displayName.first ?? "l").capitalizeFirst()
        let notLocalizedString = "\(languageCodeDebugPrefix): " + localizationKeyString
        debugPrint("Need To Localize: \(notLocalizedString)")
        return localizationKeyString
      }
    }
  }

  // MARK: - Private Methods

  private func setupLanguages() {
    supportedLanguages = [
      Const.LocalizationManager.baseLanguageModel,
      LanguageModel(name: Const.LocalizationManager.germanLanguageName,
                    languageCode: Const.LocalizationManager.germanLanguageCode),
      LanguageModel(name: Const.LocalizationManager.frenchLanguageName,
                    languageCode: Const.LocalizationManager.frenchLanguageCode),
      LanguageModel(name: Const.LocalizationManager.russianLanguageName,
                    languageCode: Const.LocalizationManager.russianLanguageCode),
      LanguageModel(name: Const.LocalizationManager.italianLanguageName,
                    languageCode: Const.LocalizationManager.italianLanguageCode),
      LanguageModel(name: Const.LocalizationManager.spanishLanguageName,
                    languageCode: Const.LocalizationManager.spanishLanguageCode),
      LanguageModel(name: Const.LocalizationManager.portugueseLanguageName,
                    languageCode: Const.LocalizationManager.portugueseLanguageCode),
      LanguageModel(name: Const.LocalizationManager.hungarianLanguageName,
                    languageCode: Const.LocalizationManager.hungarianLanguageCode),
      LanguageModel(name: Const.LocalizationManager.chineseLanguageName,
                    languageCode: Const.LocalizationManager.chineseLanguageCode),
      LanguageModel(name: Const.LocalizationManager.japaneseLanguageName,
                    languageCode: Const.LocalizationManager.japaneseLanguageCode),
      LanguageModel(name: Const.LocalizationManager.arabicLanguageName,
                    languageCode: Const.LocalizationManager.arabicLanguageCode)
    ]
  }

  private func getCurrentLanguage() -> LanguageModel {
    let defaults = UserDefaults.standard
    if let currentLanguageCode = defaults.value(forKey: Const.UserDefaults.currentLanguageKey) as? String {
      var languageModel = Const.LocalizationManager.baseLanguageModel
      let currentLanguageModel = supportedLanguages.first { languageModel -> Bool in
        languageModel.languageCode == currentLanguageCode
      }
      if let currentLanguageModel = currentLanguageModel {
        languageModel = currentLanguageModel
      }
      return languageModel
    } else {
      return Const.LocalizationManager.baseLanguageModel
    }
  }

  private func setCurrentLanguage(_ currentLanguage: LanguageModel) {
    language = currentLanguage
    chartIQView?.setLanguage(currentLanguage.languageCode)
    UserDefaults.standard.set(currentLanguage.languageCode,
                              forKey: Const.UserDefaults.currentLanguageKey)
  }

  private func reloadAllTranlsations() {
    NotificationCenter.default.post(name: Const.LocalizationManager.languageChangedNotification,
                                    object: nil)
  }

  private func saveTranslations() {
    UserDefaults.standard.set(translations,
                              forKey: Const.UserDefaults.latestTranslationsKey)
  }

  private func restoreTranslations() {
    let defaults = UserDefaults.standard
    if let translations = defaults.value(forKey: Const.UserDefaults.latestTranslationsKey) as? [String: Any] {
      self.translations = translations
    }
  }
}
