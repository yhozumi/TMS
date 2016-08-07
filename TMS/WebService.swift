//
//  WebService.swift
//  TMS
//
//  Created by Suke Hozumi on 8/6/16.
//  Copyright © 2016 yhozumi. All rights reserved.
//

import Foundation

//WebService class communicates with the Twitter API v1.1 to retrieve tweet datas.
final class WebService {
  private var authenticationToken: String? 
  private var searchUrl: String
  
  //testing
  var showstatusUrl = "https://api.twitter.com/1.1/statuses/show.json?id=762146320878534658"

  //init that takes in searchText and authentication Token and initializes the properties
  init(searchText: String, authToken: String) {
    self.authenticationToken = authToken
    self.searchUrl = "https://api.twitter.com/1.1/search/tweets.json?q=\(searchText.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)!)%20filter%3Aimages&count=30&include_entities=true%22"
  }
  
  //Takes a search url and gets the json data from twitter API
  typealias completionHandler = (AnyObject) -> ()
  func loadSearch(completion: completionHandler) {
    print(searchUrl)
    guard let url = URL(string: self.searchUrl) else { return }
    let request = configureUrlRequest(with: url)
  
    URLSession.shared.dataTask(with: request) { data, response, error in
      do {
        let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
        completion(json)
      } catch {
        print(error)
      }
    }.resume()
  }
  
  func loadStatus(completion: completionHandler) {
    print(searchUrl)
    guard let url = URL(string: self.showstatusUrl) else { return }
    let request = configureUrlRequest(with: url)
    
    URLSession.shared.dataTask(with: request) { data, response, error in
      do {
        let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
        completion(json)
      } catch {
        print(error)
      }
      }.resume()
  }
  
  //configures URL request to get the Bearer token for authentication
  private func configureUrlRequest(with url: URL) -> URLRequest {
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "GET"
    urlRequest.setValue("Bearer \(authenticationToken!)", forHTTPHeaderField: "Authorization")
    return urlRequest
  }
}
