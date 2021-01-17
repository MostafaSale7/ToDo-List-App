////
////  APIManager.swift
////  TODOApp-MVC-Demo
////
////  Created by IDEAcademy on 10/27/20.
////  Copyright © 2020 IDEAEG. All rights reserved.
////

import Foundation
import Alamofire

class APIManager {
   
    //APiRouter //////////////////
    class func loginAPIRouter(body:User, completion: @escaping (Result<LoginResponse, Error>)-> ()){
        request(APIRouter.login(body)){ (response) in
        completion(response)
        }
    }
     //APiRouter //////////////////
    class func logoutAPIRouter(completion: @escaping (Result<LogoutResponse, Error>)-> ()){
        request(APIRouter.logOut){ (response) in
            completion(response)
        }
    }
     //APiRouter //////////////////
    class func registerAPIRouter(body:User, completion: @escaping (Result<LoginResponse, Error>)-> ()){
        request(APIRouter.register(body)){ (response) in
            completion(response)
        }
    }
     //APiRouter //////////////////
    class func addNewToDoAPIRouter(description: String, completion: @escaping (Result<AddNewTaskResponse, Error>)-> ()){
        request(APIRouter.addNewToDo(description)){ (response) in
            completion(response)
        }
    }
     //APiRouter //////////////////
    class func getAllToDosAPIRouter(completion: @escaping (Result<getTasksResponse, Error>)-> ()){
        request(APIRouter.getAllToDos){ (response) in
            completion(response)
        }
    }
     //APiRouter //////////////////
    class func getUserProfileDataAPIRouter(completion: @escaping (Result<UserData, Error>)-> ()){
        request(APIRouter.getUserProfileData){ (response) in
            completion(response)
        }
    }
     //APiRouter //////////////////
    class func updateUserProfileDataAPIRouter(filedToUpdate: String, newValue:String, completion: @escaping (Result<UpdateProfileResponse, Error>)-> ()){
        request(APIRouter.updateUserProfileData(filedToUpdate, newValue)){ (response) in
            completion(response)
        }
    }
    //APiRouter //////////////////
    class func deleteToDoAPIRouter(taskID: String, completion: @escaping (Result<DeleteTaskResponse, Error>)-> ()){
        request(APIRouter.deleteToDo(taskID)){ (response) in
            completion(response)
        }
    }
    
    //APiRouter //////////////////
    class func getImageAPIRouter(completion: @escaping(Result<Data, Error>)-> ()){
        request(APIRouter.getPhoto){(response)  in
            completion(response)
        }
    }

    class func getImageAPI (completion: @escaping (_ error:Error?, _ image:Data?, _ getImageResponse:GetImageResponse?) -> Void){
        AF.request(URLs.getUserImage+UserDefaultsManager.shared().token!+"/avatar", method: HTTPMethod.get).response{response in
            guard response.error == nil else{
                print(response.error?.localizedDescription)
                completion(response.error,nil,nil)
                return
            }
            guard let data = response.data else{
                print("Can't get image")
                return
            }
            completion(nil,data,nil)
            print("Image is Shown")
        }
    
    }

  class func uploadUserImage(imageToJpegData: Data  ,completion: @escaping (Bool) -> Void) {
    guard let userToken = UserDefaultsManager.shared().token else{
        print("Cannot find User Token")
        return
    }
      let headers: HTTPHeaders = [HeaderKeys.authorization: "Bearer \(userToken ?? "")"]
    AF.upload(multipartFormData: {(formData) in
        formData.append(imageToJpegData, withName: "avatar", fileName:  "/home/ali/Mine/c/nodejs-blog/public/img/blog-header.jpg", mimeType: "blog-header.jpg")
    }, to: URLs.uploadImage, method: HTTPMethod.post, headers: headers).response { response in

        guard response.error == nil else{
            print(response.error!.localizedDescription)
            completion(false)
            return
        }
        print(response)
        completion(true)
    }
 }

}
extension APIManager{
    // MARK:- The request function to get results in a closure
    private static func request<T: Decodable>(_ urlConvertible: URLRequestConvertible, completion:  @escaping (Result<T, Error>) -> ()) {
        // Trigger the HttpRequest using AlamoFire
        AF.request(urlConvertible).responseDecodable { (response: AFDataResponse<T>) in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
            }.responseJSON { response in
                print(response)
        }
    }
}
