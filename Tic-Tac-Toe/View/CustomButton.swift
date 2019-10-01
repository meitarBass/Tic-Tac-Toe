//
//  CustomButton.swift
//  Tic-Tac-Toe
//
//  Created by Meitar Basson on 01/10/2019.
//  Copyright © 2019 Meitar Basson. All rights reserved.
//

import UIKit


class CustomButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 6.0 {
        didSet {
            layer.cornerRadius = self.cornerRadius
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    
    }

}
