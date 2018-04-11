//
//  CardButton.swift
//  memorygame
//
//  Created by Sara Lundberg on 4/3/18.
//  Copyright © 2018 Sara Lundberg. All rights reserved.
//

import UIKit
import CoreGraphics

@IBDesignable
class CardButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}


