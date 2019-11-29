//
//  RepetitionRepositoryImpl.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/29/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation
import RxSwift

class RepetitionRepositoryImpl: RealmBaseRepository<Repetition, RealmRepetition>, RepetitionRepository {
    
    let Columns = RealmRepetition.Columns
    
    func createRepetition(_ repetition: Repetition) -> Observable<Bool> {
        return save(repetition)
            .flatMap { repetition -> Observable<Bool> in
                return Observable.just(true)
        }
    }
    
    func updateRepetition(_ repetition: Repetition) -> Observable<Bool> {
        let realmRepetition = RealmRepetition.fromModel(repetition)
        return updatePartially([RealmRepetition.primaryKey()!: realmRepetition.repetitionId as AnyObject,
                                self.Columns.status: realmRepetition.status])
                    .flatMap { repetition -> Observable<Bool> in
                        return Observable.just(true)
                }
    }
    
    func deleteRepetition(_ repetition: Repetition) -> Observable<Bool> {
        return delete(repetition.repetitionId)
            .flatMap { repetition -> Observable<Bool> in
                return Observable.just(true)
        }
    }
    
    func deleteRepetition(_ ids: [String]) -> Observable<Bool> {
        return delete(ids)
            .flatMap { _ -> Observable<Bool> in
                return Observable.just(true)
        }
    }
    
    func getAllRepetitions() -> Observable<[Repetition]> {
        return findAll(sorted: (field: "createdAt", ascending: true))
    }
    
    func getRepetitions(limit: Int, offset: Int) -> Observable<[Repetition]> {
         return findAll(sorted: (field: "createdAt", ascending: true))
    }
    
    func getRepetitions(_ medicationId: String) -> Observable<[Repetition]> {
        return findByKeys([("medication.medicationId", Operator.Equal.rawValue, medicationId as AnyObject)], sorted: (field: "createdAt", ascending: true))
    }
}
