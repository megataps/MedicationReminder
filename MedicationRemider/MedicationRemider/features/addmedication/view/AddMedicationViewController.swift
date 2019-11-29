//
//  AddMedicationViewController.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/29/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation
import UIKit
import SwiftMessages

protocol AddMedicationViewDelegate: class {
    func didAddMedication()
}

class AddMedicationViewController: BaseViewController {

    fileprivate let viewModel = AddMedicationViewModel(interactor: Components.addMedicationInteractor())
    
    weak var delegate: AddMedicationViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindEvents();
    }
    
    private func bindEvents() {
        self.disposeBag.addDisposables([
            viewModel.onDidSave.subscribe(
                onNext: { [unowned self] _ in
                    self.delegate?.didAddMedication()
                    self.navigationController?.popViewController(animated: true)
                },
                onError: { [unowned self] error in
                    if let err = error as? DataError {
                        self.showMessage(message: err.localizedDescription)
                    }
            }),
            viewModel.onWillStartLoading.subscribe(onNext: { [unowned self] in
                self.showLoading(status: Strings.CommonLoading.localize())
            }),
            viewModel.onWillStopLoading.subscribe(onNext: { [unowned self] in
                self.hideLoading()
            })
        ])
    }
    
    private func addMedication() {
        // Init data before save
        let mediacation = Medication()
        
        
        viewModel.startSave(medication: mediacation)
    }
}
