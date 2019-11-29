//
//  Localizable+Extension.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/27/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation
import UIKit

extension UILabel: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            text = key?.localized()
        }
    }
}

extension UIButton: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            setTitle(key?.localized(), for: .normal)
        }
    }
}

extension UIBarButtonItem: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            title = key?.localized()
        }
    }
}

extension UINavigationItem: XIBLocalizable {
    
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            title = key?.localized()
        }
    }
}
