//
//  AllTasks.swift
//  TODOApp-MVC-Demo
//
//  Created by IDE Academy on 11/2/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
struct AllTaskes: Codable {
    let completed: Bool
    let _id: String
    let description: String
    let owner: String
    
    enum codingKyes: String, CodingKey{
        case completed, description, owner
        case id = "_id"
    }
}
