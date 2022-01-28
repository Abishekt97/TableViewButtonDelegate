//
//  ViewController.swift
//  WebView
//
//  Created by Anil Kumar on 21/12/21.
//

import UIKit
import WebKit
import MessageUI
import IQKeyboardManagerSwift

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
  
  lazy var textField: TRTextField! = {
    
    let textField = TRTextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.borderStyle = .roundedRect
    textField.placeholder = "Enter"
    textField.delegate = self
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
    
    // for simple array
    
    let id = 4
    
    let roster: [TeamMember] = [.init(id: 1, name: "Abishek", age: 19),
                                .init(id: 2, name: "Dinesh", age: 22),
                                .init(id: 3, name: "Praveen", age: 24),
                                .init(id: 4, name: "Sam", age: 25),
                                .init(id: 5, name: "David", age: 21)]
    let firstMember = roster.first{$0.id == id}
    
    print(firstMember)
    print(firstMember?.name)
    
    let descendingSorted = roster.sorted{$0.name > $1.name} // for descending order
    let ascendingSorted = roster.sorted{$0.name < $1.name} // for ascending order
    print(descendingSorted)
    print(ascendingSorted)
    //[, , , , ]
    
    let descendingSorted1 = roster.sorted { teamMember1, teamMember2 in
      return teamMember1.name.compare(teamMember2.name) == .orderedDescending
    } // for descending order
    let ascendingSorted1 = roster.sorted{ teamMember1, teamMember2 in
      return teamMember1.name.compare(teamMember2.name) == .orderedAscending
    } // for ascending order
    print(descendingSorted1)
    print(ascendingSorted1)
    
    let item = UIMenuItem(title: "Paste & Go", action: #selector(pasteAndGo(_:)))
    UIMenuController.shared.menuItems = [item]
    
  }
  
  override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    if action == #selector(pasteAndGo(_:)) {
      return true
    }
    return textField.canPerformAction(action, withSender: sender)
  }
  
  override func pasteAndGo(_ sender: Any?) {
    textField.pasteAndGo(sender)
  }
  
  
  @objc func didTaped(_ sender: UIButton){
    
    //    self.label.text = "No of times Taped: \(sender.tag)"
    //    self.button.tag += 1
    
    //    self.navigationController?.pushViewController(SecondViewController(), animated: true)
    
    let file = AppFile()
    _ = file.writeFile(containing: textField.text ?? "", to: .Documents, withName: "textFile1.txt")
    _ = file.list()
    print("file written...")
    
    sendEmail()
    
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

extension ViewController: UITextFieldDelegate{
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.view.endEditing(true)
    return true
  }
  
}

struct TeamMember{
  
  let id: Int
  let name: String
  let age: Double
  
}

extension TeamMember: Hashable, Equatable{
  
  static func ==(_ lhs:Self, _ rhs: Self) -> Bool{
    
    return lhs.id == rhs.id
    
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id.hashValue)
  }
  
}

enum ViewCase{
  
  case normal
  case tapped(Int)
  
}












extension ViewController: MFMailComposeViewControllerDelegate, AppDirectoryNames{
  
  func sendEmail() {
    if MFMailComposeViewController.canSendMail() {
      let mailComposer = MFMailComposeViewController()
      mailComposer.setSubject("MitekData Logs Data")
      mailComposer.setMessageBody("Sent the mitek data to developers", isHTML: false)
      mailComposer.setToRecipients(["abishekt.aitech@gmail.com"])
      let filePath = getURL(for: AppDirectories.Documents).path + "/" + "textFile1.txt"
      guard let fileContents = FileManager.default.contents(atPath: filePath) else { return  }
      
      mailComposer.addAttachmentData(fileContents, mimeType: "application/pdf", fileName: "mitekLog\(Date().timeIntervalSince1970)")
      mailComposer.mailComposeDelegate = self
      self.present(mailComposer, animated: true
                   , completion: nil)
      
      
    } else {
      print("Email is not configured in settings app or we are not able to send an email")
    }
  }
  
  func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    controller.dismiss(animated: true, completion: nil)
  }
  
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



class TRTextField: UITextField{
  
  override init(frame: CGRect){
    super.init(frame: frame)
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func pasteAndGo(_ sender: Any?) {
    super.pasteAndGo(sender)
    
  }
  
}
