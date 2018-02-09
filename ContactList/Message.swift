//
//  Message.swift
//  ContactList
//
//  Created by Max Jala on 09/02/2018.
//  Copyright © 2018 Max Jala. All rights reserved.
//

import Foundation

class Message {
    var email: String = ""
    var message: String = ""
    var timeStamp : Double = 0
    
    init(msgDict: [String:Any]) {
        email = msgDict["email"] as? String ?? "NO EMAIL"
        message = msgDict["msg"] as? String ?? "NO MESSAGE"
        timeStamp = msgDict["timeStamp"] as? Double ?? 0
        message += " (\(timeStamp))"
        
    }
}
