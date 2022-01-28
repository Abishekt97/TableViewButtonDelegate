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
  
  func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    debugPrint("willFinishLaunchingWithOptions")
    return true
  }
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    debugPrint("didFinishLaunchingWithOptions")
//    #if DEBUG
//    print("DEBUG")
//    #else
//    print("Other")
//    #endif
    
    IQKeyboardManager.shared.enable = true
    
    window = UIWindow(frame: UIScreen.main.bounds)
    navigationController = UINavigationController(rootViewController: ImagePickerViewController())
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
    

    
    return true
  }
  
  func applicationDidBecomeActive(_ application: UIApplication) {
    debugPrint("applicationDidBecomeActive")
  }
  
  func applicationWillResignActive(_ application: UIApplication) {
    debugPrint("applicationWillResignActive")
  }
  
  func applicationDidEnterBackground(_ application: UIApplication) {
    debugPrint("applicationDidEnterBackground")
  }
  
  func applicationWillEnterForeground(_ application: UIApplication) {
    debugPrint("applicationWillEnterForeground")
  }
  
  func applicationWillTerminate(_ application: UIApplication) {
    debugPrint("applicationWillTerminate")
  }
  
}


class Human{
  
  var humanClosure: (() -> ())?
  var name: String = "vadian"
  
  init(){
    humanClosure = {

      debugPrint("humanClosure", self.name)

    }
    
  }
  
  deinit {
    debugPrint("deinitialize humanClosure")
  }
  
}
