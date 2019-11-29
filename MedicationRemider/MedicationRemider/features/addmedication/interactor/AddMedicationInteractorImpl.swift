//
//  AddMedicationInteractorImpl.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/29/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation
import RxSwift

class AddMedicationInteractorImpl: AddMedicationInteractor {
    
    private let medicationRepository: MedicationRepository
    private let repetitionRepository: RepetitionRepository
    private let reminderRepository: ReminderRepository
    
    init(medicationRepository: MedicationRepository,
         repetitionRepository: RepetitionRepository,
         reminderRepository: ReminderRepository) {
        
        self.medicationRepository = medicationRepository
        self.repetitionRepository = repetitionRepository
        self.reminderRepository = reminderRepository
    }
    
    func addMedication(medication: Medication) -> Observable<Medication> {
        return medicationRepository.createMedication(medication)
        .flatMap{ [unowned self ] result -> Observable<Medication> in
            let repetition: Repetition = Repetition(repetitionId: "", createdDate: Date(), status: medication.status, medication: result)
           
            let activeReminders = medication.reminders?.filter{$0.isTurnOn == true}
            var remidners = [Reminder]()
            if activeReminders?.count ?? 0 > 0 {
                for remi in activeReminders! {
                    remi.medication = result
                    remidners.append(remi)
                }
            }
            
            return self.repetitionRepository.createRepetition(repetition)
                .flatMap { repetition -> Observable<Medication> in
                    return self.reminderRepository.createReminder(remidners)
                        .flatMap { remis -> Observable<Medication> in
                            return Observable.just(result)
                        }
                    }
        }
    }
}
