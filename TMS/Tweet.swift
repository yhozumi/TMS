//
//  Tweet.swift
//  TMS
//
//  Created by Suke Hozumi on 8/6/16.
//  Copyright © 2016 yhozumi. All rights reserved.
//

import Foundation

struct Tweet {
  private(set) var text: String
  private(set) var id: String
  private(set) var user: TwitterUser
}

extension Tweet {
  init(jsonObject: [String: AnyObject]) {
    self.id = jsonObject["id_str"] as! String
    self.text = jsonObject["text"] as! String
    let user = jsonObject["user"] as! [String: AnyObject]
    self.user = TwitterUser(userData: user)
  }
}
