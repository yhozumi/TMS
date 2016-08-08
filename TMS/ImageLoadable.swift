//
//  ImageLoadable.swift
//  TMS
//
//  Created by Suke Hozumi on 8/8/16.
//  Copyright © 2016 yhozumi. All rights reserved.
//

import UIKit

protocol ImageLoadable {
  func setImage(withURL url: URL, imageView: UIImageView)
}

extension ImageLoadable {
  ///Sets an Image on an Image View by asynchronously downloading the image file and setting it on the view.
  func setImage(withURL url: URL, imageView: UIImageView) {
    URLSession.shared.downloadTask(with: url, completionHandler: { url, response, error in
      do {
        guard let url = url else { print("URL nil"); return }
        let data = try Data(contentsOf: url)
        let image = UIImage(data: data)
        DispatchQueue.main.async {
          imageView.image = image
        }
      } catch {
        print("Data error")
      }
    }).resume()
  }
}
