//
//  class Components.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/27/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation

class Components {
    
    /* Begin Public */
    
    static let instance = Components()
    
    
    //----------------------------------------------------------------------------------------------
    /* Begin Common */
    
    private lazy var realmFactory: RealmFactory = {
        return RealmFactoryImpl()
    }()
    
    //----------------------------------------------------------------------------------------------
    /* Begin Interactor */
    
    static func homeInteractor() -> HomeInteractor {
        return HomeInteractorImpl(medicationRepository: Components.medicationRepository,
                                  repetitionRepository: Components.repetitionRepository)
    }
    
    static func addMedicationInteractor() -> AddMedicationInteractor {
        return AddMedicationInteractorImpl(medicationRepository: Components.medicationRepository,
                                         repetitionRepository: Components.repetitionRepository,
                                         reminderRepository: Components.reminderRepository
        )
    }
    
    //----------------------------------------------------------------------------------------------
    /* Begin Services */
    

    
    //----------------------------------------------------------------------------------------------
    /* Begin Repository */
    
    static var appSettingRepository: AppSettingRepository = {
        return AppSettingRepositoryImpl(userDefaults: UserDefaults.standard)
    }()
    
    static var medicationRepository: MedicationRepository = {
        return MedicationRepositoryImpl(realmFactory: instance.realmFactory)
    }()
    
    static var repetitionRepository: RepetitionRepository = {
        return RepetitionRepositoryImpl(realmFactory: instance.realmFactory)
    }()
    
    static var reminderRepository: ReminderRepository = {
        return ReminderRepositoryImpl(realmFactory: instance.realmFactory)
    }()
}
