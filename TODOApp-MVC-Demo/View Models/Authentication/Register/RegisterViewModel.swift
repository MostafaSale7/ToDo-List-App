//
//  RegisterPresenter.swift
//  TODOApp-MVC-Demo
//
//  Created by IDE Academy on 11/20/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
protocol RegisterViewModelProtocol {
     func register(name:String?, email:String?, password:String?, age:Int?)
}
class RegisterViewModel{
    weak var signUpVC:SignUpVCProtocol!
    
    init(signUpVC:SignUpVCProtocol) {
        self.signUpVC = signUpVC
    }
    
    // MARK:- Private Functions
    
    private func callRegisterAPI(name:String, email:String, password:String, age:Int){
       
        print("Trying to Call The API from SignUp")
        let body = User(name: name, email: email, password: password, age: age)
        self.signUpVC.showLoader()
        APIManager.registerAPIRouter(body:body){(response) in
            switch response{
            case .failure(let error):
                self.signUpVC.presentError(message:error.localizedDescription)
                print(error.localizedDescription)
            case .success(let result):
                print(result.token)
                UserDefaultsManager.shared().token = result.token
                self.signUpVC.switchToMainState()
            }
             self.signUpVC.hideLoader()
        }
    }
}
extension RegisterViewModel:RegisterViewModelProtocol{
    func register(name:String?, email:String?, password:String?, age:Int?){
        guard let name = name?.trimmed, !name.isEmpty else{
            self.signUpVC.presentError(message: "Please Enter a Name")
            return
        }
        guard let email = email?.trimmed , !email.isEmpty else {
            self.signUpVC.presentError(message: "Please Enter an Email")
            return
        }
        guard ValidateManger.getSharedInstance().valideE_mail(email: email) else{
            self.signUpVC.presentError(message: "Please Enter Valid Email")
            return
        }
        guard let password = password, !password.isEmpty, password.count >= 8 else {
            self.signUpVC.presentError(message: "Please Enter a Password")
            return
        }
        guard ValidateManger.getSharedInstance().validatePassword(password: password) else{
            self.signUpVC.presentError(message: AlertMessages.RightPasswordFormatDescription)
            return
        }
        guard let age = age, age >= 12 else {
            self.signUpVC.presentError(message: "You Have to Be Grater Than 12 Year to Register")
            return
        }
        callRegisterAPI(name: name, email: email, password: password, age: age)
    }
}
