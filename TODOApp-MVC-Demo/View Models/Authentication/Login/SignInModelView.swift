//
//  SignInPresenter.swift
//  TODOApp-MVC-Demo
//
//  Created by IDE Academy on 11/13/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
protocol SignInViewModelProtocol {
     func login(email:String?, password:String?)
}
class SignInViewModel{
    
    weak var signInVC:SignInVCProtocol!
    
    init(signIn:SignInVCProtocol) {
        self.signInVC = signIn
    }
  
    // MARK:- Private Functions
    private func callLoginAPI(email:String, password:String){
        print("Trying to Call The API from SignIn")
        let body = User(email: email, password: password)
        self.signInVC.showLoader()
        APIManager.loginAPIRouter(body:body){(response) in
            switch response{
            case .failure(let error):
                self.signInVC.presentError(message:error.localizedDescription)
                print(error.localizedDescription)
            case .success(let result):
                print(result.token)
                UserDefaultsManager.shared().token = result.token
                self.signInVC.switchToMainState()
            }
             self.signInVC.hideLoader()
        }
    }
}
extension SignInViewModel:SignInViewModelProtocol{
    func login(email:String?, password:String?){
        guard let email = email?.trimmed , !email.isEmpty else {
            self.signInVC.presentError(message: "Please Enter an Email")
            return
        }
        guard ValidateManger.getSharedInstance().valideE_mail(email: email) else{
            self.signInVC.presentError(message: "Please Enter Valid Email")
            return
        }
        guard let password = password, !password.isEmpty, password.count >= 8 else {
            self.signInVC.presentError(message: "Please Enter a Password")
            return
        }
        guard ValidateManger.getSharedInstance().validatePassword(password: password) else{
            self.signInVC.presentError(message: AlertMessages.RightPasswordFormatDescription)
            return
        }
        callLoginAPI(email: email, password: password)
    }
}










