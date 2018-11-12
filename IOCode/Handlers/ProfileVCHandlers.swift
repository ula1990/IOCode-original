//
//  ProfileVCHandlers.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 11/12/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit
import Firebase

extension ProfileVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @objc public func handleUpdate(){
        guard let newPassword = newPasswordField.text else {return}
        guard let email = currentUser?.email else {return}
        guard let currentPassword = oldPasswordField.text else {return}
        changePassword(email: email, currentPassword: currentPassword, newPassword: newPassword)
    }
    
    
    fileprivate func changePassword(email: String, currentPassword: String, newPassword: String) {
        let credential = EmailAuthProvider.credential(withEmail: email, password: currentPassword)
        Auth.auth().currentUser?.reauthenticate(with: credential, completion: { (error) in
            if error == nil {
                Auth.auth().currentUser!.updatePassword(to: newPassword) { (error) in
                    if error != nil {
                        Alert.showBasic(title: "Password not updated", msg: "Please check input and connection", vc: self)
                    }else{
                        Alert.showBasic(title: "Success", msg: "Update was performed", vc: self)
                        self.newPasswordField.text = ""
                        self.oldPasswordField.text = ""
                    }
                }
            } else {
                Alert.showBasic(title: "Wrong credentials or possible no connection", msg: "Please check your input and try again", vc: self)
            }
        })
    }
    
    @objc public func removeAccount(){
        if oldPasswordField.text?.isEmpty == true {
            Alert.showBasic(title: "Please enter you current password", msg: "To remove account you need to enter your current password", vc: self)
        }

        guard let email = currentUser?.email else {return}
        guard let currentPassword = oldPasswordField.text else {return}
        let credential = EmailAuthProvider.credential(withEmail: email, password: currentPassword)
        Auth.auth().currentUser?.reauthenticate(with: credential, completion: { (error) in
            if error == nil {
                Auth.auth().currentUser!.delete { (error) in
                    if error != nil {
                        Alert.showBasic(title: "Account was not deleted", msg: "Please check input and connection", vc: self)
                    }else{
                        self.removeAccountFromFirestore()
                        Alert.showBasic(title: "Success", msg: "Update was performed", vc: self)
                        self.newPasswordField.text = ""
                        self.oldPasswordField.text = ""
                        let loginVC = StartVC()
                        self.present(loginVC, animated: true, completion: nil)
                    }
                }
            } else {
                Alert.showBasic(title: "Wrong credentials or possible no connection", msg: "Please check your input and try again", vc: self)
            }
        })
     
    }
    
    fileprivate func removeAccountFromFirestore(){
        guard let email = currentUser?.email else {return}
        db.collection("users").document(email).delete() { err in
            if err != nil {
                print("Error")
            } else {
                print("Profile removed")
            }
        }
    }
    
}



