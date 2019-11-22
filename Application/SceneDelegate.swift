//
//  SceneDelegate.swift
//  EmpireStrikesMVVM
//
//  Created by Samira CHALAL on 28/10/2019.
//  Copyright © 2019 ACME. All rights reserved.
//

import UIKit
import SwiftUI

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    let rootFactory = TripsCoordinator()
    rootFactory.route(to: TripsRoute.list)
    
    let window = UIWindow(windowScene: windowScene)
    window.rootViewController = rootFactory.mainController
    self.window = window
    window.makeKeyAndVisible()
  }
}
