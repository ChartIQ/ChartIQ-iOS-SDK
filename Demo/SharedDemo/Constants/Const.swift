//
//  Const.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

// MARK: - AnimationTime Enum

enum AnimationTime: TimeInterval {
  case slowest = 1.0
  case extremelySlow = 0.9
  case verySlow = 0.8
  case quiteSlow = 0.7
  case slow = 0.6
  case `default` = 0.5
  case fast = 0.4
  case quiteFast = 0.3
  case veryFast = 0.2
  case extremelyFast = 0.1
  case fastest = 0.0
}

// MARK: - AlphaState Enum

enum AlphaState: CGFloat {
  case visible = 1.0
  case translucent = 0.5
  case invisible = 0.0
}

// MARK: - Const

public struct Const {

  // MARK: - General

  struct General {
    
    static let chartIQURL = "http://192.168.86.57:8080/main/sample-template-native-sdk.html"
    //static let chartIQURL = "https://mobile.demo.chartiq.com/ios/3.6.0/sample-template-native-sdk.html"

    static let cancelTitle = "Cancel"
    static let clearTitle = "Clear"
    static let restoreTitle = "Restore"
    static let editTitle = "Edit"
    static let addTitle = "Add"
    static let doneTitle = "Done"
    static let deleteTitle = "Delete"
    static let cloneTitle = "Clone"
    static let reconnectTitle = "Reconnect"
    static let removeTitle = "Remove"
    static let resetTitle = "Reset"
    static let saveTitle = "Save"

    static let hashSymbol = "#"
    static let commaSymbol = ","
    static let dotSymbol = "."
    static let colonSymbol = ":"
    static let perCentSymbol = "%"
    static let filledStarSymbol = "★"
    static let unfilledStarSymbol = "☆"
    static let newLineSymbol = "\n"

    static let reuseIdPostfix = "ReuseIdentifier"
  }

  // MARK: - UserDefaults

  struct UserDefaults {
    static let currentLanguageKey = "LanguageUserDefaultsKey"
    static let latestTranslationsKey = "TranslationsUserDefaultsKey"

    static let favoriteDrawingToolsKey = "FavoriteDrawToolsUserDefaultsKey"
  }

  // MARK: - TabBar

  struct TabBar {
    static let chartItemTitle = "Chart"
    static let studiesItemTitle = "Studies"
    static let settingsItemTitle = "Settings"
  }

  // MARK: - Managers

  struct LocalizationManager {
    static let languageChangedNotificationName = "LanguageDidChange"

    static let englishLanguageName = "English"
    static let englishLanguageCode = "en-US"

    static let germanLanguageName = "German"
    static let germanLanguageCode = "de-DE"

    static let frenchLanguageName = "French"
    static let frenchLanguageCode = "fr-FR"

    static let russianLanguageName = "Russian"
    static let russianLanguageCode = "ru-RU"

    static let italianLanguageName = "Italian"
    static let italianLanguageCode = "it-IT"

    static let spanishLanguageName = "Spanish"
    static let spanishLanguageCode = "es-ES"

    static let portugueseLanguageName = "Portuguese"
    static let portugueseLanguageCode = "pt-PT"

    static let hungarianLanguageName = "Hungarian"
    static let hungarianLanguageCode = "hu-HU"

    static let chineseLanguageName = "Chinese"
    static let chineseLanguageCode = "zh-CN"

    static let japaneseLanguageName = "Japanese"
    static let japaneseLanguageCode = "ja-JP"

    static let arabicLanguageName = "Arabic"
    static let arabicLanguageCode = "ar-EG-u-nu-latn" // "ar-EG"

    static let languageChangedNotification = NSNotification.Name(rawValue: languageChangedNotificationName)
    static let baseLanguageModel = LanguageModel(name: englishLanguageName, languageCode: englishLanguageCode)
  }

  // MARK: - Services

  struct DataSimulatorService {
    static let simulatorUrlFormatString = "https://simulator.chartiq.com/datafeed" +
      "?identifier=%@" + "&startdate=%@" + "%@" + "&interval=%@" + "&period=%i" + "&extended=1" + "&session=%@"
    static let simulatorEndDateFormatString = "&enddate=%@"

    static let errorAlertTitle = "Something went wrong!"
  }

  struct SearchSymbolsService {
    static let searchAllSymbolsURLFormatString = "https://symbols.chartiq.com/chiq.symbolserver.SymbolLookup.service" +
      "?t=%@" + "&m=100" +
      "&x=[XNYS,XASE,XNAS,XASX,INDCBSX,INDXASE,INDXNAS,IND_DJI,ARCX,INDARCX,forex,mutualfund,futures]"

    static let searchSymbolsURLFormatString = "https://symbols.chartiq.com/chiq.symbolserver.SymbolLookup.service" +
      "?t=%@" + "&m=100" +
      "&x=[XNYS,XASE,XNAS,XASX,INDCBSX,INDXASE,INDXNAS,IND_DJI,ARCX,INDARCX,forex,mutualfund,futures]" +
      "&e=%@"

    static let payloadKey = "payload"
    static let symbolsKey = "symbols"
  }

  struct DrawToolsService {
    static let fillColorTitle = "Fill Color"
    static let lineColorTitle = "Line Color"
    static let lineTypeTitle = "Line Type"

    static let fontFamilyTitle = "Font Family"
    static let fontSizeTitle = "Font Size"
    static let fontStyleTitle = "Font Style"

    static let showCalloutTitle = "Show Callout"
    static let axisLabelTitle = "Axis Label"

    static let fibonacciSettingsTitle = "Fibonacci Settings"

    static let waveTemplateTitle = "Wave Template"
    static let decorationTitle = "Decoration"
    static let impulseTitle = "Impulse"
    static let correctiveTitle = "Corrective"
    static let showLinesTitle = "Show Lines"

    static let deviationsSettingsTitle = "STD Deviations"

    static let showLine1Title = "Show Line 1"
    static let showLine2Title = "Show Line 2"
    static let showLine3Title = "Show Line 3"

    static let line1ColorTitle = "Line 1 Color"
    static let line2ColorTitle = "Line 2 Color"
    static let line3ColorTitle = "Line 3 Color"

    static let line1TypeTitle = "Line 1 Type"
    static let line2TypeTitle = "Line 2 Type"
    static let line3TypeTitle = "Line 3 Type"

    static let priceBucketsTitle = "Price Buckets"
  }

  // MARK: - Models

  struct IntervalModel {
    static let tickTitle = "tick"
    static let millisecondTitle = "millisecond"
    static let secondTitle = "second"
    static let minuteTitle = "minute"
    static let hourTitle = "hour"
    static let dayTitle = "day"
    static let weekTitle = "week"
    static let monthTitle = "month"

    static let tickShortTitle = "T"
    static let millisecondShortTitle = "ms"
    static let secondShortTitle = "s"
    static let minuteShortTitle = "m"
    static let hourShortTitle = "H"
    static let dayShortTitle = "D"
    static let weekShortTitle = "W"
    static let monthShortTitle = "M"
  }

  struct SymbolModel {
    static let paramsArraySeparator = "|"
  }

  // MARK: - Buttons

  struct FloatingButton {
    static let topMargin: CGFloat = 44.0
    static let bottomMargin: CGFloat = 32.0
    static let rightMargin: CGFloat = 12.0
    static let leftMargin: CGFloat = 12.0

    static let arrowMargin: CGFloat = 8.0
    static let arrowWidth: CGFloat = 16.0
    static let arrowHeight: CGFloat = 24.0
    static let arrowAnimationPadding: CGFloat = 20.0
  }

  struct ChartButton {
    static let symbolsButtonSize = CGSize(width: 76, height: 32)
    static let intervalsButtonSize = CGSize(width: 52, height: 32)

    static let circleButtonSize = CGSize(width: 32, height: 32)
  }

  // MARK: - Views

  struct CrosshairInfoView {
    static let height: CGFloat = 48.0

    static let priceTitle: String = "Price"
    static let volumeTitle: String = "Vol"
    static let openTitle: String = "Open"
    static let highTitle: String = "High"
    static let closeTitle: String = "Close"
    static let lowTitle: String = "Low"
  }

  struct NavigationView {
    static let height: CGFloat = 48.0
  }

  struct HorizontalPickerView {
    static let height: CGFloat = 70.0

    static let collectionViewEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    static let collectionViewMinimumLineSpacing: CGFloat = 12.0

    static let colorPickerCellSize = CGSize(width: 44, height: 44)
    static let linePickerCellSize = CGSize(width: 58, height: 44)
  }

  struct HorizontalFilterView {
    static let collectionViewEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    static let collectionViewMinimumLineSpacing: CGFloat = 8.0

    static let filterCellHeight: CGFloat = 28.0
    static let filterCellMargin: CGFloat = 16.0
  }

  struct DrawToolControlView {
    static let height: CGFloat = 44.0

    static let cellSize = CGSize(width: 32, height: 32)
    static let collectionViewEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    static let collectionViewMinimumLineSpacing: CGFloat = 16.0
  }

  struct SearchBar {
    static let searchTitle = "Search"
    static let searchCancelButtonTitleKey = "cancelButtonText"
  }

  // MARK: - Collection View Cells

  struct ColorPickerCollectionCell {
    static let cellNibName = "ColorPickerCollectionCell"
    static let cellId = cellNibName + General.reuseIdPostfix
  }

  struct LinePickerCollectionCell {
    static let cellNibName = "LinePickerCollectionCell"
    static let cellId = cellNibName + General.reuseIdPostfix
  }

  struct DrawToolBaseCell {
    static let cellNibName = "DrawToolBaseCell"
    static let cellId = cellNibName + General.reuseIdPostfix
  }

  struct DrawToolColorCell {
    static let cellNibName = "DrawToolColorCell"
    static let cellId = cellNibName + General.reuseIdPostfix
  }

  struct FilterCollectionCell {
    static let cellNibName = "FilterCollectionCell"
    static let cellId = cellNibName + General.reuseIdPostfix

    static let cellTitleFont = UIFont.systemFont(ofSize: 14, weight: .medium)
  }

  // MARK: - Table View General Cells

  struct BaseTableCell {
    static let cellNibName = "BaseTableCell"
    static let cellId = cellNibName + General.reuseIdPostfix

    static let cellHeight: CGFloat = 45.0
    static let headerHeight: CGFloat = 35.0
  }

  struct ButtonTableCell {
    static let cellNibName = "ButtonTableCell"
    static let cellId = cellNibName + General.reuseIdPostfix
  }

  struct DisclosureTableCell {
    static let cellNibName = "DisclosureTableCell"
    static let cellId = cellNibName + General.reuseIdPostfix
  }

  struct TextTableCell {
    static let cellNibName = "TextTableCell"
    static let cellId = cellNibName + General.reuseIdPostfix
  }

  struct TextColorTableCell {
    static let cellNibName = "TextColorTableCell"
    static let cellId = cellNibName + General.reuseIdPostfix
  }

  struct TextViewTableCell {
    static let cellNibName = "TextViewTableCell"
    static let cellId = cellNibName + General.reuseIdPostfix

    static let cellHeight: CGFloat = 110.0
  }

  struct ToggleTableCell {
    static let cellNibName = "ToggleTableCell"
    static let cellId = cellNibName + General.reuseIdPostfix
  }

  struct SelectTableCell {
    static let cellNibName = "SelectTableCell"
    static let cellId = cellNibName + General.reuseIdPostfix
  }

  struct FontTableCell {
    static let cellNibName = "FontTableCell"
    static let cellId = cellNibName + General.reuseIdPostfix
  }

  struct LineTableCell {
    static let cellNibName = "LineTableCell"
    static let cellId = cellNibName + General.reuseIdPostfix
  }

  // MARK: - Table View Specific Cells

  struct SymbolTableCell {
    static let cellNibName = "SymbolTableCell"
    static let cellId = cellNibName + General.reuseIdPostfix

    static let cellHeight: CGFloat = 66.0
  }

  struct StudyTableCell {
    static let cellNibName = "StudyTableCell"
    static let cellId = cellNibName + General.reuseIdPostfix

    static let cellHeight: CGFloat = 66.0
  }

  struct ConditionTableCell {
    static let cellNibName = "ConditionTableCell"
    static let cellId = cellNibName + General.reuseIdPostfix

    static let cellHeight: CGFloat = 58.0
    static let extendedCellHeight: CGFloat = 116.0
  }

  struct DrawToolTableCell {
    static let cellNibName = "DrawToolTableCell"
    static let cellId = cellNibName + General.reuseIdPostfix
  }

  struct FibInputTableCell {
    static let cellNibName = "FibInputTableCell"
    static let cellId = cellNibName + General.reuseIdPostfix
  }

  // MARK: - View Controllers

  struct Chart {
    static let maxLeftBarButtonItems = 2
    static let maxRightBarButtonItems = 8

    static let maxTabBarLeftBarButtonItems = 2
    static let maxTabBarRightBarButtonItems = 5

    static let manageLayersTitle = "Manage Layers"

    static let bringToTopTitle = "Bring to Top"
    static let bringForwardTitle = "Bring Forward"
    static let sendBackwardTitle = "Send Backward"
    static let sendToBottomTitle = "Send to Bottom"
  }

  struct SearchSymbols {
    static let emptyStateTitle = "Type to start searching"
    static let emptyStateNotFoundTitle = "Symbols not found"
    static let emptyStateNotFoundDescription = "Try another symbol to type in or apply current request"
    static let emptyStateViewButtonTitle = "Apply"

    static let allFilterItemTitle = "ALL"
    static let stocksFilterItemTitle = "STOCKS"
    static let forexFilterItemTitle = "FOREX"
    static let indexesFilterItemTitle = "INDEXES"
    static let fundsFilterItemTitle = "FUNDS"
    static let futuresFilterItemTitle = "FUTURES"
  }

  struct Intervals {
    static let screenTitle = "Intervals"

    static let selectCustomCellTitle = "Select Custom"
    static let customConfigHeaderTitle = "Custom Interval"

    static let pickerViewHeight: CGFloat = 250
  }

  struct Series {
    static let screenTitle = "Compare Symbols"

    static let emptyStateViewTitle = "No Symbols to compare yet"
    static let emptyStateViewButtonTitle = "Add Symbol"

    static let colorKey = "color"
  }

  struct Signals {
    static let screenTitle = "SignalIQ"

    static let emptyStateViewTitle = "No Signals to display yet"
    static let emptyStateViewButtonTitle = "Add Signal"
  }

  struct SignalDetail {
    static let createSignalScreenTitle = "New Signal"
    static let editSignalScreenTitle = "Edit Signal"

    static let descriptionPlaceholder = "Description will appear in an infobox when the signal is clicked."
    static let namePlaceholder = "Enter a Name"

    static let changeStudyTitle = "Change Study"
    static let conditionTitle = "Condition"
    static let addConditionTitle = "Add Condition"
    static let selectStudyTitle = "Select Study"
    static let descriptionTitle = "Description"
    static let nameTitle = "Name"
  }

  struct SignalCondition {
    static let screenTitle = "Condition"

    static let conditionSettingsHeaderTitle = "Condition Settings"
    static let appearanceSettingsHeaderTitle = "Appearance Settings"

    static let valueField = "Value"

    static let firstIndicatorTitle = "Indicator 1"
    static let conditionTitle = "Condition"
    static let selectActionTitle = "Select Action"
    static let secondIndicatorTitle = "Indicator 2"

    static let markerTypeTitle = "Marker Type"
    static let colorTitle = "Color"
    static let shapeTitle = "Shape"
    static let tagMarkTitle = "Tag Mark"
    static let sizeTitle = "Size"
    static let positionTitle = "Position"

    static let warningTitle = "Paintbar doesn’t work with this chart type."
  }

  struct DrawTools {
    static let screenTitle = "Drawing Tools"

    static let noToolTitle = "No Tool"
    static let measureTitle = "Measure"
    static let otherToolsTitle = "Other Tools"
    static let mainToolsTitle = "Main Tools"

    static let headerHeight: CGFloat = 38
    static let footerHeight: CGFloat = 1

    static let restoreParametersActionTitle = "Restore Default Parameters"
    static let clearDrawingsActionTitle = "Clear Existing Drawings"

    static let clearDrawingsAlertTitle = "Do You Want To Clear All Existing Drawings?"
    static let clearDrawingsAlertMessage = "All your drawings will be cleared on the current chart."

    static let restoreDefaultsAlertTitle = "Do You Want To Restore Default Parameters?"
    static let restoreDefaultsAlertMessage = "All your drawing parameters will be restored to defaults."

    static let allFilterItemTitle = "All"
    static let favoritesFilterItemTitle = "Favorites"
    static let textFilterItemTitle = "Text"
    static let statisticsFilterItemTitle = "Statistics"
    static let technicalsFilterItemTitle = "Technicals"
    static let fibonacciFilterItemTitle = "Fibonacci"
    static let markingsFilterItemTitle = "Markings"
    static let linesFilterItemTitle = "Lines"

    static let emptyStateTitle = "No Favorite Drawing Tools yet"
    static let emptyStateDescription = "Swipe left to Add/Remove Drawing Tool to Favorites"
  }

  struct DrawToolSettings {
    static let screenTitle = "Settings"

    static let saveAsTemplateActionTitle = "Save as Template"
    static let restoreConfigActionTitle = "Restore Config"

    static let saveAsTemplateAlertTitle = "Do You Want To Save Current Config as Tempate?"
    static let saveAsTemplateAlertMessage = "All your drawing parameters will be saved as Template."

    static let restoreConfigAlertTitle = "Do You Want To Restore Config To Defaults?"
    static let restoreConfigAlertMessage = "This Template config will be restored to default parameters."
  }

  struct FibSettingsViewController {
    static let screenTitle = "Fibonacci Settings"

    static let fibInputPlaceholderTitle = "Custom %"
    static let fibInputAddButtonTitle = "Add"
  }

  struct DeviationsViewController {
    static let screenTitle = "Std Deviations Settings"
  }

  struct Studies {
    static let screenTitle = "Active Studies"

    static let emptyStateViewTitle = "No Active Studies to display yet"
    static let emptyStateViewButtonTitle = "Add Studies"
  }

  struct AllStudies {
    static let screenTitle = "Add Studies"
  }

  struct StudyDetail {
    static let resetDefaultsButtonTitle = "Reset to Defaults"
    static let removeStudyButtonTitle = "Remove Study"

    static let resetDefaultsAlertTitle = "Do You Want To Reset This Study To Defaults?"
    static let resetDefaultsAlertMessage = "This study will be reset to default options."

    static let removeStudyAlertTitle = "Do You Want To Remove This Study?"
    static let removeStudyAlertMessage = "This study will be removed from the current chart."

    static let negativeIntDigits = "0123456789-"
    static let doubleDigits = "0123456789,."
    static let negativeDoubleDigits = "-0123456789,."
  }

  struct FullScreenPicker {
    static let selectColorScreenTitle = "Select Color"
    static let selectLineScreenTitle = "Select Line Type"

    static let collectionViewEdgeInsets = UIEdgeInsets(top: 38, left: 16, bottom: 38, right: 16)
    static let collectionViewMinimumSpacing: CGFloat = 12.0

    static let colorPickerCellSize = CGSize(width: 59, height: 59)
    static let linePickerCellSize = CGSize(width: 75, height: 55)
  }

  struct SelectOption {
    static let screenTitle = "Select Option"
  }

  struct Settings {
    static let screenTitle = "Settings"

    static let chartConfigHeaderTitle = "Chart Config"
    static let chartPreferencesHeaderTitle = "Chart Preferences"
    static let languagePreferencesHeaderTitle = "Language Preferences"

    static let chartStyleTitle = "Chart Style"
    static let logScaleTitle = "Log Scale"
    static let invertYAxisTitle = "Invert Y-Axis"
    static let extendHoursTitle = "Extend Hours"
    static let languageTitle = "Language"
  }

  struct ChartStyle {
    static let screenTitle = "Chart Style"
  }

  struct Language {
    static let screenTitle = "Language"
  }
}
