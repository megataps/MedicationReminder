//
//  Segues.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/27/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation

struct Segues {
    
    struct SplashScreen {
        static let ToHome = "segue.splash.to_home"
        static let ToOnBoarding = "segue.splash.to_onboarding"
    }

    struct OnBoarding {
        static let ToHome = "segue.onboarding.to_home"
    }

    struct Home {
        static let ToAddMedication = "segue.home.to_add_medication"
        static let ToSymptom = "segue.home.to_symptom"
        static let ToSummary = "segue.home.to_summary"
    }
}
