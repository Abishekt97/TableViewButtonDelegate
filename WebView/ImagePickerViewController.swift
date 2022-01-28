//
//  ImagePickerViewController.swift
//  WebView
//
//  Created by Anil Kumar on 27/01/22.
//

import UIKit
import Foundation
import ImageIO


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

class ImagePickerViewController: ButtonViewController {
  

  var imageController: UIImagePickerController?
  
  override func loadView() {
    super.loadView()
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

  }
   
  override func buttonAction(){
    
    imageController = UIImagePickerController()
    imageController?.delegate = self
    imageController?.sourceType = .camera
    imageController?.modalPresentationStyle = .currentContext
    let overlay = UIView()
    overlay.backgroundColor = UIColor(white: 1, alpha: 0.5)
    overlay.translatesAutoresizingMaskIntoConstraints = false
    imageController?.cameraOverlayView!.addSubview(overlay)
    // This is using a UIView extension to constrain my views. It's as simple as it looks.
    overlay.topAnchor.constraint(equalTo: (imageController?.cameraOverlayView!.topAnchor)!).isActive = true
    overlay.leftAnchor.constraint(equalTo: (imageController?.cameraOverlayView!.leftAnchor)!).isActive = true
    overlay.bottomAnchor.constraint(equalTo: (imageController?.cameraOverlayView!.bottomAnchor)!).isActive = true
    overlay.rightAnchor.constraint(equalTo: (imageController?.cameraOverlayView!.rightAnchor)!).isActive = true
    self.present(imageController!, animated: true)
    
  }
}

extension ImagePickerViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate{
  
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    self.dismiss(animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    self.dismiss(animated: true, completion: nil)
  }
  
  func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
    
    debugPrint(String(describing: viewController.self))
    
  }
  
}

