//
//  ViewController.swift
//  TODOApp-MVC-Demo
//
//  Created by IDE Academy on 11/1/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class MainScreenVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK:- Public Methods
    class func create() -> MainScreenVC {
        let mainscreenVC: MainScreenVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.mainScreen)
        return mainscreenVC
    }
        /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
