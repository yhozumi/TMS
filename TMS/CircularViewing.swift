//
//  CircularViewing.swift
//  TMS
//
//  Created by Suke Hozumi on 8/7/16.
//  Copyright © 2016 yhozumi. All rights reserved.
//

import UIKit

//CircularViewing protocol helps with reusability and abstraction of configuring a view to a circular view
protocol CircularViewing {
  func configureCircular(view: [UIView])
}

//Protocol Extension allows a default implementation of the method.
extension CircularViewing {
  func configureCircular(view: [UIView]) {
    //Checks if the height and the width is the same. Cannot round the view to a circle unless the height and width is the same
    let _ = view.map {
      if $0.frame.width == $0.frame.height {
        $0.layer.cornerRadius = $0.frame.width / 2
        $0.clipsToBounds = true
      }
    }
  }
}
