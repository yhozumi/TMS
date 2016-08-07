//
//  TwitterUser.swift
//  TMS
//
//  Created by Suke Hozumi on 8/6/16.
//  Copyright © 2016 yhozumi. All rights reserved.
//

import Foundation

//Holds all the data of the Twitter User
struct TwitterUser {
  let screenName: String
  let name: String
  let profileUrl: URL
  let profileImageUrl: URL
}

extension TwitterUser {
  //To Do: Clean up
  init(userData: [String: AnyObject]) {
    self.screenName = userData["screen_name"] as! String
    self.name = userData["name"] as! String
    self.profileImageUrl = URL(string: userData["profile_image_url_https"] as! String)!
    self.profileUrl = URL(string: "")!
  }
}
