//
//  HomeViewModel.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/28/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel: BaseViewModel {
    
    private var interactor: HomeInteractor
    private var medications = [Medication]()
    private var selectedDate: Date = Date()
    private var loadMedicationsOnDemand = PublishSubject<Void>()
    private var onUpdateMedicationOnDemand = PublishSubject<Medication>()
    
    var onDidLoadMedications: Observable<Void>!
    var onUpdateMedication: Observable<Void>!
    
    init(interactor: HomeInteractor) {
        self.interactor = interactor
        super.init()
    }

    override func setUpRx() {
        onDidLoadMedications = loadMedicationsOnDemand
            .do(onNext: { [unowned self] _ in
                self.onWillStartLoading.onNext(())
            })
    //            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .flatMap { [unowned self] _ in
                return self.interactor.getAllMedications(date: self.selectedDate, limit: 20, offset: 0)
            }
            .do(onNext: { [unowned self] medications in
                self.medications = medications.sorted {
                    if $0.status == $1.status {
                        return $0.name < $1.name
                    } else {
                        return $0.status != MedicationStatus.Done &&  $1.status == MedicationStatus.Done
                    }
                }
            })
    //            .observeOn(MainScheduler.instance)
            .do(onNext: {[unowned self] success in
                self.onWillStopLoading.onNext(())
            })
            .map { _ in Void() }
        
        onUpdateMedication = onUpdateMedicationOnDemand
            .do(onNext: {[unowned self] _ in
                self.onWillStartLoading.onNext(())
            })
    //            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .flatMap {[unowned self] habit in
                return self.interactor
                    .updateStatus(date: self.selectedDate, habit)
                    .catchError { [unowned self] error -> Observable<Bool> in
                        self.showError(error: error)
                        return Observable.empty()
                }
            }
    //            .observeOn(MainScheduler.instance)
            .do(onNext: {[unowned self] success in
                self.onWillStopLoading.onNext(())
            })
            .map { _ in Void() }
    }
    
    func startLoadMedications(_ date: Date) {
        self.selectedDate = date
        loadMedicationsOnDemand.onNext(())
    }
    
    func totalMedications() -> Int {
        return self.medications.count
    }
    
    func medicationAtIndex(_ index: Int) -> Medication? {
        guard index < self.medications.count else { return nil }
        return self.medications[index]
    }
    
    func updateMedicationStatus(status: MedicationStatus, index: Int) {
        let medication: Medication = self.medicationAtIndex(index)!
        medication.status = status
        onUpdateMedicationOnDemand.onNext(medication)

        // Update data to display on UI
        self.medications = medications.sorted {
            if $0.status == $1.status {
                return $0.name < $1.name
            } else {
                return $0.status != MedicationStatus.Done &&  $1.status == MedicationStatus.Done
            }
        }
    }
}
