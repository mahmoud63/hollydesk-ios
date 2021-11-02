//
//  UIButton+.swift
//  HollyDesk
//
//  Created by rania refaat on 02/10/2021.
//

import UIKit

extension UIButton {
    var title: String {
        get {
            return title(for: .normal) ?? ""
        } set {
            setTitle(newValue, for: .normal)
        }
    }
    
    func underlineText() {
        guard let title = title(for: .normal) else { return }

        let titleString = NSMutableAttributedString(string: title)
        titleString.addAttribute(
          .underlineStyle,
          value: NSUnderlineStyle.single.rawValue,
          range: NSRange(location: 0, length: title.count)
        )
        setAttributedTitle(titleString, for: .normal)
      }

}
