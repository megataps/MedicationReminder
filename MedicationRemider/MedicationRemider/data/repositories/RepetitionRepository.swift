//
//  RepetitionRepository.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/29/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation
import RxSwift

protocol RepetitionRepository {
    
    func createRepetition(_ repetition: Repetition) -> Observable<Bool>
    
    func updateRepetition(_ repetition: Repetition) -> Observable<Bool>
    
    func deleteRepetition(_ repetition: Repetition) -> Observable<Bool>
    
    func deleteRepetition(_ ids: [String]) -> Observable<Bool>
    
    func getAllRepetitions() -> Observable<[Repetition]>
    
    func getRepetitions(limit: Int, offset: Int) -> Observable<[Repetition]>
    
    func getRepetitions(_ medicationId: String) -> Observable<[Repetition]>
}
