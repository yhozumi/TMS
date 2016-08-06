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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let tA = TwitterAuthentication()
    
    
    self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 0
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 0
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
    return cell
  }
}
