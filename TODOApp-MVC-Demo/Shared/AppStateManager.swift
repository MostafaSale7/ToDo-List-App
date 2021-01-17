//
//  AppStateManager.swift
//  TODOApp-MVC-Demo
//
//  Created by IDE Academy on 12/6/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
import UIKit
protocol AppStateManagerProtocol {
    func start(appDelegate:AppDelegate)
}
class AppStateManager{
    
    enum AppState {
        case none
        case main
        case auth
    }
    private static let sharedInstance = AppStateManager()
    
    var appDelegte:AppDelegateProtocol!
    var minWindow:UIWindow? {
        return self.appDelegte.getMainWindow()
    }
    var state:AppState = .none{
        willSet(newState){
            switch newState{
            case .main:
                 switchToMainState()
            case .auth:
                 switchToAuthState()
            default:
                return
            }
        }
    }
    
    class func getSharedInstance() -> AppStateManager {
       return AppStateManager.sharedInstance
    }
    
    func switchToMainState() {
        let todoListVC = TodoListVC.create()
        todoListVC.mainStateDelegate = self
        let navigationController = UINavigationController(rootViewController: todoListVC)
        self.minWindow?.rootViewController = navigationController
    }
    
    func switchToAuthState() {
        let signInVC = SignInVC.create()
        signInVC.authenticationDelegate = self
        let navigationController = UINavigationController(rootViewController: signInVC)
        self.minWindow?.rootViewController = navigationController
    }
    
}

extension AppStateManager:AppStateManagerProtocol{
    func start(appDelegate:AppDelegate) {
        self.appDelegte = appDelegate
        if UserDefaultsManager.shared().token != nil {
          self.state = .main
        } else {
           self.state = .auth
        }
    }
}
extension AppStateManager:authenticationDelegate{
    func showMainState() {
        self.state = .main
    }
}
extension AppStateManager:MainStateDelegate{
    func showAuthenticationState() {
        self.state = .auth
    }
}
