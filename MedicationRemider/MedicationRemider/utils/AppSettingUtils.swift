//
//  AppSettingUtils.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/27/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation

class AppSettingUtils {

    static func setShowOnBoarding(isShowed: Bool) {
        Components.appSettingRepository.setShowOnBoarding(isShowed: isShowed)
    }
    
    static func isShowedOnBoarding() -> Bool {
        return Components.appSettingRepository.isShowedOnBoarding()
    }
}
