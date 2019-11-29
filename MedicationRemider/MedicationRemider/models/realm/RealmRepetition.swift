//
//  RealmRepetition.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/29/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation
import RealmSwift

class RealmRepetition: RealmModel, TransformerDAO {
    
    static let Columns = (
        repetitionId: "repetitionId",
        status: "status",
        medication: "medication"
    )
    
    @objc dynamic var repetitionId: String! = ""
    @objc dynamic var status: String = ""
    @objc dynamic var medication: RealmMedication?
    
    override static func primaryKey() -> String? {
        return Columns.repetitionId
    }
    
    static func fromModel(_ repetition: Repetition) -> RealmRepetition {
        let realmRepetition = RealmRepetition()
        realmRepetition.repetitionId = repetition.repetitionId == "" ? realmRepetition.newId() : repetition.repetitionId
        realmRepetition.status = repetition.status.codeString
        realmRepetition.createdAt = repetition.createdDate.setTime(hour: 0, min: 0, sec: 0)!
        realmRepetition.medication = RealmMedication.fromModel(repetition.medication)
        
        return realmRepetition
    }
    
    class func toModel(_ d: RealmRepetition) -> Repetition {
        return d.toModel()
    }
    
    func toModel() -> Repetition {
        let repetition = Repetition(repetitionId: repetitionId, createdDate: createdAt, status: MedicationStatus(string: status)!, medication: RealmMedication.toModel(medication!))
        return repetition
    }
}
