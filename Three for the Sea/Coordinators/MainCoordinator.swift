//
//  MainCoordinator.swift
//  Three for the Sea
//
//  Created by Theo Vora on 5/6/21.
//  Copyright © 2021 Ocean Blue Project. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        print("MainCoordinator started")
        
        // Show Onboarding only if this is the user's first time
        let hasCompletedOnboarding = userDefaults.bool(forKey: "hasCompletedOnboarding")
        
        switch hasCompletedOnboarding {
        case false:
            launchOnboardingVC()
        case true:
            launchHomeTabVC()
        }
    }
    
    fileprivate func launchOnboardingVC() {
        let onboardingVC = StoryboardScene.Main.instantiateOnboardingViewController()
        onboardingVC.delegate = self
        
        navigationController.setViewControllers([onboardingVC], animated: true)
    }
    
    fileprivate func launchHomeTabVC() {
        let tabBarController = StoryboardScene.Main.instantiateTabBarController()
        tabBarController.selectedIndex = 0
        
        navigationController.setViewControllers([tabBarController], animated: true)
    }
}

extension MainCoordinator: OnboardingCoordinatorDelegate {
    func didFinish() {
        
        userDefaults.setValue(true, forKey: "hasCompletedOnboarding")
        
        launchHomeTabVC()
    }
}
