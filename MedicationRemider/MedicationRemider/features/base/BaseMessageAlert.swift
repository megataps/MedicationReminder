//
//  BaseMessageAlert.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/26/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation
import UIKit

protocol BaseMessageAlert {
    func onErrorHandle(error: Error)
    func showError(message: String, completed: (() -> ())?)
    func showConfirm(message: String, leftAction: AlertAction, rightAction: AlertAction)
    func showMessage(message: String)
    func alert(title: String?, message: String?, completed: (() -> Void)?)
    func showAlertWith(message: String)
    func showLoadingIndicator(_ status: String)
    func showLoading(status: String)
    func hideLoading()
}

extension BaseMessageAlert where Self: UIViewController {
    func onErrorHandle(error: Error) {
        let message = error.localizedDescription
        self.showMessage(message: message)
    }
    
    func showError(message: String, completed: (() -> ())?) {
        if KRProgressHUD.isVisible {
            KRProgressHUD.dismiss({ [unowned self] in
                if !message.isEmpty {
                    self.alert(title: message, message: nil, completed: completed)
                }
            })
        } else {
            if !message.isEmpty {
                alert(title: message, message: nil, completed: completed)
            }
        }
    }
    
    func showConfirm(message: String, leftAction: AlertAction, rightAction: AlertAction) {
        
    }
    
    func showMessage(message: String) {
        if KRProgressHUD.isVisible {
            KRProgressHUD.dismiss({ [unowned self] in
                self.showAlertWith(message: message)
            })
        } else {
            showAlertWith(message: message)
        }
    }
    
    func alert(title: String?, message: String?, completed: (() -> Void)?) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: Strings.CommonOk.localize(), style: UIAlertAction.Style.default, handler: { _ in
            if let _completed = completed {
                _completed()
            }
       }))

       self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWith(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: Strings.CommonOk.localize(), style: UIAlertAction.Style.default, handler: { _ in
            //Cancel Action
        }))

        self.present(alert, animated: true, completion: nil)
    }
    
    func showLoadingIndicator(_ status: String) {
        KRProgressHUD.set(maskType: KRProgressHUDMaskType.black)
        
        if status.isEmpty {
            KRProgressHUD.show()
        } else {
            KRProgressHUD.show(message: status)
        }
    }
    func showLoading(status: String) {
        if KRProgressHUD.isVisible {
            KRProgressHUD.dismiss({ [unowned self] in
                self.showLoadingIndicator(status)
            })
        } else {
            self.showLoadingIndicator(status)
        }
    }
    
    func hideLoading() {
        KRProgressHUD.dismiss()
    }
}
