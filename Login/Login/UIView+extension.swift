//
//  UIView+extension.swift
//  Login
//
//  Created by 문정호 on 2022/04/01.
//

import UIKit

extension UIView{
    @IBInspectable var conerRadius : CGFloat{
        get{
            return layer.cornerRadius
        }
        set{
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
}
