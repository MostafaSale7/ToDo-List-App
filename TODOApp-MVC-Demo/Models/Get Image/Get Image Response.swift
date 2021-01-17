//
//  Get Image Response.swift
//  TODOApp-MVC-Demo
//
//  Created by IDE Academy on 12/6/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
struct GetImageResponse:Codable {
    let success: Bool
    enum codingKeys: String, CodingKey{
        case success
    }
}
