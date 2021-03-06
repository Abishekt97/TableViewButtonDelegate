//
//  AppDelegate.swift
//  WebView2
//
//  Created by Anil Kumar on 27/12/21.
//

import UIKit

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
        
    window = UIWindow(frame: UIScreen.main.bounds)
    navigationController = UINavigationController(rootViewController: ViewController())
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
    
    return true
  }

}

