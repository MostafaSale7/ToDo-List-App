//
//  UpdateProfileResponse.swift
//  TODOApp-MVC-Demo
//
//  Created by IDE Academy on 11/6/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
struct UpdateProfileResponse: Codable {
    let success: Bool
    let data: UpdatedData
    
    enum codingKeys: String, CodingKey{
        case success
    }
}
