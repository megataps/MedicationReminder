//
//  ReminderRepository.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/29/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation

import RxSwift

protocol ReminderRepository {
    
    func createReminder(_ reminders: [Reminder]) -> Observable<Bool>
    
    func createReminder(_ reminder: Reminder) -> Observable<Bool>
    
    func updateReminder(_ reminder: Reminder) -> Observable<Bool>
    
    func deleteReminder(_ reminder: Reminder) -> Observable<Bool>
    
    func deleteReminder(_ ids: [String]) -> Observable<Bool>
    
    func getReminders(_ medicationId: String) -> Observable<[Reminder]>
    
    func getAllReminders() -> Observable<[Reminder]>
}
