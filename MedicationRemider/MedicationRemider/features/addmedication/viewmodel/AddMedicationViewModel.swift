//
//  AddMedicationViewModel.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/29/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation
import RxSwift

class AddMedicationViewModel: BaseViewModel {
    
    private var interactor: AddMedicationInteractor
    private var saveOnDemand = PublishSubject<Void>()
    private var medication: Medication
    
    var onDidSave: Observable<Void>!
    
    init(interactor: AddMedicationInteractor) {
        self.interactor = interactor
        self.medication = Medication()
        super.init()
    }
    
    override func setUpRx() {
        onDidSave = saveOnDemand
            .do(onNext: { [unowned self] in
                self.onWillStartLoading.onNext(())
            })
            .flatMap { [unowned self] in
                return self.interactor.addMedication(medication: self.medication)
            }
            .do(onNext: { [unowned self] med in
                med.reminders? = self.medication.reminders!
                NotificationScheduleManager.createNotification(med)
                self.onWillStopLoading.onNext(())
            })
            .map { _ in Void() }
    }
    
    func startSave(medication: Medication) {
        self.medication = medication
        saveOnDemand.onNext(())
    }
}
