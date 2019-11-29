//
//  TransformerDAO.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/29/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation

protocol TransformerDAO {
    associatedtype Model
    associatedtype Data
    static func fromModel(_ model: Model) -> Data
    static func toModel(_ data: Data) -> Model
    func toModel() -> Model
}

extension TransformerDAO {
    static func toListModels(_ datas: [Data]) -> [Model] {
        var models = [Model]()
        for data in datas {
            models.append(toModel(data))
        }
        
        return models
    }
}
