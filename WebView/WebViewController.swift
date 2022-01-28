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
    webView.allowsBackForwardNavigationGestures = true
   let request = URLRequest(url: .init(string: "https://www.google.com")!)
    webView.load(request)
    return webView
    
  }()
  
  lazy var indicatorView: UIActivityIndicatorView = {
    
    let indicator = UIActivityIndicatorView(style: .large)
    indicator.translatesAutoresizingMaskIntoConstraints = false
    indicator.color = .red
    indicator.hidesWhenStopped = true
    return indicator
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
    self.view.addSubview(self.indicatorView)
    
    print(UIDevice.current.name)

    // Constraint
    
    NSLayoutConstraint.activate([
    
      self.webView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
      self.webView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
      self.webView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
      self.webView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
      
      self.indicatorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      self.indicatorView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),

    ])
    
  }

}

extension WebViewController: WKUIDelegate{
  
  
  
}

extension WebViewController: WKNavigationDelegate{
  
  func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    self.indicatorView.isHidden = false
    self.indicatorView.startAnimating()
  }
  
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    debugPrint("----------------------------\(webView.url?.absoluteString ?? "")")
    self.indicatorView.stopAnimating()
  }
  
  func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
    self.indicatorView.stopAnimating()
  }
  
  func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
    self.indicatorView.stopAnimating()
  }
  
  func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse) async -> WKNavigationResponsePolicy {
    debugPrint("---------------------------- decidePolicyFor navigationResponse")
    return .allow
  }
    
  func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences: WKWebpagePreferences, decisionHandler: @escaping (WKNavigationActionPolicy, WKWebpagePreferences) -> Void) {
    debugPrint("---------------------------- decidePolicyFor navigationAction")
    decisionHandler(.allow, .init())
  }
  
  
}
