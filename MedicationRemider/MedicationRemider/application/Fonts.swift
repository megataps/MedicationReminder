//
//  Fonts.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/27/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation
import UIKit

struct Fonts {
    
    enum Primary: String {
        case Bold = "Amiko-Bold"
        case SemiBold = "Amiko-SemiBold"
        case Regular = "Amiko-Regular"

        
        func toFontWith(size: Double) -> UIFont? {
            return UIFont(name: self.rawValue, size: CGFloat(size))
        }
        
        var fontName: String {
            return rawValue
        }
    }
    
    enum Secondary: String {
        case Regular = "Amiko-Regular"
        case Light = "Amiko-SemiBold"
        
        func toFontWith(size: Double) -> UIFont? {
            return UIFont(name: self.rawValue, size: CGFloat(size))
        }
        
        var fontName: String {
            return rawValue
        }
    }
}
