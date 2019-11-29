//
//  AlertAction.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/27/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation

struct AlertAction {
    var title: String
    var handler: (() -> Void)
    init(title: String, handler: @escaping (() -> Void)) {
        self.title = title
        self.handler = handler
    }
}
