//
//  Strings.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/27/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation

enum Strings: String {

    case AppName = "Medication Reminder"

    /*============= COMMON STRINGS =============== */
    case CommonName       = "Name"
    case CommonOk         = "Ok"
    case CommonCancel     = "Cancel"
    case CommonSave       = "Save"
    case CommonToday      = "common.today"
    case CommonTomorrow   = "common.tomorrow"
    case CommonSearch     = "common.search"
    case CommonLoading    = "common.loading"
    
    /*============= ONBOARDING SCREEN STRINGS =============== */
    case OnBoardingFirstScreenTitle         = "onboarding.first_screen.title"
    case OnBoardingFirstScreenDescription   = "onboarding.first_screen.description"
    
    case OnBoardingSecondScreenTitle        = "onboarding.second_screen.title"
    case OnBoardingSecondScreenDescription  = "onboarding.second_screen.description"
    
    case OnBoardingThirdScreenTitle         = "onboarding.third_screen.title"
    case OnBoardingThirdScreenDescription   = "onboarding.third_screen.description"
    
    
    
    /*============= ADD MEDICATION SCREEN STRINGS =============== */
    case MedicationStatusNew = "medication.status.new"
    case MedicationStatusDone = "medication.status.done"
    case MedicationStatusOverdue = "medication.status.overdue"
    
    case MedicationTypeBeforeMeal = "add_medication.take_type.before"
    case MedicationTypeAfterMeal = "add_medication.take_type.after"
    
    func localize() -> String {
        return self.rawValue.localized()
    }
}
