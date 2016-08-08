//
//  SafariViewable.swift
//  TMS
//
//  Created by Suke Hozumi on 8/8/16.
//  Copyright © 2016 yhozumi. All rights reserved.
//

import UIKit
import SafariServices

//SafariViewable Protocol allows quick integration to add SafariViewController to any class
//Takes in an URL and loads the safariViewController.
protocol SafariViewable: class, SFSafariViewControllerDelegate {
  var url: URL { get }
  func loadSafariViewController(with url: URL)
}

extension SafariViewable where Self: UIViewController {
  func loadSafariViewController(with url: URL) {
    let safariVC = SFSafariViewController(url: url)
    safariVC.delegate = self
    self.present(safariVC, animated: false, completion: nil)
  }
}
