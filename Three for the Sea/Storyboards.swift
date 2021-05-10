//
//  Storyboards.swift
//  Three for the Sea
//
//  Created by Theo Vora on 5/10/21.
//  Copyright © 2021 Ocean Blue Project. All rights reserved.
//

import UIKit

struct StoryboardScene {
    enum Main: String {
        
        static let storyboardName = "Main"
        
        case OnboardingViewController
        static func instantiateOnboardingViewController() -> OnboardingViewController {
            
            let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
            
            return storyboard.instantiateViewController(identifier: StoryboardScene.Main.OnboardingViewController.rawValue)
        }
        
        case tabBarController
        static func instantiateTabBarController() -> UITabBarController {
            
            let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
            
            return storyboard.instantiateViewController(identifier: StoryboardScene.Main.tabBarController.rawValue)
        }
    }
}
