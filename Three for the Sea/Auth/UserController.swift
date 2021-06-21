//
//  UserController.swift
//  Three for the Sea
//
//  Created by Theo Vora on 5/27/21.
//  Copyright © 2021 Ocean Blue Project. All rights reserved.
//

import Foundation
import AuthenticationServices

class UserController {
    
    static let shared = UserController()
    
    private(set) var currentUser: User?
    
    func setCurrentUser(with appleIDCredential: ASAuthorizationAppleIDCredential) {
        // TODO: - Need to save this data to a server.
        // Name and email are available upon initial user sign up; name and email are nil for returning users.
        let userID = appleIDCredential.user,
            nameComponents = appleIDCredential.fullName,
            email = appleIDCredential.email ?? "EMAIL"
        
        currentUser = User(userID: userID, nameComponents: nameComponents, email: email)
        
        // Store user in UserDefaults
        userDefaults.set(try? PropertyListEncoder().encode(currentUser), forKey: TFSUserDefaults.currentUser)
    }
    
    func restoreCurrentUser() {
        if let userData = userDefaults.value(forKey: TFSUserDefaults.currentUser) as? Data {
            
            let user = try? PropertyListDecoder().decode(User.self, from: userData)
            
            currentUser = user
        }
    }
}
