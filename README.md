# ChartIQ-iOS-SDK

Native iOS SDK for the [ChartIQ JavaScript library](https://documentation.chartiq.com).

<table>
  <tr>
    <td>:construction: <b>BETA Release</b>. Please visit us again starting April 6, 2021 to download the final release of this SDK and accompanying mobile application.</td>
  </tr>
</table>

The ChartIQ iOS SDK supports a basic charting application. The SDK can be extended to support more elaborate implementations by adding code to invoke ChartIQ library functions directly or by creating a bridge file similar to *nativeSdkBridge.js* (in the *mobile/js* folder of your ChartIQ library).

Contact us at <support@chartiq.com> to request sample code and guidance on how to extend the SDK.

## Requirements

- Version 8.1.0 or later of the ChartIQ library

  Go to our <a href="https://cosaic.io/chartiq-sdk-library-download/" target="_blank">download site</a> to obtain a free 30-day trial version of the library, or send us an email at <info@cosaic.io>, and we'll send you an evaluation version.

- iOS 10.3 or later

## Sample app

The [Demo](https://github.com/ChartIQ/ChartIQ-iOS-SDK/tree/master/Demo) folder of this repository contains a sample app that was built using the SDK. Customize the app to quickly create your own iOS charting application.

The app is also available on the Apple Store.

**App screen shots**

<table>
  <tr>
    <td><img src="https://github.com/ChartIQ/ChartIQ-iOS-SDK/blob/master/screenshots/Candle_Chart.png?raw=true" alt="Candle chart" width="200" height="433"/></td>
    <td><img src="https://github.com/ChartIQ/ChartIQ-iOS-SDK/blob/master/screenshots/Mountain_Chart_with_Drawings.png?raw=true" alt="Mountain chart with drawings" width="200" height="433"/></td>
    <td><img src="https://github.com/ChartIQ/ChartIQ-iOS-SDK/blob/master/screenshots/Symbol_Lookup.png?raw=true" alt="Symbol lookup" width="200" height="433"/></td>
  </tr>
</table>

**End of legacy app support**

The iOS app has been totally reengineered for improved usability and functionality. As a result, there is no upgrade path from the [legacy app](https://github.com/ChartIQ/Charting-Library---iOS-Sample-App-Legacy) (which is compatible with ChartIQ versions 7.0.5&ndash;7.5.0) to the new app/SDK. To take advantage of the major improvements offered by the new mobile app, upgrade to Version 8.2.0 or later of the library and reimplement any custom functionality from your legacy app in the new app.

## Getting started

See the [Getting Started on Mobile: iOS](https://documentation.chartiq.com/tutorial-Starting%20on%20iOS.html) tutorial for instructions on installing the app and using the SDK.

## Customization

For information on changing the appearance of the app, see our [customization](https://documentation.chartiq.com/tutorial-Mobile%20App%20Customization%20iOS.html) tutorial.

## API documentation

- [App/SDK](https://documentation.chartiq.com/ios-sdk)

- [ChartIQ JavaScript library](https://documentation.chartiq.com)

## Questions and support

Contact our development support team at <support@chartiq.com>.

## Contributing to this project

Contribute to this project. Fork it and send us a pull request. We'd love to see what you can do with our charting tools on iOS!
