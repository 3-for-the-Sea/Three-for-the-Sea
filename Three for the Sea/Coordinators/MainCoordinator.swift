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
        
        let storyboardName = "Main"
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let onboardingVC: OnboardingViewController = storyboard.instantiateViewController(identifier: "OnboardingViewController")
        onboardingVC.delegate = self
        
        navigationController.setViewControllers([onboardingVC], animated: true)
    }
}

extension MainCoordinator: OnboardingCoordinatorDelegate {
    func didFinish() {
        
        let storyboardName = "Main"
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let tabBarController: UITabBarController = storyboard.instantiateViewController(identifier: "tabBarController")
        tabBarController.selectedIndex = 0
        
        navigationController.setViewControllers([tabBarController], animated: true)
    }
}
