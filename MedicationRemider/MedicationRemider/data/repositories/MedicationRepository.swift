//
//  MedicationRepository.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/29/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation
import RxSwift

protocol MedicationRepository {
    func createMedication(_ medication: Medication) -> Observable<Medication>
    
    func updateHMedication(_ medication: Medication) -> Observable<Bool>
    
    func deleteMedication(_ medication: Medication) -> Observable<Bool>
    
    func getAllMedications() -> Observable<[Medication]>
    
    func getMedications(date: Date, limit: Int, offset: Int) -> Observable<[Medication]>
    
    func getMedicationDetail(_ medicationId: String) -> Observable<Medication>
}
