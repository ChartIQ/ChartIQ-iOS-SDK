//
//  SceneDelegate.swift
//  ChartIQDemo
//
//  Copyright 2012-2021 by ChartIQ, Inc.
//  All rights reserved
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  @available(iOS 13.0, *)
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
             options connectionOptions: UIScene.ConnectionOptions) {
    guard (scene as? UIWindowScene) != nil else { return }
  }

  @available(iOS 13.0, *)
  func sceneDidDisconnect(_ scene: UIScene) {}

  @available(iOS 13.0, *)
  func sceneDidBecomeActive(_ scene: UIScene) {}

  @available(iOS 13.0, *)
  func sceneWillResignActive(_ scene: UIScene) {}

  @available(iOS 13.0, *)
  func sceneWillEnterForeground(_ scene: UIScene) {}

  @available(iOS 13.0, *)
  func sceneDidEnterBackground(_ scene: UIScene) {}
}
