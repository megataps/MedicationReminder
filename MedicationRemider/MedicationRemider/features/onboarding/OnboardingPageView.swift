//
//  OnboardingPageView.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/27/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import UIKit

class OnboardingPageView: UIView {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "OnboardingPageView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
}
