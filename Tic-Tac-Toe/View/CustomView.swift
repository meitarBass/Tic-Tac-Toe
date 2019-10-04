//
//  CustomView.swift
//  Tic-Tac-Toe
//
//  Created by Meitar Basson on 01/10/2019.
//  Copyright © 2019 Meitar Basson. All rights reserved.
//

import UIKit

class CustomView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 6.0 {
        didSet {
            layer.cornerRadius = self.cornerRadius
        }
    }
    
    @IBInspectable var hasShadow: Bool = false {
        didSet {
            layer.shadowPath =
                UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
            layer.shadowColor = #colorLiteral(red: 0.9607843137, green: 0.6509803922, blue: 0.137254902, alpha: 1)
            layer.shadowOpacity = 0.9
            layer.shadowOffset = CGSize(width: 0, height: 0)
            layer.shadowRadius = 5.0
            layer.masksToBounds = false
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        clipsToBounds = true
        // layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
    }
    
}
