//
//  GetTasksResponse.swift
//  TODOApp-MVC-Demo
//
//  Created by IDE Academy on 11/2/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
struct getTasksResponse: Codable {
    let count: Int
    let data: [AllTaskes]
    
}

