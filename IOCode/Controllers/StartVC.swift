//
//  StartVC.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 2018-08-01.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit
import AVKit
import Firebase
import Lottie

class StartVC: UIViewController {
    
    let kVersion        = "CFBundleShortVersionString"
    let kBuildNumber    = "CFBundleVersion"

    var inputsContainerViewHightAnchor: NSLayoutConstraint?
    var nameTextFieldHidthAnchor: NSLayoutConstraint?
    var emailTextFieldHightAnchor: NSLayoutConstraint?
    var passwordTextFieldHigthAnchor: NSLayoutConstraint?
    var nameSeperatorHeightAnchor: NSLayoutConstraint?
    var nameImageHeightAnchor: NSLayoutConstraint?
    var mainController: MainVC?
    var db: Firestore!

    lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: "Chalkduster", size: 50)
        label.textAlignment = .center
        label.text = "IOCode"
        label.shadowColor = UIColor.white.withAlphaComponent(0.5)
        label.layer.shadowColor = UIColor.white.cgColor
        label.layer.shadowRadius = 1
        label.layer.shadowOpacity = 0.1
        return label
    }()
    
    let inputsContainerView: UIView  = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var  loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor =  UIColor.white.withAlphaComponent(0)
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleLoginregister), for: .touchUpInside)
        button.layer.cornerRadius = 5
        return button
        
    }()
    
    let nameTextField = MainTextField(placeHolderText: "Name", isSecure: false)
    let nameImage = LoginFieldsImage(imageName: "nameIcon")
    let nameSeparatorView = MainSeperatorView()
    let emailTextField = MainTextField(placeHolderText: "Email", isSecure: false)
    let emailImage = LoginFieldsImage(imageName: "emailIcon")
    let emailSeparatorView = MainSeperatorView()
    let passwordTextField = MainTextField(placeHolderText: "Password", isSecure: true)
    let passwordImage = LoginFieldsImage(imageName: "passwordIcon")
    
    lazy var loginRegisterSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login", "Register"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor.darkGray
        sc.selectedSegmentIndex = 1
        sc.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        return sc
    }()
    
    lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Forgot password?", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(handleForgotPassword), for: .touchUpInside)
        return button
    }()
    
    lazy var mainIcon: LOTAnimationView = {
        let view = LOTAnimationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setAnimation(named: "personal_character")
        view.loopAnimation = true
        view.play()
        return view
    }()

    lazy var privacyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(handlePrivacy), for: .touchUpInside)
        return button
    }()
    
    let versionLabel = MainLabel(text: "", size: 11, textAligment: .center)
    
    fileprivate func setupView(){
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(loginRegisterSegmentedControl)
        view.addSubview(inputsContainerView)
        view.addSubview(nameImage)
        view.addSubview(emailImage)
        view.addSubview(passwordImage)
        view.addSubview(loginRegisterButton)
        view.addSubview(forgotPasswordButton)
        view.addSubview(privacyButton)
        view.addSubview(versionLabel)
        view.addSubview(mainIcon)
        versionLabel.text = getVersion()

        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: loginRegisterSegmentedControl.topAnchor, constant: -5).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        
        loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterSegmentedControl.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
        loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor, constant: 20).isActive = true
        loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -80).isActive = true
        inputsContainerViewHightAnchor = inputsContainerView.heightAnchor.constraint(equalToConstant: 120)
        inputsContainerViewHightAnchor?.isActive = true
        
        inputsContainerView.addSubview(nameTextField)
        inputsContainerView.addSubview(nameSeparatorView)
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(emailSeparatorView)
        inputsContainerView.addSubview(passwordTextField)
        nameTextField.delegate = self
        emailTextField.delegate = self
        emailTextField.autocapitalizationType = .none
        passwordTextField.delegate = self

        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameTextFieldHidthAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        nameTextFieldHidthAnchor?.isActive = true
        
        nameImage.centerYAnchor.constraint(equalTo: nameTextField.centerYAnchor).isActive = true
        nameImage.rightAnchor.constraint(equalTo: nameTextField.leftAnchor, constant: -5).isActive = true
        nameImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        nameImageHeightAnchor = nameImage.heightAnchor.constraint(equalToConstant: 20)
        nameImageHeightAnchor?.isActive = true
        
        nameSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        nameSeparatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameSeperatorHeightAnchor = nameSeparatorView.heightAnchor.constraint(equalToConstant: 0.5)
        nameSeperatorHeightAnchor?.isActive = true
        
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailTextFieldHightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        emailTextFieldHightAnchor?.isActive = true
        
        emailImage.centerYAnchor.constraint(equalTo: emailTextField.centerYAnchor).isActive = true
        emailImage.rightAnchor.constraint(equalTo: emailTextField.leftAnchor, constant: -5).isActive = true
        emailImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        emailImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordTextFieldHigthAnchor =  passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        passwordTextFieldHigthAnchor?.isActive = true
        
        passwordImage.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor).isActive = true
        passwordImage.rightAnchor.constraint(equalTo: passwordTextField.leftAnchor, constant: -5).isActive = true
        passwordImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        passwordImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        forgotPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        forgotPasswordButton.topAnchor.constraint(equalTo: loginRegisterButton.bottomAnchor, constant: 5).isActive = true
        forgotPasswordButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        forgotPasswordButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        mainIcon.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 20).isActive = true
        mainIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainIcon.heightAnchor.constraint(equalToConstant: 150).isActive = true
        mainIcon.widthAnchor.constraint(equalToConstant: 150).isActive = true

        privacyButton.heightAnchor.constraint(equalToConstant: 15).isActive = true
        privacyButton.bottomAnchor.constraint(equalTo: versionLabel.topAnchor, constant: -10).isActive = true
        privacyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        privacyButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        privacyButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        versionLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        versionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        versionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        versionLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        versionLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
    }
    
    fileprivate func setupNavBar(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupView()
        db = Firestore.firestore()
    }
    
    @objc func handleLoginRegisterChange(){
        let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, for: .normal )
        
        inputsContainerViewHightAnchor?.constant = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 80 : 120
        
        nameTextFieldHidthAnchor?.isActive = false
        nameTextFieldHidthAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0 : 1/3 )
        nameTextFieldHidthAnchor?.isActive = true
        
        nameSeperatorHeightAnchor?.isActive = false
        nameSeperatorHeightAnchor = nameSeparatorView.heightAnchor.constraint(equalTo: emailSeparatorView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0 : 1 )
        nameSeperatorHeightAnchor?.isActive = true
        
        nameImageHeightAnchor?.isActive = false
        nameImageHeightAnchor = nameImage.heightAnchor.constraint(equalTo: emailImage.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0 : 1 )
        nameImageHeightAnchor?.isActive = true
        
        emailTextFieldHightAnchor?.isActive = false
        emailTextFieldHightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3 )
        emailTextFieldHightAnchor?.isActive = true
        
        passwordTextFieldHigthAnchor?.isActive = false
        passwordTextFieldHigthAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3 )
        passwordTextFieldHigthAnchor?.isActive = true
        
        view.endEditing(true)
    }

}
