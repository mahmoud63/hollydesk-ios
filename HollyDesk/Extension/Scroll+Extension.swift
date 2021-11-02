//
//  Scroll+Extension.swift
//  E-Commerce-App
//
//  Created by rania refaat on 10/16/20.
//

import UIKit
extension UIScrollView {
   func scrollToBottom(animated: Bool) {
     if self.contentSize.height < self.bounds.size.height { return }
     let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height)
     self.setContentOffset(bottomOffset, animated: animated)
  }
}
