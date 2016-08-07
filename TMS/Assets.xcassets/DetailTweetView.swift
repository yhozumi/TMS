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
    configureProfileImageView()
  }
  
  private func configureProfileImageView() {
    profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
    profileImageView.clipsToBounds = true
  }
}
