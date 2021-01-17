//
//  UIViewController+Alert.swift
//  TODOApp-MVC-Demo
//
//  Created by IDE Academy on 11/4/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController {
    func showAlert(title: String, message: String, okTitle: String = "OK", okHandler: ((UIAlertAction)->Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okTitle, style: .cancel, handler: okHandler))
        self.present(alert, animated: true, completion: nil)
    }
}
