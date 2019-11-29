//
//  OnBoardingViewController.swift
//  MedicationRemider
//
//  Created by tinh.nguyen on 11/26/19.
//  Copyright © 2019 Tinh Nguyen. All rights reserved.
//

import Foundation
import UIKit

struct OnBoarding {
    let image: String
    let title: String
    let description: String
}

// Image source from: https://www.sketchappsources.com/resource/download-1613.html

class OnBoardingViewController: BaseViewController {
    
    static let identifier = "OnBoardingViewController"
    
    static func newInstance() -> OnBoardingViewController {
        let megaShopStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller = megaShopStoryboard.instantiateViewController(withIdentifier: OnBoardingViewController.identifier) as! OnBoardingViewController
        return controller
    }
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    var currentPage: Int!
    var listItems : [OnBoarding] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        initData()
        
        skipButton.setTitleColor(Colors.TextColor.color(), for: .normal)
        doneButton.setTitleColor(Colors.White.color(), for: .normal)
        
        skipButton.isHidden = false
        doneButton.isHidden = true
        
        // Config scrollview
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(listItems.count), height: view.frame.height)
        
        scrollView.contentSize = CGSize(width: scrollView.frame.width * CGFloat(listItems.count), height: scrollView.frame.height)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        currentPage = 0
        
        bindDataToScrollView()
    
        // Increase size uipagecontrol
        pageControl.transform = CGAffineTransform.init(scaleX: 1.4, y: 1.4)
        pageControl.currentPageIndicatorTintColor = Colors.Green.color()
        pageControl.pageIndicatorTintColor = Colors.Gray.color()
        pageControl.tintColor = Colors.White.color()
        
        pageControl.numberOfPages = listItems.count
    }
    
    func initData() {
        let firstOnBoardingScreen = OnBoarding(image: "onboarding_1",
                                               title: Strings.OnBoardingFirstScreenTitle.localize(),
                                               description: Strings.OnBoardingFirstScreenDescription.localize())
        
        let secondOnBoardingScreen = OnBoarding(image: "onboarding_2",
                                                title: Strings.OnBoardingSecondScreenTitle.localize(),
                                                description: Strings.OnBoardingSecondScreenDescription.localize())
        
        let thirdOnBoardingScreen = OnBoarding(image: "onboarding_3",
                                               title: Strings.OnBoardingThirdScreenTitle.localize(),
                                               description: Strings.OnBoardingThirdScreenDescription.localize())
        
        listItems.append(firstOnBoardingScreen)
        listItems.append(secondOnBoardingScreen)
        listItems.append(thirdOnBoardingScreen)
    }
        
    func bindDataToScrollView() {
        for index in 0..<listItems.count {
            let item = listItems[index]
            var offset = view.frame.width * CGFloat(index)
            
            let view = OnboardingPageView.instanceFromNib() as? OnboardingPageView
            view?.titleLabel.text = item.title
            view?.titleLabel.font = Fonts.Primary.Bold.toFontWith(size: 24)
            view?.titleLabel.textColor = Colors.TextColor.color()
            view?.descriptionLabel.text = item.description
            view?.descriptionLabel.font = Fonts.Primary.Bold.toFontWith(size: 17)
            view?.descriptionLabel.textColor = Colors.TextColor.color().withAlphaComponent(0.7)
            
            view?.iconImageView.image = UIImage(named: item.image)
            view?.frame = CGRect(x: offset, y: 0, width: self.view.frame.width, height: self.view.frame.height/2)
            
            scrollView.addSubview(view!)
        }
    }
    
    
    @IBAction func doneTapped(_ sender: UIButton) {
        gotoHomeScreen()
    }
    
    @IBAction func skipTapped(_ sender: UIButton) {
        gotoHomeScreen()
    }
    
    func gotoHomeScreen() {
        AppSettingUtils.setShowOnBoarding(isShowed: true)
        
        performSegue(withIdentifier: Segues.OnBoarding.ToHome, sender: nil)
    }
}

extension OnBoardingViewController:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        let pageWidth = scrollView.frame.size.width
        let fractionalPage = scrollView.contentOffset.x / pageWidth
        let page = lround(Double(fractionalPage))
        currentPage = page
        pageControl.currentPage = page
        // last index
        if page == listItems.count - 1 {
            doneButton.isHidden = false
            skipButton.isHidden = true
        } else {
            doneButton.isHidden = true
            skipButton.isHidden = false
        }
    }
}
