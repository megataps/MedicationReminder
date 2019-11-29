//
//  HomeInteractor.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/29/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation
import RxSwift

protocol HomeInteractor {
    
    func getAllMedications(date: Date, limit: Int, offset: Int) -> Observable<[Medication]>
    
    func updateStatus(date: Date, _ medication: Medication) -> Observable<Bool>
}
