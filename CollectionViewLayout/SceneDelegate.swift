//
//  SceneDelegate.swift
//  CollectionViewLayout
//
//  Created by Anil Kumar on 03/01/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  var currentScene: UIScene?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let _ = (scene as? UIWindowScene) else { return }
    currentScene = scene
    if UserDefaults.standard.bool(forKey: "isLoggedIn") == true{
      self.setRootViewController(LoginViewController())
    }else{
      self.setRootViewController(HomeViewController())
    }
  }
  
  func setRootViewController(_ viewController: UIViewController){
    
    guard let scene = (currentScene as? UIWindowScene) else { return }
    
    window = UIWindow(frame: scene.coordinateSpace.bounds)
    window?.windowScene = scene
    window?.rootViewController = viewController
    window?.makeKeyAndVisible()
    
  }
  
}

class ButtonViewController: UIViewController {
  
  lazy var button: UIButton! = {
    
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = .darkGray
    button.setTitleColor(.white, for: .normal)
    button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    button.tag = 1
    button.setTitle("Tap", for: .normal)
    return button
    
  }()
  
  
  override func loadView() {
    super.loadView()
    self.view.backgroundColor = .white
    
    setConstraint()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
  }
  
  func setConstraint(){
    
    self.view.addSubview(self.button)
    
    NSLayoutConstraint.activate([
      
      self.button.heightAnchor.constraint(equalToConstant: 60),
      self.button.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.66),
      self.button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      self.button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
      
    ])
    
  }
  
  @objc func buttonAction(){  }
  
}

class HomeViewController: ButtonViewController{
  
  override func loadView() {
    super.loadView()
    self.view.backgroundColor = .red
    self.button.setTitle(String(describing: HomeViewController.self), for: .normal)
  }
  
  override func buttonAction() {
    let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
    sceneDelegate.setRootViewController(LoginViewController())
  }
  
}


class LoginViewController: ButtonViewController{
  
  override func loadView() {
    super.loadView()
    self.view.backgroundColor = .green
    self.button.setTitle(String(describing: LoginViewController.self), for: .normal)
  }
  
  override func buttonAction() {
    let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
    sceneDelegate.setRootViewController(HomeViewController())
  }
  
}
