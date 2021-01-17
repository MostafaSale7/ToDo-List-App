//
//  SignInView.swift
//  TODOApp-MVC-Demo
//
//  Created by IDE Academy on 11/25/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class SignInView: UIView {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var loginLable: UILabel!
    
    @IBOutlet weak var signUpLable: UILabel!
    @IBOutlet weak var doNotHaveLable: UILabel!
    @IBOutlet weak var emailTextFiled: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var sginUpButton: UIButton!
    
    func setUp() {
        setUpImageView(imageView: backgroundImageView, imageName: "background 2")
        
        setUpLable(lable: loginLable, lableText: "Log in", FontName: "American Typewriter", fontSize: 20)
        
        setUpTextFiled(textFiled: emailTextFiled, placeHolder: "Email", isSecured: false ,FontName: "American Typewriter", fontSize: 20, keyboardType: .emailAddress)
        
        setUpTextFiled(textFiled: passwordTextFiled, placeHolder: "Password", isSecured: true ,FontName: "American Typewriter", fontSize: 20, keyboardType: .default)
        
        setUpButton(button: loginButton, buttonTitle: "Log in", backgrounColor: UIColor.purple)
        
          setUpLable(lable: doNotHaveLable, lableText: "Don't have an account?", FontName: "American Typewriter", fontSize: 17)
        
        setUpLable(lable: signUpLable, lableText: "Sign Up", FontName: "American Typewriter", fontSize: 19)
        
        setUpButton(button: sginUpButton, buttonTitle: "", backgrounColor: UIColor.clear)
    
    }
    
    private func setUpImageView(imageView:UIImageView, imageName:String) {
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: imageName)
    }
    
   private func setUpLable(lable:UILabel, lableText:String, FontName:String, fontSize:Int) {
        lable.text = lableText
        lable.font = UIFont(name: FontName, size: CGFloat(fontSize))
        lable.textColor = UIColor.purple
    }
    
    private func setUpTextFiled(textFiled:UITextField, placeHolder:String, isSecured:Bool , FontName:String, fontSize:Int, keyboardType:UIKeyboardType) {
        textFiled.backgroundColor = .white
        textFiled.placeholder = placeHolder
        textFiled.font = UIFont(name: FontName, size: CGFloat(fontSize))
        textFiled.isSecureTextEntry = isSecured
        textFiled.keyboardType = keyboardType
    }
    
    private func setUpButton(button:UIButton, buttonTitle:String, backgrounColor:UIColor) {
        button.backgroundColor = backgrounColor
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle(buttonTitle, for: .normal)
        button.layer.cornerRadius = button.frame.height / 2
    }
}
