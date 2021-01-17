//
//  signUpView.swift
//  TODOApp-MVC-Demo
//
//  Created by IDE Academy on 11/26/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class signUpView: UIView {

    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var signUpLable: UILabel!
    @IBOutlet weak var nameTextFiled: UITextField!
    @IBOutlet weak var emailTextFiled: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    @IBOutlet weak var ageTextFiled: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var alreadyHaveUnAccLable: UILabel!
    @IBOutlet weak var logInLable: UILabel!
    
    func setUp() {
        setUpImageView(imageView: backgroundImageView, imageName: "background 2")
        
        setUpLable(lable: signUpLable, lableText: "Sign Up", FontName: "American Typewriter", fontSize: 20)
        setUpTextFiled(textFiled: nameTextFiled, placeHolder: "Name", isSecured: false ,FontName: "American Typewriter", fontSize: 20, keyboardType: .default)
        
       
        setUpTextFiled(textFiled: emailTextFiled, placeHolder: "Email", isSecured: false ,FontName: "American Typewriter", fontSize: 20, keyboardType: .emailAddress)
        
        setUpTextFiled(textFiled: passwordTextFiled, placeHolder: "Password", isSecured: true ,FontName: "American Typewriter", fontSize: 20, keyboardType: .default)
        
        setUpTextFiled(textFiled: ageTextFiled, placeHolder: "Age", isSecured: false ,FontName: "American Typewriter", fontSize: 20, keyboardType: .numberPad)
        
        setUpButton(button: signUpButton, buttonTitle: "Sign Up", backgrounColor: UIColor.purple)
        
        setUpLable(lable: alreadyHaveUnAccLable, lableText: "Already have an account?", FontName: "American Typewriter", fontSize: 17)
        
        setUpLable(lable: logInLable, lableText: "Log In", FontName: "American Typewriter", fontSize: 19)
        
        setUpButton(button: signInButton, buttonTitle: "", backgrounColor: UIColor.clear)
        
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
