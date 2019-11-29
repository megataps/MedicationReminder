//
//  RealmMedication.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/29/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation

class RealmMedication: RealmModel, TransformerDAO {
    
    static let Columns = (
        id: "medicationId",
        name: "name",
        description: "description",
        takeType: "takeType",
        visitDoctorAt: "visitDoctorAt",
        dose: "dose",
        frequency: "frequency",
        createdAt: "createdAt",
        updatedAt: "updatedAt"
    )
    
    @objc dynamic var medicationId: String! = ""
    @objc dynamic var name: String! = ""
    @objc dynamic var medicationDescription: String = ""

    @objc dynamic var takeType: String! = ""
    @objc dynamic var visitDoctorAt: Date = Date().setTime(hour: 0, min: 0, sec: 0)!
    @objc dynamic var dose: Int = 0
    @objc dynamic var frequency: Int = 0

    override static func primaryKey() -> String? {
        return Columns.id
    }
    
    func toModel() -> Medication {
        return RealmMedication.toModel(self)
    }
    
    static func fromModel(_ model: Medication) -> RealmMedication {
        let realmModel = RealmMedication()
        realmModel.medicationId = model.id == "" ? realmModel.newId() : model.id
        realmModel.name = model.name
        realmModel.medicationDescription = model.description
        realmModel.takeType = model.takeType.codeString
        realmModel.visitDoctorAt = model.visitDoctorAt
        realmModel.createdAt = model.createdAt
        realmModel.updatedAt = model.updatedAt
        
        
        return realmModel
    }
    
    static func toModel(_ realmItem: RealmMedication) -> Medication {
                
        let item = Medication(id: realmItem.medicationId,
                              name: realmItem.name,
                              description: realmItem.medicationDescription,
                              takeType: TakeType.init(string: realmItem.takeType)! ,
                              visitDoctorDate: realmItem.visitDoctorAt,
                              dose: realmItem.dose,
                              frequency: realmItem.frequency,
                              createdDate: realmItem.createdAt,
                              updatedDate: realmItem.updatedAt,
                              reminders: [Reminder]())
            
            
        return item
    }
}
