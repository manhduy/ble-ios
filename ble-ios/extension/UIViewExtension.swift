//
//  UIViewExtension.swift
//  ble-ios
//
//  Created by duyha on 5/16/20.
//  Copyright © 2020 Duy Ha. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
extension UIView {

    // Set cornerRadius to view on storyboard
    @IBInspectable var cornerRadius: Double {
        get {
            return Double(self.layer.cornerRadius)
        }
        set {
            self.layer.cornerRadius = CGFloat(newValue)
        }
    }
    
    // Set borderWidth to view on storyboard
    @IBInspectable var borderWidth: Double {
        get {
            return Double(self.layer.borderWidth)
        }
        set {
            self.layer.borderWidth = CGFloat(newValue)
        }
    }
    
    // Set borderColor to view on storyboard
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
}
