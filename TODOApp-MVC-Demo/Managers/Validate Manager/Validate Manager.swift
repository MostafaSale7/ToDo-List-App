//
//  Validate Manager.swift
//  TODOApp-MVC-Demo
//
//  Created by IDE Academy on 11/20/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
class ValidateManger{
    
    private static let sharedInstance = ValidateManger()
    
    class func getSharedInstance() -> ValidateManger{
        return ValidateManger.sharedInstance
    }
    
     func valideE_mail(email:String?) ->Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if !emailPred.evaluate(with: email){
            return false
        }
        return true
    }
     func validatePassword(password:String?) -> Bool {
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
        let passwordPred = NSPredicate(format:"SELF MATCHES %@",  passwordRegEx)
        if !passwordPred.evaluate(with: password){
            return false
        }
        return true
    }
}
