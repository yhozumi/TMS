//
//  DetailTweetView.swift
//  TMS
//
//  Created by Suke Hozumi on 8/6/16.
//  Copyright © 2016 yhozumi. All rights reserved.
//

import UIKit

class DetailTweetView: UIView {
  
  @IBOutlet weak var backgroundImageView: UIImageView!
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var screenNameLabel: UILabel!
  @IBOutlet weak var contentTextLabel: UILabel!

  override func layoutSubviews() {
    configureCircular(view: [profileImageView])
  }
}

extension DetailTweetView: CircularViewing { }
