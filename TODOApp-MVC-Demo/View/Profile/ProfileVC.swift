//
//  ProfileStaticCells.swift
//  TODOApp-MVC-Demo
//
//  Created by IDE Academy on 11/6/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

protocol ProfileVCProtocol: class {
    func showLoader()
    func hideLoader()
    func presentError(with message: String)
    func switchToSignInState()
    func displayAlertAction(alertTitle:String, alertMessage:String)
    func updateTableViewValues()
    func bringImageViewValue()
}

protocol profileNavigationProtocol: class{
    func getMainStateDelegate()
}

class ProfileVC:UITableViewController{
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var emailLable: UILabel!
    @IBOutlet weak var ageLable: UILabel!
    @IBOutlet weak var firstTwoLettersLable: UILabel!
    @IBOutlet weak var editProfileLable: UILabel!
    @IBOutlet weak var nameHighlightView: UIView!
    @IBOutlet weak var ageHighlightView: UIView!
    @IBOutlet weak var emailHighlightView: UIView!
    
    var updateTextFiled:UITextField?
    var flag = 0
    var isPressed = false
    var profileModelView:ProfileModelViewProtocol!
    var profilenavigationDelegate:profileNavigationProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createRightButtonInNavigationBar()
        makeImageViewCirclerShape()
        self.profileModelView.getUserData()
        self.profileModelView.getUserImage()
    }
    
    
    @IBAction func editProfileButtonPressed(_ sender: UIButton) {
        if self.profileModelView.checkIfEditProfileButtonPressedOrNot(isPressed: isPressed){
            self.isPressed = false
            self.nameHighlightView.alpha = 0
            self.emailHighlightView.alpha = 0
            self.ageHighlightView.alpha = 0
            self.editProfileLable.alpha = 0
        }
        else{
            self.isPressed = true
            self.nameHighlightView.alpha = 1
            self.emailHighlightView.alpha = 1
            self.ageHighlightView.alpha = 1
            self.editProfileLable.alpha = 1
        }
    }
    @IBAction func logOutButtonPressed(_ sender: UIButton) {
         self.profileModelView.callLogOutApi()
    }
    
    // MARK:- Public Methods
    class func createTableviewController() -> ProfileVC {
        let profileVC: ProfileVC = UITableViewController.createTableviewController(storyboardName: Storyboards.main, identifier: ViewControllers.profileVC)
        profileVC.profileModelView = ProfileModelView(profileVC: profileVC)
        return profileVC
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.profileModelView.enableEditingFileds(isPressed: isPressed, sectionNum: indexPath.section, rowNum: indexPath.row)
    }
    
    // MARK:- Private Methodd
   private func makeImageViewCirclerShape() {
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
        self.profileImageView.clipsToBounds = true;
    }
    
    private func createRightButtonInNavigationBar() {
        let addingButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(AddImage))
        self.navigationItem.rightBarButtonItem = addingButton
    }
    @objc private func AddImage(_ sender:UIBarButtonItem){
       showImagePickerController()
    }
    
    private func okHandler(alert:UIAlertAction) {
        profileModelView.decideWhichFiledToUpdate(flag: self.flag, newValue: updateTextFiled?.text ?? "")
    }
    
    private func editUserProfile(textFiled:UITextField) {
        updateTextFiled?.placeholder = "Update Selected Filed"
        updateTextFiled = textFiled
        if flag == 3 {
            updateTextFiled?.keyboardType = .numberPad
        }
    }
}

extension ProfileVC: ProfileVCProtocol, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func updateTableViewValues() {
        let tableViewValues = self.profileModelView.setTableViewValues()
        self.nameLable.text = tableViewValues.0
        self.emailLable.text = tableViewValues.1
        self.ageLable.text = tableViewValues.2
        self.firstTwoLettersLable.text = tableViewValues.3
        self.flag = tableViewValues.4
    }
    func bringImageViewValue() {
        let image = self.profileModelView.setImageViewValue()
        self.profileImageView.image = UIImage(data: image)
    }
    func showLoader() {
        self.view.showLoader()
    }
    func hideLoader() {
        self.view.hideLoader()
    }
    func presentError(with message: String) {
        self.showAlert(title: "Sorry", message: message)
    }
    
    func switchToSignInState() {
        self.profilenavigationDelegate?.getMainStateDelegate()
        self.navigationController?.popToViewController(self, animated: true)
    }
    func displayAlertAction(alertTitle:String, alertMessage:String) {
        let alertController = UIAlertController(title: alertTitle, message:alertMessage , preferredStyle: .alert)
        alertController.addTextField(configurationHandler: editUserProfile)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: self.okHandler)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController,animated: true)
    }
    
    func showImagePickerController(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController,animated: true,completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            profileImageView.image = editedImage
        }else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImageView.image = originalImage
        }
        guard let imageToJpegData = profileImageView.image?.jpegData(compressionQuality: 0.8) else {
            print("Cannot Convert Image To Jpeg Data")
            return
        }
        self.profileModelView.uploadUserImage(imageData: imageToJpegData)
        dismiss(animated: true, completion: nil)
    }
}
