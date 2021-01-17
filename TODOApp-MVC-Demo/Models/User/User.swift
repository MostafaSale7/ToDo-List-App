//
//  User.swift
//  TODOApp-MVC-Demo
//
//  Created by IDE Academy on 12/6/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
struct User:Codable {
    var name, email, password: String?
    var age: Int?
    
    init(email:String, password:String) {
        self.email = email
        self.password = password
    }
    
    init(name:String, email:String, password:String, age:Int) {
        self.name = name
         self.email = email
        self.password = password
        self.age = age
    }
}
