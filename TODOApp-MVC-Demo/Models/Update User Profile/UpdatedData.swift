//
//  UpdatedData.swift
//  TODOApp-MVC-Demo
//
//  Created by IDE Academy on 11/6/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
struct UpdatedData: Codable {
    
    var _id: String
    var name, email: String
    var age: Int
    
    
    enum CodingKeys: String, CodingKey {
        case age, name, email
        case _id = "_id"
    }
}
