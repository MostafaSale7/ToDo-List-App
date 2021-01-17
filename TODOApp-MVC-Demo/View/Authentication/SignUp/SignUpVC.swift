//
//  SignUpVC.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit
protocol SignUpVCProtocol: class {
    func presentError(message: String)
    func showLoader()
    func hideLoader()
    func switchToMainState()
}
class SignUpVC: UIViewController {
    
    @IBOutlet var signUpView: signUpView!
    var authenticationDelegate:authenticationDelegate?

    var registerViewModel:RegisterViewModelProtocol!
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpView.setUp()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationItem.hidesBackButton = true
    }
  
    @IBAction func registerButtonPressed(_ sender: UIButton) {

        let age = Int (signUpView.ageTextFiled.text ?? "0")
        self.registerViewModel.register(name: signUpView.nameTextFiled.text, email: signUpView.emailTextFiled.text, password: signUpView.passwordTextFiled.text, age: age)
    }
    @IBAction func goToSignInViewPressed(_ sender: Any) {
        let signinVC = SignInVC.create()
        self.navigationController?.pushViewController(signinVC, animated: true)
    }
    
    // MARK:- Public Methods
    class func create() -> SignUpVC {
        let signUpVC: SignUpVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.signUpVC)
        signUpVC.registerViewModel = RegisterViewModel(signUpVC: signUpVC)
        return signUpVC
    }
}
extension SignUpVC:SignUpVCProtocol{
    func presentError(message: String) {
        self.showAlert(title: "Sorry", message: message)
    }
    
    func showLoader() {
        self.view.showLoader()
    }
    func hideLoader() {
        self.view.hideLoader()
    }
    
    func switchToMainState() {
       self.authenticationDelegate?.showMainState()
    }
}
