//
//  HomeViewController.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/28/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: BaseViewController {
    
    static let identifier = "HomeViewController"
    
    static func newInstance() -> HomeViewController {
        let shopStoryboard = UIStoryboard(name:"Main", bundle: Bundle.main)
        let controller = shopStoryboard.instantiateViewController(withIdentifier: HomeViewController.identifier) as! HomeViewController
        return controller
    }
    
    fileprivate let viewModel = HomeViewModel(interactor: Components.homeInteractor())
    
     override func viewDidLoad() {
        super.viewDidLoad()

        self.bindEvents()
    }
    
    private func bindEvents() {
        self.disposeBag.addDisposables([
            viewModel.onDidLoadMedications.subscribe(
                onNext: { [unowned self] _ in
                   // Update UI Logic here
                },
                onError: { [unowned self] error in
                    if let err = error as? DataError {
                        self.showMessage(message: err.localizedDescription)
                    }
                    
                    // Do more action if needed
            }),
            
            viewModel.onWillStartLoading.subscribe(onNext: { [unowned self] in
                self.showLoading(status: "")
            }),
            
            viewModel.onWillStopLoading.subscribe(onNext: { [unowned self] in
                self.hideLoading()
            }),
            
            viewModel.onUpdateMedication.subscribe(
                onNext: { [unowned self] _ in
                   // Update UI Logic here
                },
                onError: { [unowned self] error in
                    if let err = error as? DataError {
                        self.showMessage(message: err.localizedDescription)
                    }
                
                    // Do more action if needed
            }),
        ])
    }
    
    func startLoadData(_ date: Date) {
        self.viewModel.startLoadMedications(date)
    }
    
    func updateMedicationStatus(status: MedicationStatus, index: Int) {
        self.viewModel.updateMedicationStatus(status: status, index: index)
    }
}
