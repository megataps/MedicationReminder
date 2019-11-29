//
//  AppSettingRepository.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/27/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation


protocol AppSettingRepository {
    
    func setShowOnBoarding(isShowed: Bool)
    
    func isShowedOnBoarding() -> Bool
    
}
