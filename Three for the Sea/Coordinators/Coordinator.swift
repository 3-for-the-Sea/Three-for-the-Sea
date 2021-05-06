//
//  Coordinator.swift
//  Three for the Sea
//
//  Created by Theo Vora on 5/6/21.
//  Copyright © 2021 Ocean Blue Project. All rights reserved.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
