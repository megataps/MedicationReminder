//
//  SplashScreenViewController.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/28/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {

    static let identifier = "SplashScreenViewController"
    
    static func newInstance() -> SplashScreenViewController {
        let shopStoryboard = UIStoryboard(name:"Main", bundle: Bundle.main)
        let controller = shopStoryboard.instantiateViewController(withIdentifier: SplashScreenViewController.identifier) as! SplashScreenViewController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if AppSettingUtils.isShowedOnBoarding() {
            gotoHomeScreen()
        } else {
            gotoOnBoarding()
        }
    }
    
    func gotoOnBoarding() {
        performSegue(withIdentifier: Segues.SplashScreen.ToOnBoarding, sender: nil)
    }
    
    func gotoHomeScreen() {
        performSegue(withIdentifier: Segues.SplashScreen.ToHome, sender: nil)
    }
}
