//
//  HomeInteractorImpl.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/29/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation
import RxSwift

class HomeInteractorImpl: HomeInteractor {
    
    private let medicationRepository: MedicationRepository
    private let repetitionRepository: RepetitionRepository
    
    init(medicationRepository: MedicationRepository,
         repetitionRepository: RepetitionRepository) {
        self.medicationRepository = medicationRepository
        self.repetitionRepository = repetitionRepository
    }
    
    func getAllMedications(date: Date, limit: Int, offset: Int) -> Observable<[Medication]> {
        let reps = self.repetitionRepository.getAllRepetitions()
        let medications = self.medicationRepository.getMedications(date: date, limit: limit, offset: offset)
        
        return Observable.combineLatest(reps, medications) { repetitions, medications in
                for med in medications {
                    for rep in repetitions {
                        if med.id == rep.medication.id && rep.createdDate.compareDateOnly(withDate: date) {
                            med.status = rep.status
                            med.repetitions?.append(rep)
                        }
                    }
                }
                return medications
            }
            .flatMap { medications -> Observable<[Medication]> in
                return Observable.just(medications)
            }
    }
        
    func updateStatus(date: Date, _ medication: Medication) -> Observable<Bool> {
        var repetition: Repetition = Repetition(repetitionId: "", createdDate: date, status: medication.status, medication: medication)
        var willUpdate = false
        for rep in medication.repetitions! {
            if(rep.createdDate.compareDateOnly(withDate: date)) {
                rep.status = medication.status
                repetition = rep
                willUpdate = true
                break
            }
        }
        
        // Update Status
        if(willUpdate) {
            return repetitionRepository.updateRepetition(repetition)
        } else {
            // Create a new Repetition
            return repetitionRepository.createRepetition(repetition)
        }
    }
}
