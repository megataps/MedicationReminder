//
//  BaseViewController.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/26/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class BaseViewController: UIViewController, BaseMessageAlert, ErrorDecorator {
    
    var disposeBag = DisposeBag()
    var onDisappearDisposables = [Disposable]()
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        disposeOnDisappear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func disposeOnDisappear() {
        onDisappearDisposables.forEach { (disposable) in
            disposable.dispose()
        }
    }
}
