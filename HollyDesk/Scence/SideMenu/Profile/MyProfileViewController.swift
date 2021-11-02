//
//  MyProfileViewController.swift
//  HollyDesk
//
//  Created by rania refaat on 03/10/2021.
//

import UIKit
import SSSpinnerButton

class MyProfileViewController: UIViewController {

    @IBOutlet weak var uploadButton: SSSpinnerButton!
    @IBOutlet weak var roleTF: UITextField!
    @IBOutlet weak var worktitleTF: UITextField!
    @IBOutlet weak var teamTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var imageContainerView: UIView!
    
    //MARK:- variables
    var imagePicker : ImagePicker!
    let message = Messages()
    let screenTitle = ScreenTitle()
var imageFlag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextField()
        
        imageContainerView.layer.cornerRadius = imageContainerView.frame.height / 2
        imageContainerView.layer.masksToBounds = true
        imagePicker = ImagePicker(presentationController: self, delegate: self)
        title = screenTitle.profile
    }
    private func setTextField(){
        textPadding(tf: roleTF)
        textPadding(tf: worktitleTF)
        textPadding(tf: teamTF)
        textPadding(tf: lastNameTF)
        textPadding(tf: firstNameTF)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        HideNavigationBar(status: false)
        fillUserData()
    }
    private func fillUserData(){
        let userFName = UserDefaultData.get_user_string_data(key: UserDefaultDataKeys.firstName) ?? ""
        let userLName = UserDefaultData.get_user_string_data(key: UserDefaultDataKeys.lastName) ?? ""
        let userImage = UserDefaultData.get_user_string_data(key: UserDefaultDataKeys.userImage) ?? ""
        
        let userTeam = UserDefaultData.get_user_string_data(key: UserDefaultDataKeys.team) ?? ""

        let workTitle = UserDefaultData.get_user_string_data(key: UserDefaultDataKeys.jobTitle) ?? ""
        let role = UserDefaultData.get_user_string_data(key: UserDefaultDataKeys.role) ?? ""
        
        roleTF.text = role
        firstNameTF.text = userFName
        lastNameTF.text = userLName
        teamTF.text = userTeam
        worktitleTF.text = workTitle
        roleTF.text = role
        
        userImageView.loadImageUrl(userImage)

    }
    @IBAction func uploadButtonTapped(_ sender: SSSpinnerButton) {
        if isNotEmptyString(text: self.firstNameTF.text!, withAlertMessage: message.FNameMessage) && isNotEmptyString(text: self.lastNameTF.text!, withAlertMessage: message.LNameMessage) && isNotEmptyString(text: self.worktitleTF.text!, withAlertMessage: message.workTitleMessage){
                var params = ["firstName":self.firstNameTF.text!,
                              "lastName":self.lastNameTF.text!,
                              "jobTitle": self.worktitleTF.text!,
                              ]as[String:AnyObject]
            
            if imageFlag{
                params["type"] = "profile" as AnyObject
            }else{
                params["type"] = "notSet" as AnyObject
            }
            updateProfile(parameters: params)

        }
    }
    @IBAction func uploadProfileImageTapped(_ sender: UIButton) {
        view.endEditing(true)
        imagePicker.present(from: sender)
    }
}
extension MyProfileViewController : ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        guard let selectedImage = image else {
            return
        }
        imageFlag = true
        userImageView.image = selectedImage
    }
}
