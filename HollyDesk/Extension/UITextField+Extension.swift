//
//  UITextField+Extension.swift
//  TYOUT
//
//  Created by Mohamed Lotfy on 10/3/18.
//  Copyright © 2018 Gra7. All rights reserved.
//

import UIKit

extension UITextField{
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    enum PaddingSide {
        case left(CGFloat)
        case right(CGFloat)
        case both(CGFloat)
    }
    func addPadding(_ padding: PaddingSide) {
        self.leftViewMode = .always
        self.layer.masksToBounds = true
        switch padding {
        case .left(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.leftView = paddingView
            self.rightViewMode = .always
        case .right(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.rightView = paddingView
            self.rightViewMode = .always
        case .both(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            // left
            self.leftView = paddingView
            self.leftViewMode = .always
            // right
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    }
}
extension UITextField {
    func datePicker<T>(target: T,
                       doneAction: Selector,
                       cancelAction: Selector,
                       datePickerMode: UIDatePicker.Mode = .date) {
        let screenWidth = UIScreen.main.bounds.width
        
        func buttonItem(withSystemItemStyle style: UIBarButtonItem.SystemItem) -> UIBarButtonItem {
            let buttonTarget = style == .flexibleSpace ? nil : target
            let action: Selector? = {
                switch style {
                case .cancel:
                    return cancelAction
                case .done:
                    return doneAction
                default:
                    return nil
                }
            }()
            
            let barButtonItem = UIBarButtonItem(barButtonSystemItem: style,
                                                target: buttonTarget,
                                                action: action)
            return barButtonItem
        }
        
        let datePicker = UIDatePicker(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: screenWidth,
                                                    height: 216))
        datePicker.datePickerMode = datePickerMode
        self.inputView = datePicker
        
        let toolBar = UIToolbar(frame: CGRect(x: 0,
                                              y: 0,
                                              width: screenWidth,
                                              height: 44))

        toolBar.setItems([buttonItem(withSystemItemStyle: .cancel),
                          buttonItem(withSystemItemStyle: .flexibleSpace),
                          buttonItem(withSystemItemStyle: .done)],
                         animated: true)
        
        toolBar.tintColor = UIColor.red//"Done" button colour
        toolBar.barTintColor = UIColor.yellow// bar background colour
        toolBar.sizeToFit()
        self.inputAccessoryView = toolBar
    }
}
extension UIViewController {
    func ShowDatePickerAlert(txt : UITextField , isMax: Bool){
        let myDatePicker: UIDatePicker = UIDatePicker()
        myDatePicker.datePickerMode = .date
        let loc = Locale(identifier: "us")
        myDatePicker.locale = loc
        myDatePicker.frame = CGRect(x: 0, y: 15, width: 290, height: 200)
                
        if isMax {
            myDatePicker.maximumDate = Date()
        }else{
            myDatePicker.minimumDate = Date()
        }
        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: UIAlertController.Style.alert)
        alertController.view.addSubview(myDatePicker)
        let selectAction = UIAlertAction(title: "Ok".localized, style: UIAlertAction.Style.default, handler: { _ in
            txt.text = myDatePicker.date.getFormattedDate()//.arToEnDigits
        })
        let cancelAction = UIAlertAction(title: "Cancel".localized, style: UIAlertAction.Style.cancel, handler: nil)
        alertController.addAction(selectAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion:{})
    }
}
extension Date{
    func getFormattedDate() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US")
        let formateDate = dateFormatter.string(from: self)
        

        // dateFormatter.dateFormat = "dd-MM-yyyy"
        //         dateFormatter.dateFormat = "yyyy-MM-dd"
        print(formateDate)
        return formateDate
    }
    func getFormattedTime() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.locale = Locale(identifier: "en_US")

        //        dateFormatter.dateFormat = "yyyy-MM-dd’T’HH:mm:ssZZZZZ"
        let formateDate = dateFormatter.string(from: self)

        //dateFormatter.timeStyle = .short
        //        return dateFormatter.string(from: formateDate)
        print(formateDate)

        return formateDate
    }
    func getFormatedDateAndTime() -> String{
        let formatDate  = getFormattedDate()
        let formateTime = getFormattedTime()
        let result = "\(formatDate) \(formateTime)"
        print(result)
        return result
    }
}
extension String {
    public var arToEnDigits : String {
        let arabicNumbers = ["٠": "0","١": "1","٢": "2","٣": "3","٤": "4","٥": "5","٦": "6","٧": "7","٨": "8","٩": "9" , "م" : "PM" , "ص" : "AM"]
        var txt = self
        arabicNumbers.map { txt = txt.replacingOccurrences(of: $0, with: $1)}
        return txt
    }
}
