//
//  User.swift
//  ContactList
//
//  Created by Max Jala on 08/02/2018.
//  Copyright © 2018 Max Jala. All rights reserved.
//

import Foundation

class User {
    
    var uid : String = ""
    var email : String = ""
    var age : Int = 0
    
    init(uid: String, dict: [String:Any]) {
        
        self.uid = uid
                                            // "??" lets me set default value if nothing is found
        self.email = dict["email"] as? String ?? "no email"
        self.age = dict["age"] as? Int ?? 0
        
    }
    
}
