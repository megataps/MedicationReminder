//
//  AppSettingRepositoryImpl.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/27/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation

class AppSettingRepositoryImpl: AppSettingRepository {
 
    private var userDefaults: UserDefaults
    
    private let KIsShowedOnboardingKey = "key.user_defaults.is_showed_onboarding"
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    func setShowOnBoarding(isShowed: Bool) {
        userDefaults.set(isShowed, forKey: KIsShowedOnboardingKey)
        userDefaults.synchronize()
    }
    
    func isShowedOnBoarding() -> Bool {
        return userDefaults.bool(forKey: KIsShowedOnboardingKey)
    }
}
