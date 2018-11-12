//
//  StartVCExtension.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 2018-08-01.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit
import Firebase

extension StartVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate  {
    enum LoginRegisterErrors: Error {
        case incompleteForm
        case invalidEmail
        case incorrectPasswordLength
        case nameIsEmpty
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    public func getVersion() -> String {
        let dictionary  = Bundle.main.infoDictionary!
        let version     = dictionary[kVersion] as! String
        let build       = dictionary[kBuildNumber] as! String
        return "Version \(version) (\(build))"
    }
    
    @objc public func handleStart(){
        present(MainTabBar(), animated: true, completion: nil)
    }
    
    @objc public func handleForgotPassword(){
        if presentedViewController != nil {
            return
        }
        
        let alertPrompt = UIAlertController(title: "Forgot password", message: "Please enter your email", preferredStyle: .alert)
        alertPrompt.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Email"
        })
        
        let confirmAction = UIAlertAction(title: "Confirm", style: UIAlertAction.Style.default, handler: { (action) -> Void in
            let email = alertPrompt.textFields?.first?.text
            if email!.isEmpty {
                Alert.showBasic(title: "Hey, first enter email please", msg: "Not possible to continue with your request", vc: self)
            }else{
                Auth.auth().sendPasswordReset(withEmail: email!) { (error) in
                    if error != nil {
                        Alert.showBasic(title: "Email not exist or no connection", msg: "Please check your input and connection", vc: self)
                    }else{
                        Alert.showBasic(title: "Email was sended", msg: "Please check you mailbox", vc: self)
                    }
                }
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        
        alertPrompt.addAction(confirmAction)
        alertPrompt.addAction(cancelAction)
        
        present(alertPrompt, animated: true, completion: nil)
    }
    
    public func handleLogin (){
        do {
            try login()
        }catch LoginRegisterErrors.incompleteForm {
            Alert.showBasic(title: "Both fields are empty", msg: "Please first enter login and password", vc: self)
        }catch LoginRegisterErrors.invalidEmail {
            Alert.showBasic(title: "Email is not valid", msg: "Please check your email", vc: self)
        }catch LoginRegisterErrors.incorrectPasswordLength {
            Alert.showBasic(title: "Password is too short", msg: "Please check your password", vc: self)
        }catch{
            Alert.showBasic(title: "Unknown error", msg: "Please check your input", vc: self)
        }
    }
    
    fileprivate func login() throws {
        
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        if email.isEmpty && password.isEmpty {
            throw LoginRegisterErrors.incompleteForm
        }
        
        if !email.isValidEmail {
            throw LoginRegisterErrors.invalidEmail
        }
        
        if password.count < 6 {
            throw LoginRegisterErrors.incorrectPasswordLength
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                Alert.showBasic(title: "Please check your input", msg: "Username or password is incorrect", vc: self)
                self.view.endEditing(true)
                return
            }
            
            let docRef = self.db.collection("users").document(email)
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataDescription = document.data()
                    let user = UserModel(dictionary: dataDescription!)
                    self.mainController?.setupNavBarWithUser(user: user!)
                        self.dismiss(animated: true, completion: nil)
                } else {
                    Alert.showBasic(title: "User not exist in our system", msg: "Please first you need to register your account", vc: self)
                }
            }
        }
        
    }
    
    @objc public func handleRegister(){
        do {
            try register()
        }catch LoginRegisterErrors.incompleteForm {
            Alert.showBasic(title: "Fields are empty", msg: "Please first enter name,login and password", vc: self)
        }catch LoginRegisterErrors.invalidEmail {
            Alert.showBasic(title: "Email is not valid", msg: "Please check your email", vc: self)
        }catch LoginRegisterErrors.nameIsEmpty {
            Alert.showBasic(title: "Name is empty", msg: "Please check your name", vc: self)
        }catch LoginRegisterErrors.incorrectPasswordLength {
            Alert.showBasic(title: "Password is too short", msg: "Please check your password", vc: self)
        }catch{
            Alert.showBasic(title: "Unknown error", msg: "Please check your input", vc: self)
        }
    }
    
    @objc public func register() throws {
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        guard let name = nameTextField.text else {return}
        let userId = Int.random(in: 1..<10000)
        if email.isEmpty && password.isEmpty && name.isEmpty {
            throw LoginRegisterErrors.incompleteForm
        }
        
        if name.isEmpty {
            throw LoginRegisterErrors.nameIsEmpty
        }
        
        if !email.isValidEmail {
            throw LoginRegisterErrors.invalidEmail
        }
        
        if password.count < 6 {
            throw LoginRegisterErrors.incorrectPasswordLength
        }
        
        
        
        Auth.auth().createUser(withEmail: email, password: password) {(user , error ) in
            if error != nil{
                Alert.showBasic(title: "Incorrect input", msg: "User already exist or there is no connection with network", vc: self)
                return
            }
            let newUser = UserModel(id: userId, name: name, email: email,created: self.getTodayDate())
            let userRef = self.db.collection("users")
            userRef.document(String(newUser.email)).setData(newUser.dictionary){ err in
                if err != nil {
                    Alert.showBasic(title: "User was not added", msg: "Failed.Please check connection.", vc: self)
                } else {
                    let values = ["id": newUser.id,
                                  "name": newUser.name,
                                  "email": newUser.email,
                                  "created": newUser.created] as [String : AnyObject]
                    self.saveInDb(userId: String(userId), values: values)
                    self.mainController?.setupNavBarWithUser(user: newUser)
                    self.dismiss(animated: true, completion: nil)
                    self.emailTextField.text = ""
                    self.passwordTextField.text = ""
                    self.nameTextField.text = ""
                    self.view.endEditing(true)
                }
            }
        }
    }
    
    private func saveInDb(userId: String, values: [String: AnyObject]) {
        let ref = Database.database().reference()
        let ordersReference = ref.child("users").child(userId)
        ordersReference.updateChildValues(values, withCompletionBlock: {(err, ref) in
            if err != nil {
                Alert.showBasic(title: "Network error", msg: "Please check your connection", vc: self)
                return
            }
        })
    }
    
    fileprivate func getTodayDate()  -> String {
        let today = Calendar.current.date(byAdding: .day, value: 0, to: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: today!)
        return date
    }
    
    @objc public func handleLoginregister(){
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            handleLogin()
        }else {
            handleRegister()
        }
    }
    
    @objc public func handlePrivacy(){
        guard let url = URL(string: "https://www.freeprivacypolicy.com/privacy/view/99f7e8abfea072cad8b118c6032bb64e") else {
            return
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
