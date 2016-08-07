//
//  DetailTweetViewController.swift
//  TMS
//
//  Created by Suke Hozumi on 8/6/16.
//  Copyright © 2016 yhozumi. All rights reserved.
//

import UIKit

class DetailTweetViewController: UIViewController {
  
  @IBOutlet var detailView: DetailTweetView!
  var tweet: Tweet?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    configure(view: detailView)
  }
  
  
  private func configure(view: DetailTweetView) {
    guard let tweet = tweet else { return }
    view.nameLabel.text = tweet.user.name
    view.screenNameLabel.text = tweet.user.name
    view.contentTextLabel.text = tweet.text
  }
  
  @IBAction func closeButtonPressed(_ sender: AnyObject) {
    dismiss(animated: true, completion: nil)
  }
}
