//
//  ErrorDecorator.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/29/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation

protocol ErrorDecorator: class {
    func showError(message: String, completed: (() -> ())?)
    func showConfirm(message: String, leftAction: AlertAction, rightAction: AlertAction)
}
