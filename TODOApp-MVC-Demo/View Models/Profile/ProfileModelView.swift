//
//  ProfileRegister.swift
//  TODOApp-MVC-Demo
//
//  Created by IDE Academy on 11/20/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
protocol ProfileModelViewProtocol {
    func callLogOutApi()
    func getUserImage()
    func uploadUserImage(imageData:Data)
    func getUserData()
    func enableEditingFileds(isPressed:Bool, sectionNum:Int, rowNum:Int)
    func checkIfEditProfileButtonPressedOrNot(isPressed:Bool) -> Bool
    func decideWhichFiledToUpdate(flag:Int, newValue:String?)
    func setTableViewValues() -> (String, String, String, String, Int)
    func setImageViewValue() -> Data
}
class ProfileModelView{
    weak var profileVC:ProfileVCProtocol!
    
    var nameLable:String?
    var emailLable:String?
    var ageLable:String?
     var firstTwoLettersLable:String?
    var profileImageView:Data!
    var flag = 0
    
    init(profileVC:ProfileVCProtocol) {
        self.profileVC = profileVC
    }
    // MARK:- Privte Functions
    private func takeFirstLettersFromUserName(userName:String)-> String?{
        var lettersLogo = ""
        var tempLetter = ""
        var spaceCount = 0
        if !userName.isEmpty{
            for i in 0..<userName.count {
                if spaceCount == 1{
                    return lettersLogo
                }
                else{
                    if i == 0 {
                        tempLetter = "\(userName[userName.index(userName.startIndex, offsetBy: i)])"
                        lettersLogo = tempLetter
                        tempLetter = ""
                    }
                    else{
                        tempLetter = "\(userName[userName.index(userName.startIndex, offsetBy: i)])"
                        if tempLetter == " " {
                            if i+1 < userName.count {
                                lettersLogo += "\(userName[userName.index(userName.startIndex, offsetBy: i+1)])"
                                spaceCount = 1
                            }
                        }
                    }
                }
            }
            if spaceCount == 0{
                lettersLogo += "\(userName[userName.index(userName.startIndex, offsetBy: 1)])"
                return lettersLogo
            }
        }
        return " "
    }
}
extension ProfileModelView:ProfileModelViewProtocol{
    func setImageViewValue() -> Data {
        return self.profileImageView
    }
    
    func setTableViewValues() -> (String, String, String, String, Int) {
        return (nameLable ?? "", emailLable ?? "", ageLable ?? "", firstTwoLettersLable ?? "", flag)
    }
    
    func callLogOutApi() {
        print("Trying To Call The Api from LogOut from Profile")
        self.profileVC.showLoader()
        APIManager.logoutAPIRouter(){(response) in
            
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let result):
                if result.success{
                    print("you Logged out Successfully")
                    print(result)
                    self.profileVC.switchToSignInState()
                    UserDefaultsManager.shared().token = nil
                }
                else{
                    print("Falied to Logout")
                }
                self.profileVC.hideLoader()
            }
        }
    }
    func uploadUserImage(imageData:Data){
        print("Trying To Call The Api from Upload user Image")
        self.profileVC.showLoader()
        APIManager.uploadUserImage(imageToJpegData: imageData){(response) in
            if !response{
                print("Cannot Upload Image")
            }
            else{
                self.firstTwoLettersLable = nil
                self.profileVC.updateTableViewValues()
                print("User's Profile Image has been uploaded successfully")
                //self.getUserImage()
            }
            self.profileVC.hideLoader()
        }
    }
    func getUserImage(){
        print("Trying To Call The Api from Get User's Profile Image")
        self.profileVC.showLoader()
        APIManager.getImageAPI(){(error, data,imageResponse) in
            
            guard error == nil else{
                print(error?.localizedDescription)
                return
            }
            if let data = data{
                print("Profile Image Is Shown")
                self.profileImageView = data
                self.profileVC.bringImageViewValue()
            }
        }
            self.profileVC.hideLoader()
    }
    func getUserData() {
        print("Trying To Call The Api from Show User's Profile")
        self.profileVC.showLoader()
        APIManager.getUserProfileDataAPIRouter(){(response) in
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let result):
                print("User's Profile has been uploaded successfully")
                self.nameLable = result.name
                self.emailLable = result.email
                self.ageLable = "\(result.age )"
                self.getUserImage()
                if self.profileImageView != nil{
                    self.firstTwoLettersLable = nil
                }
                else{
                    self.firstTwoLettersLable = self.takeFirstLettersFromUserName(userName: self.nameLable ?? "")
                }
                self.profileVC.updateTableViewValues()
                self.profileVC.hideLoader()
            }
        }
    }
    func updateUserData(filedToUpdate:String, newValue:String){
        print("Trying To Call The Api from Update User Data")
        self.profileVC.showLoader()
        APIManager.updateUserProfileDataAPIRouter(filedToUpdate: filedToUpdate, newValue: newValue){(response) in
            switch response{
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let result):
                print(filedToUpdate + "filed has been updated successfully")
                print(result)
                self.getUserData()
            }
            self.profileVC.hideLoader()
        }
    }
    func enableEditingFileds(isPressed:Bool, sectionNum:Int, rowNum:Int) {
        if isPressed {
            if sectionNum == 1{
                if rowNum == 0{
                    self.profileVC.displayAlertAction(alertTitle: "Update Profile Filed", alertMessage: "Enter your new value to update Name filed")
                    self.flag = 1
                    self.profileVC.updateTableViewValues()
                }
                else if rowNum == 1 {
                    self.profileVC.displayAlertAction(alertTitle: "Update Profile Filed", alertMessage: "Enter your new value to update Email filed")
                    self.flag = 2
                    self.profileVC.updateTableViewValues()
                }
                else if rowNum == 2{
                    self.profileVC.displayAlertAction(alertTitle: "Update Profile Filed", alertMessage: "Enter your new value to update Age filed")
                    self.flag = 3
                    self.profileVC.updateTableViewValues()
                }
            }
        }
    }
    func checkIfEditProfileButtonPressedOrNot(isPressed:Bool) -> Bool {
        if !isPressed{
            return false
        }
        else{
            return true
        }
    }
    func decideWhichFiledToUpdate(flag:Int, newValue:String?) {
        switch flag {
        case 1:
            guard let name = newValue?.trimmed, !name.isEmpty else {
                self.profileVC.presentError(with: "Enter a name to Update the Filed")
                return
            }
            self.flag = 0
            self.updateUserData(filedToUpdate: ParameterKeys.name, newValue: name)
            self.profileVC.updateTableViewValues()
        case 2:
            guard let email =  newValue?.trimmed , ValidateManger.getSharedInstance().valideE_mail(email: email) else {
                self.profileVC.presentError(with: "Enter a valid Email")
                return
            }
            self.flag = 0
            self.updateUserData(filedToUpdate: ParameterKeys.email, newValue: email)
            self.profileVC.updateTableViewValues()
        case 3:
            guard let age = Int(newValue!), age > 3 else {
                self.profileVC.presentError(with: "Enter an age grater than 3 years")
                return
            }
            self.flag = 0
            self.updateUserData(filedToUpdate: ParameterKeys.age, newValue: "\(age)")
            self.profileVC.updateTableViewValues()
        default:
            print("Flag = 0")
        }
    }
}
