//
//  SignInVC.swift
//  TODOApp-MVC-Demo
//
//  Created by IDEAcademy on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit
protocol authenticationDelegate: class {
    func showMainState()
}
protocol SignInVCProtocol: class {
    func presentError(message: String)
    func showLoader()
    func hideLoader()
    func switchToMainState()
}
class SignInVC: UIViewController {

    @IBOutlet var signInView: SignInView!
    var signInViewModel:SignInViewModelProtocol!
    var authenticationDelegate: authenticationDelegate?
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        signInView.setUp()
    }
    @IBAction func signInButtonPressed(_ sender: Any) {
        self.signInViewModel.login(email: signInView.emailTextFiled.text, password: signInView.passwordTextFiled.text)
    }
    
    @IBAction func goToRegisterVc(_ sender: Any) {
        let registerVC = SignUpVC.create()
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    // MARK:- Public Methods
    class func create() -> SignInVC {
        let signInVC: SignInVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.signInVC)
        signInVC.signInViewModel = SignInViewModel(signIn: signInVC)
        return signInVC
    }
}
extension SignInVC:SignInVCProtocol{
    
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
