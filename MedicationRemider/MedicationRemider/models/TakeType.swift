//
//  TakeType.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/29/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation

enum TakeType {
    case BeforeMeal
    case AfterMeal
}

extension TakeType {
    
    init?(string: String) {
        switch string.lowercased() {
        case "before": self = .BeforeMeal
        case "after": self = .AfterMeal
        default: return nil
        }
    }
    
    var codeString: String {
        switch self {
        case .BeforeMeal: return "before"
        case .AfterMeal: return "after"
        }
    }
    
    var string: String {
        switch self {
        case .BeforeMeal: return Strings.MedicationTypeBeforeMeal.localize()
        case .AfterMeal: return Strings.MedicationTypeAfterMeal.localize()
        }
    }
}
