//
//  AddTaskResponse.swift
//  TODOApp-MVC-Demo
//
//  Created by IDE Academy on 11/1/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
struct AddNewTaskResponse: Codable {
    
    let success: Bool
    let data: TaskData

    enum codingKeys: String, CodingKey{
        case success
      }
}



