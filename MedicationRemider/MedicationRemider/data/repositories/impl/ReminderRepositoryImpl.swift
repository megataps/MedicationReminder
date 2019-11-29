//
//  ReminderRepositoryImpl.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/29/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation
import RxSwift

class ReminderRepositoryImpl: RealmBaseRepository<Reminder, RealmReminder>, ReminderRepository {
    
    let Columns = RealmReminder.Columns
    
    func createReminder(_ reminders: [Reminder]) -> Observable<Bool> {
        return saveAll(reminders)
            .flatMap { reminders -> Observable<Bool> in
                return Observable.just(true)
        }
    }
    
    func createReminder(_ reminder: Reminder) -> Observable<Bool> {
        return save(reminder)
            .flatMap { reminder -> Observable<Bool> in
                return Observable.just(true)
        }
    }
    
    func updateReminder(_ reminder: Reminder) -> Observable<Bool> {
        let realmReminder = RealmReminder.fromModel(reminder)
        return updatePartially([RealmReminder.primaryKey()!: realmReminder.reminderId as AnyObject,
                                self.Columns.isTurnOn: realmReminder.isTurnOn])
            .flatMap { repetition -> Observable<Bool> in
                return Observable.just(true)
        }
    }
    
    func deleteReminder(_ reminder: Reminder) -> Observable<Bool> {
        return delete(reminder.reminderId)
            .flatMap { reminder -> Observable<Bool> in
                return Observable.just(true)
        }
    }
    
    func deleteReminder(_ ids: [String]) -> Observable<Bool> {
        return delete(ids)
            .flatMap { _ -> Observable<Bool> in
                return Observable.just(true)
        }
    }
    
    func getReminders(_ medicationId: String) -> Observable<[Reminder]> {
        return findByKeys([("medication.medicationId", Operator.Equal.rawValue, medicationId as AnyObject)], sorted: (field: "createdAt", ascending: true))
    }
    
    func getAllReminders() -> Observable<[Reminder]> {
        return findAll(sorted: (field: "createdAt", ascending: true))
    }
}
