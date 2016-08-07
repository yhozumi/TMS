//
//  TwitterAuthentication.swift
//  TMS
//
//  Created by Suke Hozumi on 8/5/16.
//  Copyright © 2016 yhozumi. All rights reserved.
//
//  This class is responsible for performing Application Only Authentication with Twitter Search API.

import Foundation

struct TwitterAuthentication {
  
  static let consumerKey = "8ofZhLxohw0Y8HIgIMABJSRgB"
  static let consumerSecretKey = "uyWuPwTc2VSY3oLeMlzp0KI0rxYHM1IJnmksu9PhClESb0ea0Q"
  static let twitterAuthUrlString = "https://api.twitter.com/oauth2/token"

  //It will POST to Twitter API and recieve authentication token asynchronously
  func generateAccessToken(completion: (String) -> ()) {
    let authUrl = URL(string: TwitterAuthentication.twitterAuthUrlString)!
    let urlRequest = configureUrlRequest(with: authUrl)
    
    let session = URLSession.shared
    let dataTask = session.dataTask(with: urlRequest) { data, response, error in
      do {
        let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: AnyObject]
        if let accessToken = json["access_token"] as? String {
          completion(accessToken)
        }
      } catch {
        print("error parsing JSON data")
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
