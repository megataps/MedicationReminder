//
//  AddMedicationInteractor.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/29/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation
import RxSwift

protocol AddMedicationInteractor {
    
    func addMedication(medication: Medication) -> Observable<Medication>
}
