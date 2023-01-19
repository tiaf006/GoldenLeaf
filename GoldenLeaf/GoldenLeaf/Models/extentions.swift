//
//  extentions.swift
//  GoldenLeaf
//
//  Created by TAIF Al-zahrani on 25/06/1444 AH.
//

import Foundation
import UIKit
extension UIImageView {
    
    func Rouned200(){
        self.heightAnchor.constraint(equalToConstant: 200).isActive = true
        self.widthAnchor.constraint(equalToConstant: 200).isActive = true
        self.layer.masksToBounds = false
        self.frame(forAlignmentRect: CGRectMake(0, 0, 200, 200))
        self.contentMode = .scaleAspectFill
        self.layer.cornerRadius = 200.0/2.0
        self.clipsToBounds = true
    }
    func Rouned(){
        self.heightAnchor.constraint(equalToConstant: 150).isActive = true
        self.widthAnchor.constraint(equalToConstant: 150).isActive = true
        self.layer.masksToBounds = false
        self.frame(forAlignmentRect: CGRectMake(0, 0, 150, 150))
        self.contentMode = .scaleAspectFill
        self.layer.cornerRadius = 150.0/2.0
        self.clipsToBounds = true
    }
    func RounedSmall(){
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.layer.masksToBounds = false
        self.frame(forAlignmentRect: CGRectMake(0, 0, 50, 50))
        self.contentMode = .scaleAspectFill
        self.layer.cornerRadius = 50.0/2.0
        self.clipsToBounds = true
    }    }

