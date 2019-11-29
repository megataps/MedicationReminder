//
//  RealmBaseRepository.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/29/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

class RealmBaseRepository<Model, DataModel> where DataModel: TransformerDAO, DataModel: Object,
DataModel.Model == Model, DataModel.Data == DataModel {
    
    let realmFactory: RealmFactory
    
    init(realmFactory: RealmFactory) {
        self.realmFactory = realmFactory
    }
    
    func getRealm() throws -> Realm {
        return try realmFactory.getRealm()
    }
    
    func write(_ innerWrite: (Realm) -> ()) throws {
        let realm = try getRealm()
        try realm.write {
            innerWrite(realm)
        }
    }
    
    func createObservable<T>(_ f: @escaping () throws -> T) -> Observable<T> {
        return Observable.create {
            observer in
            do {
                observer.on(Event.next(try f()))
                observer.on(Event.completed)
            } catch DataError.notFound {
                observer.on(Event.error(DataError.notFound))
            } catch {
                observer.on(Event.error(error))
            }
            
            return Disposables.create {}
            }.share(replay: 1)
    }
    
    func saveAll(_ models: [Model]) -> Observable<[Model]> {
        return createObservable {
            var dataModels = [DataModel]()
            try self.write { realm in
                for model in models {
                    let dataModel = DataModel.fromModel(model)
                    realm.add(dataModel, update: .all)
                    dataModels.append(dataModel)
                }
            }
            return DataModel.toListModels(dataModels)
        }
    }
    
    func save(_ model: Model) -> Observable<Model> {
        return createObservable {
            let data = DataModel.fromModel(model)
            
            try self.write { (realm: Realm) in
                realm.add(data, update: .all)
            }
            
            return data.toModel()
        }
    }
    
    func updatePartially(_ value: [String: Any]) -> Observable<Model> {
        return createObservable {
            var dataModel: DataModel!
            try self.write { (realm: Realm) in
                dataModel = realm.create(DataModel.self, value: value, update: .all)
            }
            
            return dataModel.toModel()
        }
    }
    
    func delete(_ id: String) -> Observable<Void> {
        return createObservable {
            if let data: DataModel = try! self.findById(id) {
                try self.write {
                    realm in
                    realm.delete(data)
                }
            }
            return
        }
    }
    
    func delete(_ ids: [String]) -> Observable<Void> {
        if ids.isEmpty {
            return Observable.just(())
        }
        return createObservable {
            let result: Results<DataModel> = try self.realmFactory.getQuery().filter("\(DataModel.primaryKey()!) IN %@", ids)
            try self.write { realm in
                for data in result {
                    realm.delete(data)
                }
            }
            
            return
        }
    }
    
    func deleteAll() -> Observable<Void> {
        return createObservable {
            let realm = try self.getRealm()
            let objects = realm.objects(DataModel.self)
            try self.write { realm in
                realm.delete(objects)
            }
        }
    }
    
    func findAll(sorted: (field: String, ascending: Bool)? = nil) -> Observable<[Model]> {
        return createObservable {
            let result: Results<DataModel> = try self.buildQuery([], sorted: sorted)
            let models: [Model] = result.map { $0.toModel() }
            return models
        }
    }
    
    func findByKeys(_ keys: [(String, String, Any)], pagination: Pagination? = nil,
                    sorted: (field: String, ascending: Bool)? = nil) -> [Model] {
        do {
            let result: Results<DataModel> = try self.buildQuery(keys, sorted: sorted)
            
            let limit = pagination?.limit ?? result.count
            let page = pagination?.page ?? 1
            
            let startIndex = max((page - 1) * limit, result.startIndex)
            let endIndex = min(startIndex + limit, result.endIndex)
            
            var models = [Model]()
            if endIndex == 0 || startIndex > endIndex {
                return models
            }
            
            for index in startIndex ..< endIndex {
                models.append(result[index].toModel())
            }
            
            return models
        } catch {
            return []
        }
    }
    
    func findByKeys(_ keys: [(String, String, Any)], pagination: Pagination? = nil,
                    sorted: (field: String, ascending: Bool)? = nil) -> Observable<[Model]> {
        return createObservable {
            let result: Results<DataModel> = try self.buildQuery(keys, sorted: sorted)
            
            let limit = pagination?.limit ?? result.count
            let page = pagination?.page ?? 1
            
            let startIndex = max((page - 1) * limit, result.startIndex)
            let endIndex = min(startIndex + limit, result.endIndex)
            
            var models = [Model]()
            if endIndex == 0 || startIndex > endIndex {
                return models
            }
            
            for index in startIndex ..< endIndex {
                models.append(result[index].toModel())
            }
            
            return models
        }
    }
    
    func findById(_ id: String) -> Model? {
        return findFirstByKeys([(DataModel.primaryKey()!, "==", id as Any)])
    }
    
    func findById(_ id: String) throws -> DataModel? {
        return try findFirstByKeys([(DataModel.primaryKey()!, "==", id as Any)])
    }
    
    func findById(_ id: String) -> Observable<Model> {
        return findFirstByKeys([(DataModel.primaryKey()!, "==", id as Any)])
    }
    
    func findFirstByKeys(_ keys: [(String, String, Any)], sorted: (field: String, ascending: Bool)? = nil) -> Model? {
        do {
            return try findFirstByKeys(keys, sorted: sorted)?.toModel()
        } catch {
            return nil
        }
    }
    
    func findFirstByKeys(_ keys: [(String, String, Any)], sorted: (field: String, ascending: Bool)? = nil) throws -> DataModel? {
        let result: DataModel? = try self.buildQuery(keys, sorted: sorted).first
        return result
    }
    
    func findFirstByKeys(_ keys: [(String, String, Any)], sorted: (field: String, ascending: Bool)? = nil) -> Observable<Model> {
        return createObservable {
            let result: Model? = self.findFirstByKeys(keys, sorted: sorted)
            if let result = result {
                return result
            } else {
                throw DataError.notFound
            }
        }
    }
    
    fileprivate func buildQuery(_ keys: [(String, String, Any)],
                                sorted: (field: String, ascending: Bool)? = nil) throws -> Results<DataModel> {
        var result: Results<DataModel> = try realmFactory.getQuery()
        
        for (key, op, val) in keys {
            // !Important: this may be cause low performance.
            result = result.filter("\(key) \(op) %@", val)
        }
        
        if let (field, ascending) = sorted {
            result = result.sorted(byKeyPath: field, ascending: ascending)
        }
        
        return result
    }
}
