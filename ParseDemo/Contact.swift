//
//  Contact.swift
//  Instalert
//
//  Created by Mac on 10/24/15.
//  Copyright © 2015 CSB. All rights reserved.
//

import Foundation

struct Contact {
    let username: String?
    let firstName: String?
    let lastName: String?
    let phoneNumber: String?
    let email: String?
    
    init(username: String, firstName: String, lastName: String, phoneNumber: String, email: String) {
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.email = email

    }
}
