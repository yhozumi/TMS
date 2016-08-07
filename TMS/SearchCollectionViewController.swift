//
//  SearchCollectionViewController.swift
//  TMS
//
//  Created by Suke Hozumi on 8/5/16.
//  Copyright © 2016 yhozumi. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class SearchCollectionViewController: UICollectionViewController {
  
  private var webService: WebService?
  private var tweets = [Tweet]() {
    didSet {
      DispatchQueue.main.async {
        self.collectionView?.reloadData()
      }
    }
  }
  private var twitterAuthentication = TwitterAuthentication()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showDetail" {
      if let detailVC = segue.destinationViewController as? DetailTweetViewController {
        let indexPath = collectionView?.indexPath(for: sender as! ResultCell)
        detailVC.tweet = tweets[indexPath!.row]
      }
    }
  }
  
  private func search(with text: String) {
    tweets = [Tweet]()
    
    twitterAuthentication.generateAccessToken(completion: { token in
      self.webService = WebService(searchText: text, authToken: token)
      self.webService?.loadSearch { data in
        let twitterArray = data["statuses"] as! NSArray
        twitterArray.map { self.tweets.append(Tweet(jsonObject: $0 as! [String: AnyObject])) }
      }
    })
  }
}


//Data Source
extension SearchCollectionViewController {
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ResultCell
    cell.label.text = tweets[indexPath.row].user.name
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return tweets.count
  }
}

extension SearchCollectionViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    guard let text = textField.text else { return false }
    search(with: text)
    textField.resignFirstResponder()
    return true
  }
}
