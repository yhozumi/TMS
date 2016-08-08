//
//  DetailTweetViewController.swift
//  TMS
//
//  Created by Suke Hozumi on 8/6/16.
//  Copyright © 2016 yhozumi. All rights reserved.
//

import UIKit

final class DetailTweetViewController: UIViewController {
  
  @IBOutlet var detailView: DetailTweetView!
  var tweet: Tweet?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    configure(view: detailView)
  }
  
  //Configures all the view in DetailTweetView
  private func configure(view: DetailTweetView) {
    guard let tweet = tweet else { return }
    view.nameLabel.text = tweet.user.name
    view.screenNameLabel.text = "@\(tweet.user.screenName)"
    view.contentTextLabel.text = tweet.text
    setImage(withURL: tweet.user.profileImageUrl, imageView: view.profileImageView)
    if let url = tweet.tweetImageUrl {
      setImage(withURL: url, imageView: view.backgroundImageView)
      UIView.animate(withDuration: 1.0) {
        view.backgroundImageView.alpha = 1.0
      }
    }
  }
  
  @IBAction func viewTweetButtonPressed(_ sender: AnyObject) {
    loadSafariViewController(with: url)
  }

  @IBAction func closeButtonPressed(_ sender: AnyObject) {
    dismiss(animated: true, completion: nil)
  }
}

extension DetailTweetViewController: SafariViewable {
  var url: URL {
    return (tweet?.expandedUrl)!
  }
}

extension DetailTweetViewController: ImageLoadable { }

