//
//  ViewController.swift
//  HTTPSSecureConnectionWorkAround
//
//  Created by Anil Kumar on 31/12/21.
//

import UIKit

class ViewController: UIViewController {

  lazy var textView: UITextView = {
    
    let textView  = UITextView()
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.backgroundColor = .clear
    textView.textColor = .black
    return textView
    
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .white
    self.view.addSubview(self.textView)
    
    NSLayoutConstraint.activate([
    
      self.textView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
      self.textView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
      self.textView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
      self.textView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),

    ])
    
    ServerCommunicationController.networkRequest(endPoint: "http://www.7timer.info/bin/api.pl?lon=113.17&lat=23.09&product=astro&output=json") { data in
      
      DispatchQueue.main.async {
        self.textView.text = "\(data)"
      }
      
    }
    
  }


}

