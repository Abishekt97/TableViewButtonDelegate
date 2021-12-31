//
//  ServerCommunicationController.swift
//  
//
//  Created by Arunkumar on 12/01/21.
//  Copyright © 2021 AIT. All rights reserved.
//

import Foundation

struct ServerCommunicationController {
    
      
  static let queue = DispatchQueue(label: Bundle.main.bundleIdentifier ?? "queue.app..main", qos: .background, attributes: .concurrent, autoreleaseFrequency: .inherit, target: .global(qos: .userInitiated))
  
  public static let operationQueue: OperationQueue = {
    let operation = OperationQueue()
    operation.qualityOfService = .background
    operation.maxConcurrentOperationCount = 1
    operation.name = Bundle.main.bundleIdentifier
    return operation
  }()
  
  public static let customSession: URLSession = {
    let configuration = URLSessionConfiguration.ephemeral
    configuration.timeoutIntervalForRequest = 120
    let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: operationQueue)
    return session
  }()
  
  
  static func networkRequest(endPoint: String, requestMethod:String = "GET" , params: [String: String]? = nil, postBody: [String: Any]? = nil, completionHandler: @escaping (Any) -> ()) {
    guard Reachability.isConnectedToNetwork() else {
      completionHandler(NetworkRequestError.noInternet.rawValue)
      return
    }
    
    let urlComponend = ServerCommunicationController.urlComponentsHandler(params: params, endPoint: endPoint)
    
    guard let url = urlComponend?.url else {
      return
    }
    
    debugPrint("------------------------->url", url)
    debugPrint("------------------------->postBody", postBody ?? [:])
    
    var request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 120)
    request.httpMethod = requestMethod
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    
    if let body = postBody{
      do {
         let data = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        request.httpBody = data
      } catch let error {
        completionHandler(NetworkRequestError.requestCancelled.rawValue)
        return
      }
    }
    self.apiCall(request: request) { data in
      completionHandler(data)
    }
  }
  
  static func apiCall(request: URLRequest, completionHandler: @escaping (Any?) -> ()){
    queue.async {
      self.customSession.dataTask(with: request) { (data, response, error) in
        
        if let error = error {
          completionHandler((error as? NSError)?.description)
          return
        }

        
        guard let response = response as? HTTPURLResponse else {
          completionHandler(NetworkRequestError.defaultError.rawValue)
          return
        }
        if response.statusCode == 503{
          completionHandler(NetworkRequestError.underMaintance.rawValue)
          return
        }
        guard let data = data else{
          completionHandler(response)
          return
        }
        
        do {
          let serlization = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
          completionHandler(serlization)
        } catch let error {
          debugPrint(error.localizedDescription)
        }
        
      }.resume()
    }
  }
  
  static func urlComponentsHandler(params: [String: String]?, endPoint: String) -> URLComponents? {
    var urlComponend = URLComponents(string: endPoint)
    
    if let urlParams = params{
      var item = [URLQueryItem]()
      for (_, (key, value)) in urlParams.enumerated(){
        item.append(URLQueryItem(name: key, value: value))
      }
      urlComponend?.queryItems = item
    }
    return urlComponend
  }
  
  
}


enum NetworkRequestError: String {
  case connectionLost = "Your internet connection is lost. Please try again."
  case timeout = "Unable to connect with the server. Would you like to retry?"
  case noInternet = "Please check your internet connection and try agian."
  case requestCancelled = "Request cancelled"
  case defaultError = "There was a problem with our server. Please try after sometime."
  case dataDecodeError = "Data Decode Error"
  case dataNotFound = "Data not found"
  case underMaintance = "We are under maintenance now. Please come back later."
}
