//
//  APIRouting.swift
//  TODOApp-MVC-Demo
//
//  Created by IDE Academy on 11/12/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
import Alamofire
enum APIRouter:URLRequestConvertible {
    
    // MARK:- The endpoint name
    case login(_ body:User)
    case logOut
    case register(_ body:User)
    case addNewToDo(_ description: String)
    case getAllToDos
    case getUserProfileData
    case updateUserProfileData(_ filedToUpdate: String, _ newValue:String)
    case deleteToDo(_ taskID: String)
    case getPhoto
    // MARK: - HttpMethod
    private var method: HTTPMethod {
        switch self {
        case .getAllToDos, .getUserProfileData, .getPhoto:
            return .get
        case .deleteToDo:
            return .delete
        case .updateUserProfileData:
            return.put
        default:
            return .post
        }
    }
    
    // MARK:- Parameters
    private var parameters: Parameters? {
        switch self {
        case .login(let body):
            return [ParameterKeys.email: body.email, ParameterKeys.password: body.password]
        case .register(let body):
            return [ParameterKeys.name: body.name, ParameterKeys.email: body.email, ParameterKeys.password: body.password, ParameterKeys.age: body.age]
        case .addNewToDo(let description):
            return [ParameterKeys.description: description]
        case .updateUserProfileData(let filedToUpdate, let newValue):
            switch filedToUpdate {
            case ParameterKeys.name:
               return [ParameterKeys.name: newValue]
            case ParameterKeys.email:
               return [ParameterKeys.email: newValue]
            default:
               return [ParameterKeys.age: newValue]
            }
        default:
            return nil
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .login:
            return URLs.login
        case .logOut:
            return URLs.logout
        case .register:
            return URLs.register
        case .addNewToDo:
            return URLs.addTask
        case .getAllToDos:
            return URLs.getAllTasks
        case .getUserProfileData:
            return URLs.userProfile
        case .updateUserProfileData:
            return URLs.updateUser
        case .deleteToDo(let taskID):
            return URLs.deleteTask + taskID
        case .getPhoto:
            return URLs.getUserImage+UserDefaultsManager.shared().token!+"/avatar"
        }
    }

    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try path.asURL()
        var urlRequest = URLRequest(url: url)
        //httpMethod
        urlRequest.httpMethod = method.rawValue
        switch self {
        case .login, .register:
             urlRequest.setValue("application/json", forHTTPHeaderField: HeaderKeys.contentType)
        case .logOut, .getUserProfileData:
            urlRequest.setValue("Bearer \(UserDefaultsManager.shared().token ?? "")",
                forHTTPHeaderField: HeaderKeys.authorization)
        case .addNewToDo, .getAllToDos, .updateUserProfileData, .deleteToDo:
            urlRequest.setValue("Bearer \(UserDefaultsManager.shared().token ?? "")",
                forHTTPHeaderField: HeaderKeys.authorization)
              urlRequest.setValue("application/json", forHTTPHeaderField: HeaderKeys.contentType)
        default:
            break
        }
        
        // HTTP Body
        let httpBody: Data? = {
            switch self {
            case .register(let body):
                return encodeToJSON(body)
            case .login(let body):
                return encodeToJSON(body)
            default:
                return nil
            }
        }()
        urlRequest.httpBody = httpBody
        
        // Encoding
        let encoding: ParameterEncoding = JSONEncoding.default
        
        print(try encoding.encode(urlRequest, with: parameters))
        return try encoding.encode(urlRequest, with: parameters)
       
    }
    
  
}
extension APIRouter {
    private func encodeToJSON<T: Encodable>(_ body: T) -> Data? {
        do {
            let anyEncodable = AnyEncodable(body)
            let jsonData = try JSONEncoder().encode(anyEncodable)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            print(jsonString)
            return jsonData
        } catch {
            print(error)
            return nil
        }
    }
}

// type-erasing wrapper
struct AnyEncodable: Encodable {
    private let _encode: (Encoder) throws -> Void
    
    public init<T: Encodable>(_ wrapped: T) {
        _encode = wrapped.encode
    }
    
    func encode(to encoder: Encoder) throws {
        try _encode(encoder)
    }
}
