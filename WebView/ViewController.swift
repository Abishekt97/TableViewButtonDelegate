//
//  ViewController.swift
//  WebView
//
//  Created by Anil Kumar on 21/12/21.
//

import UIKit
import WebKit

class ViewController: UIViewController {
  
  
  lazy var button: UIButton! = {

    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = .darkGray
    button.setTitleColor(.white, for: .normal)
    button.addTarget(self, action: #selector(didTaped(_:)), for: .touchUpInside)
    button.tag = 1
    button.setTitle("Tap", for: .normal)
    return button

  }()
  
  lazy var textField: UITextField! = {
    
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.borderStyle = .roundedRect
    textField.placeholder = "Enter"
    return textField
    
  }()

  
  lazy var label: UILabel! = {

    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .black
    label.font = .systemFont(ofSize: 17)
    label.textAlignment = .center
    return label

  }()
  
  var currentcase: ViewCase = .normal
    
  override var preferredStatusBarStyle: UIStatusBarStyle{
    return .darkContent
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    self.view.backgroundColor = .white
    self.setConstraint()
    
    if case .tapped(let index) = currentcase{
      
      self.label.text = "Selected button \(index)"
      self.button.isHidden = true
      self.textField.isHidden = true
    }
    
  }
  
  @objc func didTaped(_ sender: UIButton){

//    self.label.text = "No of times Taped: \(sender.tag)"
//    self.button.tag += 1
    
    self.navigationController?.pushViewController(SecondViewController(), animated: true)

  }
  
  func setConstraint(){
    
    self.view.addSubview(self.button)
    self.view.addSubview(self.label)
    self.view.addSubview(self.textField)

    NSLayoutConstraint.activate([
    
      self.button.heightAnchor.constraint(equalToConstant: 60),
      self.button.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.66),
      self.button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      self.button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
 
      self.textField.heightAnchor.constraint(equalToConstant: 60),
      self.textField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.66),
      self.textField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      self.textField.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
      
      self.label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      self.label.topAnchor.constraint(equalTo: self.button.topAnchor, constant: UIScreen.main.bounds.height * 0.12),
      self.label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),

    ])

  }
  
}




enum ViewCase{
  
  case normal
  case tapped(Int)
  
}


























extension ViewController: WKUIDelegate, WKNavigationDelegate{
  
  func webViewDidClose(_ webView: WKWebView) {
    print("-----------------------> webViewDidClose")
  }
  
  func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
    print("-----------------------> webViewWebContentProcessDidTerminate")
  }
  
  func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
    print("-----------------------> didCommit")
  }
  
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    print("-----------------------> didFinish")
  }
  
  func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    print("-----------------------> didStartProvisionalNavigation")
  }
  
  func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
    print("-----------------------> didFail navigation")
  }
  
  func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
    print("-----------------------> didReceiveServerRedirectForProvisionalNavigation")
  }
  
  func webView(_ webView: WKWebView, contextMenuDidEndForElement elementInfo: WKContextMenuElementInfo) {
    print("-----------------------> contextMenuDidEndForElement")
  }
  
  func webView(_ webView: WKWebView, navigationAction: WKNavigationAction, didBecome download: WKDownload) {
    print("-----------------------> navigationAction didBecome")
  }
  
  func webView(_ webView: WKWebView, contextMenuWillPresentForElement elementInfo: WKContextMenuElementInfo) {
    print("-----------------------> contextMenuWillPresentForElement elementInfo")
  }
  
  func webView(_ webView: WKWebView, navigationResponse: WKNavigationResponse, didBecome download: WKDownload) {
    print("-----------------------> navigationResponse didBecome")
  }
  
  func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
    print("-----------------------> didFailProvisionalNavigation")
  }
  
  func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
    decisionHandler(.allow)
  }
  
}


class WebViewHistory: WKBackForwardList {
  
  /* Solution 1: return nil, discarding what is in backList & forwardList */
  
  override var backItem: WKBackForwardListItem? {
    return nil
  }
  
  override var forwardItem: WKBackForwardListItem? {
    return nil
  }
  
  /* Solution 2: override backList and forwardList to add a setter */
  
  var myBackList = [WKBackForwardListItem]()
  
  override var backList: [WKBackForwardListItem] {
    get {
      return myBackList
    }
    set(list) {
      myBackList = list
    }
  }
  
  func clearBackList() {
    backList.removeAll()
  }
}

class WebView: WKWebView {
  
  var history: WebViewHistory
  
  override var backForwardList: WebViewHistory {
    return history
  }
  
  init(frame: CGRect, configuration: WKWebViewConfiguration, history: WebViewHistory) {
    self.history = history
    super.init(frame: frame, configuration: configuration)
  }
  
  /* Not sure about the best way to handle this part, it was just required for the code to compile... */
  
  required init?(coder: NSCoder) {
    
    if let history = coder.decodeObject(forKey: "history") as? WebViewHistory {
      self.history = history
    }
    else {
      history = WebViewHistory()
    }
    
    super.init(coder: coder)
  }
  
  override func encode(with aCoder: NSCoder) {
    super.encode(with: aCoder)
    aCoder.encode(history, forKey: "history")
  }
}
