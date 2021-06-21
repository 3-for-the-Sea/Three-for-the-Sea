//
//  User.swift
//  Three for the Sea
//
//  Created by Theo Vora on 5/26/21.
//  Copyright © 2021 Ocean Blue Project. All rights reserved.
//

import Foundation

class User: Codable {
    var userID: String
    var nameComponents: PersonNameComponents?
    var email: String
    
    init(userID: String, nameComponents: PersonNameComponents?, email: String) {
        self.userID = userID
        self.email = email
        
        if let nameComponents = nameComponents {
            self.nameComponents = nameComponents
        }
    }
    
    var firstName: String {
        get {
            return nameComponents?.givenName ?? "FirstName"
        }
    }
    
    var lastName: String {
        get {
            return nameComponents?.familyName ?? "LastName"
        }
    }
}
