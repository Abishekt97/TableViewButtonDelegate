//
//  AppDelegate.swift
//  WebView
//
//  Created by Anil Kumar on 21/12/21.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var navigationController: UINavigationController?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    #if DEBUG
    print("DEBUG")
    #else
    print("Other")
    #endif
    
    IQKeyboardManager.shared.enable = true
    
    window = UIWindow(frame: UIScreen.main.bounds)
    navigationController = UINavigationController(rootViewController: ViewController())
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
    
    return true
  }

}

