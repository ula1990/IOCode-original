//
//  AddNewsVC.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 10/10/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit
import Firebase

class AddNewsVC: UIViewController {

    let mainView = ShadowView()
    let titleLabel = MainLabel(text: "Send interesting news", size: 18, textAligment: .center)
    let titleField = NewsTextField(placeHolderText: "News title", isSecure: false)
    let descriptionField = NewsTextField(placeHolderText: "Description info", isSecure: false)
    let urlField = NewsTextField(placeHolderText: "Original Url", isSecure: false)
    let imageUrlField = NewsTextField(placeHolderText: "Image Url", isSecure: false)
    let contentField = NewsTextField(placeHolderText: "Content", isSecure: false)
    var db: Firestore!
    
    lazy var sendArticleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(sendArticle), for: .touchUpInside)
        button.contentMode = .scaleAspectFit
        button.setImage(UIImage(named: "sendNews"), for: .normal)
        button.tintColor = UIColor(named: "tabBarColor")
        return button
    }()
    
    fileprivate func toolBarSetup() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.finishedWithInput))
        doneButton.tintColor = .black
        toolBar.setItems([flexibleSpace, doneButton], animated: true)
        contentField.inputAccessoryView = toolBar
    }
    
    fileprivate func setupView(){
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        view.addSubview(mainView)
        mainView.addSubview(titleLabel)
        mainView.addSubview(titleField)
        mainView.addSubview(descriptionField)
        mainView.addSubview(urlField)
        mainView.addSubview(imageUrlField)
        mainView.addSubview(contentField)
        mainView.addSubview(sendArticleButton)
        titleField.delegate = self
        descriptionField.delegate = self
        urlField.delegate = self
        imageUrlField.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        view.addGestureRecognizer(tap)
        
        NSLayoutConstraint.activate([
        
        mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        mainView.heightAnchor.constraint(equalToConstant: 360),
        mainView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
        mainView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
        
        titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10),
        titleLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 20),
        titleLabel.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -20),
        titleLabel.heightAnchor.constraint(equalToConstant: 30),
        titleLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
        
        titleField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
        titleField.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 20),
        titleField.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -20),
        titleField.heightAnchor.constraint(equalToConstant: 40),
        titleField.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
        
        descriptionField.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 10),
        descriptionField.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 20),
        descriptionField.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -20),
        descriptionField.heightAnchor.constraint(equalToConstant: 40),
        descriptionField.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
        
        urlField.topAnchor.constraint(equalTo: descriptionField.bottomAnchor, constant: 10),
        urlField.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 20),
        urlField.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -20),
        urlField.heightAnchor.constraint(equalToConstant: 40),
        urlField.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
        
        imageUrlField.topAnchor.constraint(equalTo: urlField.bottomAnchor, constant: 10),
        imageUrlField.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 20),
        imageUrlField.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -20),
        imageUrlField.heightAnchor.constraint(equalToConstant: 40),
        imageUrlField.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
        
        contentField.topAnchor.constraint(equalTo: imageUrlField.bottomAnchor, constant: 10),
        contentField.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 20),
        contentField.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -20),
        contentField.heightAnchor.constraint(equalToConstant: 40),
        contentField.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),

        sendArticleButton.topAnchor.constraint(equalTo: contentField.bottomAnchor, constant: 20),
        sendArticleButton.widthAnchor.constraint(equalToConstant: 40),
        sendArticleButton.heightAnchor.constraint(equalToConstant: 40),
        sendArticleButton.centerXAnchor.constraint(equalTo: mainView.centerXAnchor)
        
        ])
    }
    
    fileprivate func setupNavBar(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        setupView()
        setupNavBar()
        toolBarSetup()
        contentField.delegate = self
    }

}
