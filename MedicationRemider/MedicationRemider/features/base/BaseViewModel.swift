//
//  BaseViewModel.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/29/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation
import RxSwift

class BaseViewModel {
    var disposeBag = DisposeBag()
    weak var errorDecorator: ErrorDecorator?
    
    var onWillStartLoading = PublishSubject<Void>()
    var onWillStopLoading = PublishSubject<Void>()
    
    init() {
        setUpRx()
    }
    
    func setUpRx() { }
    
    func startInViewWillAppear() {}
    
    func startInViewDidLoad() {}
    
    func startInViewDidAppear() {}
    
    func showError(error: Error, completed: (() -> ())? = nil) {
        errorDecorator?.showError(message: errorMessageFrom(type: error), completed: completed)
    }
    
    func showError(errorMessage: String, completed: (() -> ())? = nil) {
        errorDecorator?.showError(message: errorMessage, completed: completed)
    }
    
    func showConfirm(message: String, leftAction: AlertAction, rightAction: AlertAction) {
        errorDecorator?.showConfirm(message: message, leftAction: leftAction, rightAction: rightAction)
    }
}

private extension BaseViewModel {
    func errorMessageFrom(type errorType: Error) -> String {
           let message = ""
           return message
       }
}
