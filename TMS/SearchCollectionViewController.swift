//
//  SearchCollectionViewController.swift
//  TMS
//
//  Created by Suke Hozumi on 8/5/16.
//  Copyright © 2016 yhozumi. All rights reserved.
//

import UIKit
import AVFoundation

private let reuseIdentifier = "Cell"

final class SearchCollectionViewController: UICollectionViewController {
  
  private var twitterAuthentication = TwitterAuthentication()
  private var webService: WebService?
  private var tweets = [Tweet]() { //Not optimized. If this data had more then 500 items it will load slowly.
    didSet {
      DispatchQueue.main.async {
//        self.collectionView?.reloadData()
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //Disables prefetching that was introduced in iOS 10
    //Needs to implement Custom CollectionView Layout however prefetching causes weird issues with Custom collectionview layout.
    if #available(iOS 10, *) {
      collectionView?.isPrefetchingEnabled = false
    }
    self.search(with: "otters")
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showDetail" {
      if let detailVC = segue.destination as? DetailTweetViewController {
        let indexPath = collectionView?.indexPath(for: sender as! ResultCell)
        detailVC.tweet = tweets[indexPath!.row]
      }
    }
  }
  
  
  //This method will empty out the search results and perform a new search.
  //VERY MESSY NEEDS FIXED!!!
  private func search(with text: String) {
    tweets = [Tweet]()
    
    twitterAuthentication.generateAccessToken(completion: { token in
      self.webService = WebService(searchText: text, authToken: token)
      //This closure had memory leak which was solved by using "Profile in Instruments" added [weak self]
      self.webService?.loadSearch { [weak self] json in
        let twitterArray = json["statuses"] as! NSArray
        twitterArray.map { self?.webService?.loadStatus(with: $0["id_str"] as! String) { statusJson in
          self?.tweets.append(Tweet(jsonObject: statusJson as! [String: AnyObject]))
          DispatchQueue.main.async {
            self?.collectionView?.reloadData()
          }
        }}
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
    let tweet = tweets[indexPath.row]
    if let url = tweet.tweetImageUrl {
      setImage(withURL: url, imageView: cell.resultImageView)
    }
    return cell
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return tweets.count
  }
}

extension SearchCollectionViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    guard let text = textField.text else { return false }
    self.search(with: text)
    textField.resignFirstResponder()
    return true
  }
}

extension SearchCollectionViewController: ImageLoadable { }
