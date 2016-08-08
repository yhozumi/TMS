//
//  Tweet.swift
//  TMS
//
//  Created by Suke Hozumi on 8/6/16.
//  Copyright © 2016 yhozumi. All rights reserved.
//

import Foundation
import UIKit

//Clean up
struct Tweet {
  private(set) var text: String
  private(set) var id: String
  private(set) var user: TwitterUser
  private(set) var tweetImageUrl: URL?
  private(set) var tweetVideoUrl: URL?
  private(set) var expandedUrl: URL
}

//By having init in the extension, it allows the memberwise init() to remain.
extension Tweet {
  init(jsonObject: [String: AnyObject]) {
    //Very unsafe. Needs fixed so that it's not force unwrapped. 
    self.id = jsonObject["id_str"] as! String
    self.text = jsonObject["text"] as! String

    let user = jsonObject["user"] as! [String: AnyObject]
    self.user = TwitterUser(userData: user)
    print(jsonObject)
    
    let ents = jsonObject["entities"] as! [String: AnyObject]
    let media = ents["media"] as! NSArray
    let mediaFirst = media[0] as! [String: AnyObject]
    self.tweetImageUrl = URL(string: mediaFirst["media_url"] as! String)
    self.expandedUrl = URL(string: mediaFirst["expanded_url"] as! String)!
  }
}
