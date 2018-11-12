//
//  MainVC.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 2018-08-01.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit
import AVKit
import Firebase
import Lottie

var currentUser: UserModel?

class MainVC: UIViewController {
    
    var db: Firestore!
    
    lazy var mainScrollView: UIScrollView = {
       let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentSize.height = 700
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let mainView = ShadowView()
    
    lazy var ownerImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "owner")
        image.layer.cornerRadius = 30
        image.clipsToBounds = true
        image.layer.shadowColor = UIColor.black.cgColor
        image.layer.shadowOpacity = 0.2
        image.layer.shadowRadius = 5
        return image
    }()

    let secondView = ShadowView()
    
    lazy var greatingLabel = MainLabel(text: "In our community you can start developing your own apps already today on iOS platform", size: 14, textAligment: .left)
    lazy var mainProcessLabel = MainTitleLabel(text: "How looks a whole process?", size: 14, textAligment: .left)
    
    lazy var findDateLabel = MainLabel(text: "• Find a right date to start,that's today ", size: 14, textAligment: .left)
    lazy var emailLabel = MainLabel(text: "• Download Xcode from the App Store", size: 14, textAligment: .left)
    lazy var confrimationEmailLabel = MainLabel(text: "• Watch couple our tutorials", size: 14, textAligment: .left)
    lazy var paymentLabel = MainLabel(text: "• Start developing your own Apps", size: 14, textAligment: .left)
    lazy var readyToLearnLabel = MainLabel(text: "• You are ready to be an iOS Developer", size: 14, textAligment: .left)
    
    lazy var firstStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [findDateLabel,emailLabel,confrimationEmailLabel,paymentLabel,readyToLearnLabel])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 2
        sv.distribution = .fillEqually
        sv.backgroundColor = UIColor.white
        sv.layer.cornerRadius = 7.5
        sv.clipsToBounds = true
        return sv
    }()
    
    lazy var codeIcon: LOTAnimationView = {
        let view = LOTAnimationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setAnimation(named: "browser")
        view.loopAnimation = true
        view.play()
        return view
    }()
    lazy var challengeLabel = MainLabel(text: "Main challenge for us to give overview of main topics, which can be important for you like a future iOS Developer ", size: 14, textAligment: .left)
    lazy var topicLabel = MainTitleLabel(text: "Main topics:", size: 14, textAligment: .left)
    
    lazy var firstCourseLabel = MainLabel(text: "• Basics of the Swift ", size: 14, textAligment: .left)
    lazy var secondCourseLabel = MainLabel(text: "• UI Elements programmatically", size: 14, textAligment: .left)
    lazy var thirdCourseLabel = MainLabel(text: "• Work with Github", size: 14, textAligment: .left)
    lazy var fourthCourseLabel = MainLabel(text: "• Integration of the API in projects(JSON)", size: 14, textAligment: .left)
    lazy var fifthCourseLabel = MainLabel(text: "• Simple backend based on Firebase, Firestore", size: 14, textAligment: .left)
    lazy var sixthCourseLabel = MainLabel(text: "• Release of the app in App store", size: 14, textAligment: .left)
    
    lazy var secondStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [firstCourseLabel,secondCourseLabel,thirdCourseLabel,fourthCourseLabel,fifthCourseLabel,sixthCourseLabel])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 2
        sv.distribution = .fillEqually
        sv.backgroundColor = UIColor.white
        sv.layer.cornerRadius = 7.5
        sv.clipsToBounds = true
        return sv
    }()
    
    fileprivate func setupNavBar(){
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.title = "Hi,there!"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont(name: "Chalkduster", size: 30) ?? UIFont.systemFont(ofSize: 30)]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black,.font: UIFont(name: "Chalkduster", size: 20) ?? UIFont.systemFont(ofSize: 20)]
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"logout"), style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"profileCard"), style: .plain, target: self, action: #selector(handleProfile))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.darkGray
        navigationItem.rightBarButtonItem?.tintColor = UIColor.darkGray
        
    }
    
    fileprivate func setupView(){
        view.backgroundColor = .white
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(mainView)
        mainView.addSubview(ownerImage)
        mainView.addSubview(greatingLabel)
        mainView.addSubview(mainProcessLabel)
        mainView.addSubview(firstStackView)
        mainView.addSubview(codeIcon)
        mainView.addSubview(challengeLabel)
        mainView.addSubview(topicLabel)
        mainView.addSubview(secondStackView)
        
        NSLayoutConstraint.activate([

        mainScrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        mainScrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        mainScrollView.topAnchor.constraint(equalTo: view.topAnchor),
        mainScrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
        mainScrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
        mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

        mainView.topAnchor.constraint(equalTo: mainScrollView.topAnchor, constant: 20),
        mainView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
        mainView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
        mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        mainView.heightAnchor.constraint(equalToConstant: 620),
        
        ownerImage.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 20),
        ownerImage.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 20),
        ownerImage.heightAnchor.constraint(equalToConstant: 60),
        ownerImage.widthAnchor.constraint(equalToConstant: 60),
        
        greatingLabel.centerYAnchor.constraint(equalTo: ownerImage.centerYAnchor),
        greatingLabel.leftAnchor.constraint(equalTo: ownerImage.rightAnchor, constant: 20),
        greatingLabel.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -20),
        greatingLabel.heightAnchor.constraint(equalToConstant: 100),
        
        mainProcessLabel.topAnchor.constraint(equalTo: greatingLabel.bottomAnchor, constant: 10),
        mainProcessLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 20),
        mainProcessLabel.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -20),
        mainProcessLabel.heightAnchor.constraint(equalToConstant: 20),
        
        firstStackView.topAnchor.constraint(equalTo: mainProcessLabel.bottomAnchor, constant: 10),
        firstStackView.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 20),
        firstStackView.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -20),
        firstStackView.heightAnchor.constraint(equalToConstant: 150),
        
        codeIcon.topAnchor.constraint(equalTo: firstStackView.bottomAnchor, constant: 20),
        codeIcon.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 20),
        codeIcon.heightAnchor.constraint(equalToConstant: 60),
        codeIcon.widthAnchor.constraint(equalToConstant: 60),
        
        challengeLabel.centerYAnchor.constraint(equalTo: codeIcon.centerYAnchor),
        challengeLabel.leftAnchor.constraint(equalTo: codeIcon.rightAnchor, constant: 20),
        challengeLabel.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -20),
        challengeLabel.heightAnchor.constraint(equalToConstant: 100),
        
        topicLabel.topAnchor.constraint(equalTo: challengeLabel.bottomAnchor, constant: 10),
        topicLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 20),
        topicLabel.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -20),
        topicLabel.heightAnchor.constraint(equalToConstant: 20),
        
        secondStackView.topAnchor.constraint(equalTo: topicLabel.bottomAnchor, constant: 10),
        secondStackView.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 20),
        secondStackView.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -20),
        secondStackView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -20),
        
        ])

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        setupNavBar()
        setupView()
        checkIfUserIsLoggedIn()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkIfUserIsLoggedIn()
    }

}
