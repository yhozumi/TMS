//
//  ResultCell.swift
//  TMS
//
//  Created by Suke Hozumi on 8/6/16.
//  Copyright © 2016 yhozumi. All rights reserved.
//

import UIKit

final class ResultCell: UICollectionViewCell {
  
  @IBOutlet weak var resultImageView: UIImageView!
  
  override func prepareForReuse() {
    resultImageView.image = UIImage()
  }
}
