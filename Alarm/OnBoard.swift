//
//  ViewController.swift
//  AnimatedPageView
//
//  Created by Stefano Brandi on 11/06/21.
//

import UIKit
import paper_onboarding

class OnBoard: UIViewController {
    
    @IBOutlet weak var skipButton: UIButton!
    
    
     
    
    fileprivate let items = [
        OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "image1"),
                           title: "Welcome to \nShake-it alarm!",
                           description: "The alarm in your pocket",
                           pageIcon: nil,
                           color: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),
                           titleColor: UIColor.white,
                           descriptionColor: UIColor.white,
                           titleFont: titleFont,
                           descriptionFont: descriptionFont),
        
        OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "image2"),
                           title: "You will no longer jump out of bed!",
                           description: "You can choose between different ringtones and choose the one that makes you wake up on with the right mood",
                           pageIcon: nil,
                           color: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1),
                           titleColor: UIColor.white,
                           descriptionColor: UIColor.white,
                           titleFont: titleFont,
                           descriptionFont: descriptionFont),
        
        OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "image3"),
                           title: "Never be late on dates again",
                           description: "Forget being late to appointments or events, you will have everything under control in the palm of your hand",
                           pageIcon: nil,
                           color: UIColor(red:0.00, green:0.29, blue:0.59, alpha:1.0),
                           titleColor: UIColor.white,
                           descriptionColor: UIColor.white,
                           titleFont: titleFont,
                           descriptionFont: descriptionFont),
        
        OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "image4"),
                           title: "What are you \nwaiting for?",
                           description: "It's time to get the situation under control",
                           pageIcon: nil,
                           color: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1),
                           titleColor: UIColor.white,
                           descriptionColor: UIColor.white,
                           titleFont: titleFont,
                           descriptionFont: descriptionFont),
    ]
    
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
     
    // MARK: USER DEFAULT !!!
    
    override func viewDidAppear(_ animated: Bool) {
         
        if UserDefaults.standard.object(forKey: "cache") as? String != nil {
            UserDefaults.standard.set("onboard", forKey: "cache")
            performSegue(withIdentifier: "goToAlarm", sender: nil)
            
        } else {
            print("No Cache")
        }
    }
    
    override func viewDidLoad() {
        
        skipButton.setTitle("Let's go!", for: .normal)
         
        skipButton.titleLabel?.attributedText = NSAttributedString(string: "Let's go!", attributes:[.underlineStyle: NSUnderlineStyle.single.rawValue])
        
        
        super.viewDidLoad()
        
        skipButton.isHidden = true
        
        setupPaperOnboardingView()
        
        view.bringSubviewToFront(skipButton)
    }
    
    private func setupPaperOnboardingView() {
        let onboarding = PaperOnboarding()
        onboarding.delegate = self
        onboarding.dataSource = self
        onboarding.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboarding)
        
        // Add constraints
        for attribute: NSLayoutConstraint.Attribute in [.left, .right, .top, .bottom] {
            let constraint = NSLayoutConstraint(item: onboarding,
                                                attribute: attribute,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: attribute,
                                                multiplier: 1,
                                                constant: 0)
            view.addConstraint(constraint)
        }
    }
    
}

// MARK: Actions

extension OnBoard {
    
    @IBAction func skipButtonTapped(_ sender: UIButton) {
        // MARK: Setto lo UserDefaults con valore "cache" dopo aver cliccato il bottone Prosegui
        
        UserDefaults.standard.set("onboard", forKey: "cache")
         
        
        UIButton.animate(withDuration: 0.19,
                         animations: {
                            sender.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                         },
                         completion: { finish in
                            UIButton.animate(withDuration: 0.19, animations: {
                                sender.transform = CGAffineTransform.identity
                            })
                         })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.performSegue(withIdentifier: "goToAlarm", sender: nil)
        }
        
        print(#function)
    }
}

// MARK: PaperOnboardingDelegate

extension OnBoard: PaperOnboardingDelegate {
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        skipButton.isHidden = index == 3 ? false : true
    }
    
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        // configure item
        
        //item.titleLabel?.backgroundColor = .redColor()
        //item.descriptionLabel?.backgroundColor = .redColor()
        //item.imageView = ...
    }
}

// MARK: PaperOnboardingDataSource

extension OnBoard: PaperOnboardingDataSource {
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        return items[index]
    }
    
    func onboardingItemsCount() -> Int {
        return items.count
    }
    
    //    func onboardinPageItemRadius() -> CGFloat {
    //        return 2
    //    }
    //
    //    func onboardingPageItemSelectedRadius() -> CGFloat {
    //        return 10
    //    }
    //    func onboardingPageItemColor(at index: Int) -> UIColor {
    //        return [UIColor.white, UIColor.red, UIColor.green][index]
    //    }
}


//MARK: Constants

private extension OnBoard {
    
    static let titleFont = UIFont(name: "Nunito-Bold", size: 36.0) ?? UIFont.boldSystemFont(ofSize: 36.0)
    static let descriptionFont = UIFont(name: "OpenSans-Regular", size: 16.0) ?? UIFont.systemFont(ofSize: 16.0)
}

