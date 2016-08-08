//
//  GradientView.swift
//  TMS
//
//  Created by Suke Hozumi on 8/8/16.
//  Copyright © 2016 yhozumi. All rights reserved.
//

import UIKit

class GradientView: UIView {
  //gradient layer is expensive so lazily initialized. 
  lazy private var gradientLayer: CAGradientLayer = {
    let layer = CAGradientLayer()
    layer.colors = [UIColor.clear.cgColor, UIColor(white: 0.0, alpha: 0.75).cgColor]
    layer.locations = [0.0, 1.0]
    return layer
  }()
  
  override func awakeFromNib() {
    super.awakeFromNib()
    backgroundColor = UIColor.clear
    layer.addSublayer(gradientLayer)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    gradientLayer.frame = bounds
  }
}
