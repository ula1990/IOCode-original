//
//  MainVCExtension.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 8/2/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit
import MessageUI
import Firebase

extension MainVC {
    @objc public func checkIfUserIsLoggedIn(){
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }else{
            fetchUserAndSetupNavBarTitle()
        }
    }
    
    @objc public func handleLogout(){
        do {
            try Auth.auth().signOut()
        }catch let logoutError {
            print(logoutError)
        }
        let loginControlller = StartVC()
        present(loginControlller, animated: true, completion: nil)
    }
    
    func setupNavBarWithUser(user: UserModel){
        self.navigationItem.title = "Hi,\(user.name)"
        fetchUserAndSetupNavBarTitle()
    }
    
    @objc public func handleProfile(){
        let vc = ProfileVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc public func fetchUserAndSetupNavBarTitle(){
        guard let email = Auth.auth().currentUser?.email else {
            return
        }
        let docRef = self.db.collection("users").document(email)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()
                let user = UserModel(dictionary: dataDescription!)
                currentUser = user
                self.navigationItem.title = "Hi,\(user?.name ?? "there")"
            }else{
                self.fetchUserAndSetupNavBarTitle()
            }
        }
    }
}
