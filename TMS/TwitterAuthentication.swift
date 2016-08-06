//
//  TwitterAuthentication.swift
//  TMS
//
//  Created by Suke Hozumi on 8/5/16.
//  Copyright © 2016 yhozumi. All rights reserved.
//
//  This class is responsible for performing Application Only Authentication with Twitter Search API.

import Foundation

final class TwitterAuthentication {
  
  static let consumerKey = "P0egUUMUMdKf7QkwQ7tvVfdcG"
  static let consumerSecretKey = "egSbIuYr0ardQJSlb23Y9TptRD7cUBvZ5QDj3BnF7v0dbNQpeI"
  static let twitterAuthUrlString = "https://api.twitter.com/oauth2/token"
  
  private(set) var authToken: String? {
    didSet {
      print(authToken!)
    }
  }
  
  init() {
    generateAccessToken()
  }
  
  //It will POST to Twitter API and recieve authentication token asynchronously
  private func generateAccessToken() {
    let authUrl = URL(string: TwitterAuthentication.twitterAuthUrlString)!
    let urlRequest = configureUrlRequest(with: authUrl)
    
    let session = URLSession.shared
    let dataTask = session.dataTask(with: urlRequest) { data, response, error in
      do {
        let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: AnyObject]
        self.authToken = json["access_token"] as! String
      } catch {
        print(error)
      }
    }
    dataTask.resume()
  }
  
  //encapsulated logic for URLRequest
  private func configureUrlRequest(with url: URL) -> URLRequest {
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "POST"
    urlRequest.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
    urlRequest.setValue("Basic \(self.configureBase64EncodedBearerToken())", forHTTPHeaderField: "Authorization")
    return urlRequest
  }
  
  //returns a String data of Base64Encoded Bearer token that Twitter API needs to see on HTTP header
  private func configureBase64EncodedBearerToken() -> String {
    let bearerToken = "\(TwitterAuthentication.consumerKey):\(TwitterAuthentication.consumerSecretKey)"
    let tokenData = bearerToken.data(using: String.Encoding.utf8)!
    return tokenData.base64EncodedString(options: .endLineWithCarriageReturn)
  }
  
}
