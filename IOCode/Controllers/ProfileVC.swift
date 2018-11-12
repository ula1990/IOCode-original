//
//  ProfileVC.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 11/12/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit
import Lottie
import Firebase

class ProfileVC: UIViewController {
    
    var receivedUser: UserModel?
    var db: Firestore!
    
    lazy var mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize.height = 600
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    lazy var mainIcon: LOTAnimationView = {
        let view = LOTAnimationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setAnimation(named: "personal_character")
        view.loopAnimation = true
        view.play()
        return view
    }()
    
    lazy var nameField: UITextField = {
       let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = UIFont(name: "Chalkduster", size: 30)
        tf.textAlignment = .center
        tf.textColor = .black
        tf.text = "Johne Dow"
        return tf
    }()
    
    lazy var oldPasswordField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = UIFont(name: "Chalkduster", size: 30)
        tf.textAlignment = .center
        tf.textColor = .black
        tf.placeholder = "Old password"
        tf.isSecureTextEntry = true
        tf.returnKeyType = .done
        return tf
    }()
    
    lazy var newPasswordField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = UIFont(name: "Chalkduster", size: 30)
        tf.textAlignment = .center
        tf.textColor = .black
        tf.placeholder = "New password"
        tf.isSecureTextEntry = true
        tf.returnKeyType = .done
        return tf
    }()
    
    lazy var updatePasswordButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Update Password", for: .normal)
        button.titleLabel?.font = UIFont(name: "Chalkduster", size: 30)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(handleUpdate), for: .touchUpInside)
        return button
    }()
    
    lazy var removeAccountButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Remove account", for: .normal)
        button.titleLabel?.font = UIFont(name: "Chalkduster", size: 30)
        button.setTitleColor(UIColor.red, for: .normal)
        button.addTarget(self, action: #selector(removeAccount), for: .touchUpInside)
        return button
    }()
    
    fileprivate func setupNavBar(){
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.title = "Profile"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(named: "background")
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont(name: "Chalkduster", size: 35) ?? UIFont.systemFont(ofSize: 35)]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black,.font: UIFont(name: "Chalkduster", size: 20) ?? UIFont.systemFont(ofSize: 20)]
        navigationController?.navigationBar.tintColor = .darkGray
        
    }
    
    fileprivate func setupView(){
        view.backgroundColor = .white
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(mainIcon)
        mainScrollView.addSubview(nameField)
        mainScrollView.addSubview(oldPasswordField)
        mainScrollView.addSubview(newPasswordField)
        mainScrollView.addSubview(updatePasswordButton)
        mainScrollView.addSubview(removeAccountButton)
        
        newPasswordField.delegate = self
        oldPasswordField.delegate = self
        
        receivedUser = currentUser
        nameField.text = receivedUser?.name
        NSLayoutConstraint.activate([
            
            mainScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainScrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            mainScrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            mainScrollView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            mainIcon.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor),
            mainIcon.topAnchor.constraint(equalTo: mainScrollView.topAnchor, constant: 40),
            mainIcon.heightAnchor.constraint(equalToConstant: 150),
            mainIcon.widthAnchor.constraint(equalToConstant: 150),
            
            nameField.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor),
            nameField.topAnchor.constraint(equalTo: mainIcon.bottomAnchor, constant: 20),
            nameField.heightAnchor.constraint(equalToConstant: 40),
            nameField.leftAnchor.constraint(equalTo: view.leftAnchor),
            nameField.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            oldPasswordField.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor),
            oldPasswordField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 20),
            oldPasswordField.heightAnchor.constraint(equalToConstant: 40),
            oldPasswordField.leftAnchor.constraint(equalTo: view.leftAnchor),
            oldPasswordField.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            newPasswordField.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor),
            newPasswordField.topAnchor.constraint(equalTo: oldPasswordField.bottomAnchor, constant: 20),
            newPasswordField.heightAnchor.constraint(equalToConstant: 40),
            newPasswordField.leftAnchor.constraint(equalTo: view.leftAnchor),
            newPasswordField.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            updatePasswordButton.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor),
            updatePasswordButton.topAnchor.constraint(equalTo: newPasswordField.bottomAnchor, constant: 20),
            updatePasswordButton.heightAnchor.constraint(equalToConstant: 40),
            updatePasswordButton.leftAnchor.constraint(equalTo: view.leftAnchor),
            updatePasswordButton.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            removeAccountButton.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor),
            removeAccountButton.topAnchor.constraint(equalTo: updatePasswordButton.bottomAnchor, constant: 20),
            removeAccountButton.heightAnchor.constraint(equalToConstant: 40),
            removeAccountButton.leftAnchor.constraint(equalTo: view.leftAnchor),
            removeAccountButton.rightAnchor.constraint(equalTo: view.rightAnchor),
        
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupView()
        db = Firestore.firestore()
    }

}
