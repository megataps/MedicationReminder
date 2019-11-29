//
//  Colors.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/27/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation

import UIKit

enum Colors: Int {
    
    case White = 0xFFFFFF
    case Green = 0x64EF04
    case Dark = 0x656465
    case DarkBorder = 0x403F3F
    case Black = 0x202020
    case BlackTwo = 0x2a2928
    case BlackBackGround = 0x0B0B0B
    case Bunting = 0x273142
    case LightBlack = 0x2C2C2C
    case Gray = 0x909094
    case LightGray = 0xDADADA
    case Orange = 0xF5A623
    case LightOrange = 0xf3a536
    case LightRed = 0xda2536
    case Blue = 0x2297e8
    case Silver = 0xd0d6da
    case CoolGrey = 0x939596
    case Topaz = 0x0DAAA5
    case TextColor = 0x1A4D87
        
    func color(alpha: CGFloat = 1) -> UIColor {
        return UIColor(netHex: self.rawValue, alpha: alpha)
    }
}
