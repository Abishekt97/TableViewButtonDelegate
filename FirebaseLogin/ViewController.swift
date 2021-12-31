//
//  ViewController.swift
//  FirebaseLogin
//
//  Created by Anil Kumar on 31/12/21.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController {

  lazy var button: GIDSignInButton! = {

    let button = GIDSignInButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(self.signIn(sender:)), for: .touchUpInside)
    return button

  }()

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .white
    self.view.addSubview(self.button)
    
    NSLayoutConstraint.activate([
    
      self.button.heightAnchor.constraint(equalToConstant: 60),
      self.button.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.66),
      self.button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      self.button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
 
    ])
    
  }
  
  /// This is a button Action used for google login
  /// - Parameter sender: this parameter contain the google sign-in  button instances
  @objc func signIn(sender: Any) {
    
    guard let clientID = FirebaseApp.app()?.options.clientID else { return }

    // Create Google Sign In configuration object.
    let config = GIDConfiguration(clientID: clientID)

    // Start the sign in flow!
    GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in

      if let error = error {
        // ...
        return
      }

      guard
        let authentication = user?.authentication,
        let idToken = authentication.idToken
      else {
        return
      }

      let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                     accessToken: authentication.accessToken)

      Auth.auth().signIn(with: credential) { authResult, error in
          if let error = error {
            let authError = error as NSError
            if authError.code == AuthErrorCode.secondFactorRequired.rawValue {
              // The user is a multi-factor user. Second factor challenge is required.
              let resolver = authError
                .userInfo[AuthErrorUserInfoMultiFactorResolverKey] as! MultiFactorResolver
              var displayNameString = ""
              for tmpFactorInfo in resolver.hints {
                displayNameString += tmpFactorInfo.displayName ?? ""
                displayNameString += " "
              }
            } else {
              return
            }
            // ...
            return
          }
          // User is signed in
          // ...
      }    }
  }
}

