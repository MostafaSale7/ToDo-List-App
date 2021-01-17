//
//  Constants.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation


// Storyboards
struct Storyboards {
    static let authentication = "Authentication"
    static let main = "Main"
}

// View Controllers
struct ViewControllers {
    static let signUpVC = "SignUpVC"
    static let signInVC = "SignInVC"
    static let todoListVC = "TodoListVC"
    static let mainScreen = "MainScreenVC"
    static let userProfileVC = "ProfileStaticCells"
    static let tableViewCell = "TableViewCell"
    static let profileVC = "ProfileVC"
    
}

// Urls
struct URLs {
    static let base = "https://api-nodejs-todolist.herokuapp.com"
    static let login = "https://api-nodejs-todolist.herokuapp.com/user/login"
    static let logout = "https://api-nodejs-todolist.herokuapp.com/user/logout"
    static let register = "https://api-nodejs-todolist.herokuapp.com/user/register"
    static let addTask = "https://api-nodejs-todolist.herokuapp.com/task"
    static let getAllTasks = "https://api-nodejs-todolist.herokuapp.com/task"
    static let userProfile = "https://api-nodejs-todolist.herokuapp.com/user/me"
    static let updateUser = "https://api-nodejs-todolist.herokuapp.com/user/me"
    static let deleteTask = "https://api-nodejs-todolist.herokuapp.com/task/"
    static let uploadImage = "https://api-nodejs-todolist.herokuapp.com/user/me/avatar"
    static let getUserImage = "https://api-nodejs-todolist.herokuapp.com/user/"
}

// Header Keys
struct HeaderKeys {
    static let contentType = "Content-Type"
    static let authorization = "Authorization"
}

// Parameters Keys
struct ParameterKeys {
    static let name = "name"
    static let email = "email"
    static let password = "password"
    static let age = "age"
    static let description = "description"
}

// UserDefaultsKeys
struct UserDefaultsKeys {
    static let token = "UAUToken"
}

struct ForCellReuseIdentifier {
    static let reuseIdentifire = "Note Cell"
}

/// Alert messages

struct AlertMessages {
    static let nameFiledIsEmpty = "Name Filed is Empty, Please Re-Enter your Name"
    static let emailFiledIsEmpty = "E-mail Filed is Empty, Please Re-Enter your Mail"
    static let passwordFiledIsEmpty = "Password Filed is Empty, Please Re-Enter your Password"
    static let ageFiledIsEmpty = "Age Filed is Empty, Please Re-Rnter your Age"
    static let emailWrongFormatDescribtion = "You Entered a wrong E-mail Format, Please Re-Enter your Mail"
    static let RightPasswordFormatDescription = "Password Filed is Empty or Doesn't Contain at least 1 Alphabet, 1 Number and 1 Special Character and Minimum 8 characters."
    static let rightAgeFormat = "You have to be grater than 3 years to Register"
    
    static let passwordRightFormatDescription = "Password Filed is Empty or Doesn't Contain at least 1 Alphabet, 1 Number and 1 Special Character and Minimum 8 characters."
}

struct AlertTitles {
    static let invalidEmailFormat = "Invalid E-mail Format"
    static let invalidPasswordFormat = "Invalid Password Format"
    static let invalidAgeFormat = "Invalid Age Format"
}

struct EmailAlertMessage {
    static let message = "Found Email Filed is Empty, Fill it Please"
    
    static let RightFormatDescription = "E-mail Filed is Empty or InValid E-mail Format"
    static let EmptyE_mailFiled = "Found Email Filed is Empty, Fill it Please"
    static let DisMatchedE_mail = "E-mail field isn't Match"
    static let UsedE_mail = "You Enterd an Email That is already used before, please use another email else to continue sign Up Process."
    static let NotUniqueE_mail = "An Email is already in use"
    static let UnIdentifiableE_mail = "You have been Entered a non-Registered Email, so Please enate Identifiable Email"
    
}

struct PasswordAlertMessage {
    static let message = "Found Password Filed is Empty, Fill it Please"
    
   
    static let EmptyPasswordFiled = "Found Password Filed is Empty, Fill it Please"
    static let DisMatchedPassword = "Password field isn't Match"
}
