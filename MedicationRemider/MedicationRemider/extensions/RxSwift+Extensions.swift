//
//  RxSwift+Extensions.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/26/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

func createObservable<T>(f: @escaping () -> T) -> Observable<T> {
    return Observable.create { observer in
        observer.on(Event.next(f()))
        observer.on(Event.completed)
        
        return Disposables.create {}
        }.share(replay: 1)
}

extension ObservableType {
    public func delayStream(_ time: TimeInterval, scheduler: SchedulerType = MainScheduler.instance) -> Observable<E> {
        return self.flatMap { element in
            Observable<Int>.timer(time, scheduler: scheduler)
                .map { _ in
                    return element
            }
        }
    }
}

extension Observable {
    class func error(error: Error) -> Observable<Element> {
        return Observable.create { observer in
            observer.onError(error)
            
            return Disposables.create {}
            }.share(replay: 1)
    }
}

extension DisposeBag {
    func addDisposables(_ array: [Disposable]) {
        for item in array {
            self.insert(item)
        }
    }
}

// MARK: operator ~>
infix operator ~>

func ~> <T>(property: ControlProperty<T?>, variable: BehaviorRelay<T>) -> Disposable {
    return property.subscribe(onNext: { value in
        variable.accept(value!)
    })
}

func ~> <T>(variable: Observable<T>, property: AnyObserver<T>) -> Disposable {
    return variable.bind(to: property)
}
