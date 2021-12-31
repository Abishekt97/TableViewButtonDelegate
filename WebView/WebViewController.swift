//
//  WebViewController.swift
//  WebView
//
//  Created by Anil Kumar on 29/12/21.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

  lazy var webView: WKWebView! = {
    
    let webView = WKWebView(frame: .zero, configuration: configuration)
    webView.translatesAutoresizingMaskIntoConstraints = false
    webView.uiDelegate = self
    webView.navigationDelegate = self
    let request = URLRequest(url: .init(string: "https://developer.apple.com/videos/play/wwdc2020/10188/")!)
    webView.load(request)
    return webView
    
  }()
  
  lazy var configuration: WKWebViewConfiguration! = {
    let configuration = WKWebViewConfiguration()
   // configuration.allowsInlineMediaPlayback = true
    configuration.mediaTypesRequiringUserActionForPlayback = .audio
    configuration.allowsPictureInPictureMediaPlayback = true
    return configuration
  }()
  
  override func loadView() {
    super.loadView()
    
    self.view.backgroundColor = .white
    self.view.addSubview(self.webView)
    
    // Constraint
    
    NSLayoutConstraint.activate([
    
      self.webView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
      self.webView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
      self.webView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
      self.webView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),

    ])
    
  }

}

extension WebViewController: WKUIDelegate{
  
  
  
}

extension WebViewController: WKNavigationDelegate{
  
  
  func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse) async -> WKNavigationResponsePolicy {
    debugPrint("---------------------------- decidePolicyFor navigationResponse")
    return .allow
  }
    
  func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences: WKWebpagePreferences, decisionHandler: @escaping (WKNavigationActionPolicy, WKWebpagePreferences) -> Void) {
    debugPrint("---------------------------- decidePolicyFor navigationAction")
    decisionHandler(.allow, .init())
  }
  
  
}
