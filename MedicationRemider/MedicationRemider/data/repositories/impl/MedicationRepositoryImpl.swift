//
//  MedicationRepositoryImpl.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/29/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation
import RxSwift

class MedicationRepositoryImpl: RealmBaseRepository<Medication, RealmMedication>, MedicationRepository {
    
    let Columns = RealmMedication.Columns
    
    func createMedication(_ medication: Medication) -> Observable<Medication> {
        return save(medication)
    }
    
    func updateHMedication(_ medication: Medication) -> Observable<Bool> {
        return save(medication)
            .flatMap { habit -> Observable<Bool> in
                return Observable.just(true)
        }
    }
    
    func deleteMedication(_ medication: Medication) -> Observable<Bool> {
        return delete(medication.id)
            .flatMap { habit -> Observable<Bool> in
                return Observable.just(true)
        }
    }
    
    func getAllMedications() -> Observable<[Medication]> {
        return findAll(sorted: (field: "name", ascending: true))
    }
    
    func getMedications(date: Date, limit: Int, offset: Int) -> Observable<[Medication]> {
        let selectDate = date.setTime(hour: 0, min: 0, sec: 0)
        return findByKeys([(Columns.createdAt, Operator.LessThanOrEqual.rawValue, selectDate as AnyObject)], sorted: (field: "name", ascending: false))
    }
    
    func getMedicationDetail(_ medicationId: String) -> Observable<Medication> {
        return findById(medicationId)
    }
}
