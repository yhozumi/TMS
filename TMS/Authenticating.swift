//
//  Authenticating.swift
//  TMS
//
//  Created by Suke Hozumi on 8/7/16.
//  Copyright © 2016 yhozumi. All rights reserved.
//

import Foundation

protocol Authenticating {
  func configureUrlRequest(with url: URL, authenticationToken: String) -> URLRequest
}

extension Authenticating {
  ///Configures a URL request with Twitter AuthenticationToken in the HTTPHeader
  func configureUrlRequest(with url: URL, authenticationToken: String) -> URLRequest {
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "GET"
    urlRequest.setValue("Bearer \(authenticationToken)", forHTTPHeaderField: "Authorization")
    return urlRequest
  }
}
