//
//  UIViewEx.swift
//  GoldenLeaf
//
//  Created by elham on 1/18/23.
//

import UIKit


extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return cornerRadius }
        set {
            self.layer.cornerRadius = newValue
            
        }
    }
    }
