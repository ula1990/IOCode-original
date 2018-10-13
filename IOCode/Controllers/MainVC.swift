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

class MainVC: UIViewController {
    
    var db: Firestore!
    
    lazy var mainScrollView: UIScrollView = {
       let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentSize.height = 700
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let firstView = ShadowView()
    
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
    
    lazy var demoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "iphoneTemplate")
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.layer.shadowRadius = 10
        image.layer.shadowOpacity = 0.2
        image.backgroundColor = UIColor.white.withAlphaComponent(0)
        return image
    }()

    let secondView = ShadowView()
    
    lazy var greatingLabel = MainLabel(text: "In our community you can learn more about development process on Apple platform and start developing your own apps already today", size: 15, textAligment: .left)
    lazy var mainProcessLabel = MainTitleLabel(text: "How looks a whole process?", size: 15, textAligment: .left)
    lazy var findDateLabel = MainLabel(text: "• Find a right date to start,that's today ", size: 14, textAligment: .left)
    lazy var emailLabel = MainLabel(text: "• Download Xcode from the App Store", size: 14, textAligment: .left)
    lazy var confrimationEmailLabel = MainLabel(text: "• Watch couple our tutorials", size: 14, textAligment: .left)
    lazy var paymentLabel = MainLabel(text: "• Start developing your own Apps", size: 14, textAligment: .left)
    lazy var readyToLearnLabel = MainLabel(text: "• You are ready to be an iOS Developer", size: 14, textAligment: .left)
    
    lazy var firstCourseLabel = MainTitleLabel(text: "• Swift Basics", size: 15, textAligment: .left)
    lazy var secondCourseLabel = MainTitleLabel(text: "• Programmatic elements", size: 15, textAligment: .left)
    lazy var thirdCourseLabel = MainTitleLabel(text: "• Work with Github", size: 15, textAligment: .left)
    lazy var fourthCourseLabel = MainTitleLabel(text: "• API Integration", size: 15, textAligment: .left)
    lazy var fifthCourseLabel = MainTitleLabel(text: "• Firebase backend", size: 15, textAligment: .left)
    lazy var sixthCourseLabel = MainTitleLabel(text: "• Release in the App store", size: 15, textAligment: .left)
    lazy var tipsLabel = MainLabel(text: "And much more interesting topics you can find in our application for the community and on youtube channel", size: 14, textAligment: .left)
    
    fileprivate func setupNavBar(){
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.title = "Hi,there!"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont(name: "AppleSDGothicNeo-Regular", size: 30) ?? UIFont.systemFont(ofSize: 30)]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black,.font: UIFont(name: "AppleSDGothicNeo-Regular", size: 20) ?? UIFont.systemFont(ofSize: 20)]
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"logout"), style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"share"), style: .plain, target: self, action: #selector(handleShare))
        navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "tabBarColor")
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "tabBarColor")
        
    }
    
    fileprivate func setupView(){
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(firstView)
        firstView.addSubview(ownerImage)
        firstView.addSubview(greatingLabel)
        firstView.addSubview(mainProcessLabel)
        firstView.addSubview(findDateLabel)
        firstView.addSubview(emailLabel)
        firstView.addSubview(confrimationEmailLabel)
        firstView.addSubview(paymentLabel)
        firstView.addSubview(readyToLearnLabel)
        mainScrollView.addSubview(secondView)
        secondView.addSubview(demoImage)
        secondView.addSubview(firstCourseLabel)
        secondView.addSubview(secondCourseLabel)
        secondView.addSubview(thirdCourseLabel)
        secondView.addSubview(fourthCourseLabel)
        secondView.addSubview(fifthCourseLabel)
        secondView.addSubview(sixthCourseLabel)
        secondView.addSubview(tipsLabel)

        mainScrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainScrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        mainScrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mainScrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mainScrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        firstView.topAnchor.constraint(equalTo: mainScrollView.topAnchor, constant: 20).isActive = true
        firstView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        firstView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        firstView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        firstView.heightAnchor.constraint(equalToConstant: 280).isActive = true
        
        ownerImage.topAnchor.constraint(equalTo: firstView.topAnchor, constant: 20).isActive = true
        ownerImage.leftAnchor.constraint(equalTo: firstView.leftAnchor, constant: 20).isActive = true
        ownerImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
        ownerImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        greatingLabel.centerYAnchor.constraint(equalTo: ownerImage.centerYAnchor).isActive = true
        greatingLabel.leftAnchor.constraint(equalTo: ownerImage.rightAnchor, constant: 20).isActive = true
        greatingLabel.rightAnchor.constraint(equalTo: firstView.rightAnchor, constant: -20).isActive = true
        greatingLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        mainProcessLabel.topAnchor.constraint(equalTo: greatingLabel.bottomAnchor, constant: 10).isActive = true
        mainProcessLabel.leftAnchor.constraint(equalTo: firstView.leftAnchor, constant: 20).isActive = true
        mainProcessLabel.rightAnchor.constraint(equalTo: firstView.rightAnchor, constant: -20).isActive = true
        mainProcessLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        findDateLabel.topAnchor.constraint(equalTo: mainProcessLabel.bottomAnchor, constant: 10).isActive = true
        findDateLabel.leftAnchor.constraint(equalTo: firstView.leftAnchor, constant: 30).isActive = true
        findDateLabel.rightAnchor.constraint(equalTo: firstView.rightAnchor, constant: -20).isActive = true
        findDateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        emailLabel.topAnchor.constraint(equalTo: findDateLabel.bottomAnchor, constant: 5).isActive = true
        emailLabel.leftAnchor.constraint(equalTo: firstView.leftAnchor, constant: 30).isActive = true
        emailLabel.rightAnchor.constraint(equalTo: firstView.rightAnchor, constant: -20).isActive = true
        emailLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        confrimationEmailLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 5).isActive = true
        confrimationEmailLabel.leftAnchor.constraint(equalTo: firstView.leftAnchor, constant: 30).isActive = true
        confrimationEmailLabel.rightAnchor.constraint(equalTo: firstView.rightAnchor, constant: -20).isActive = true
        confrimationEmailLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        paymentLabel.topAnchor.constraint(equalTo: confrimationEmailLabel.bottomAnchor, constant: 5).isActive = true
        paymentLabel.leftAnchor.constraint(equalTo: firstView.leftAnchor, constant: 30).isActive = true
        paymentLabel.rightAnchor.constraint(equalTo: firstView.rightAnchor, constant: -20).isActive = true
        paymentLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        readyToLearnLabel.topAnchor.constraint(equalTo: paymentLabel.bottomAnchor, constant: 5).isActive = true
        readyToLearnLabel.leftAnchor.constraint(equalTo: firstView.leftAnchor, constant: 30).isActive = true
        readyToLearnLabel.rightAnchor.constraint(equalTo: firstView.rightAnchor, constant: -20).isActive = true
        readyToLearnLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        secondView.topAnchor.constraint(equalTo: firstView.bottomAnchor, constant: 20).isActive = true
        secondView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        secondView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        secondView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        secondView.heightAnchor.constraint(equalToConstant: 350).isActive = true
        
        demoImage.topAnchor.constraint(equalTo: secondView.topAnchor, constant: 20).isActive = true
        demoImage.leftAnchor.constraint(equalTo: secondView.leftAnchor, constant: 10).isActive = true
        demoImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        demoImage.heightAnchor.constraint(equalToConstant: 260).isActive = true
        
        firstCourseLabel.topAnchor.constraint(equalTo: demoImage.topAnchor, constant: 30).isActive = true
        firstCourseLabel.leftAnchor.constraint(equalTo: secondView.centerXAnchor).isActive = true
        firstCourseLabel.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -10).isActive = true
        firstCourseLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        secondCourseLabel.topAnchor.constraint(equalTo: firstCourseLabel.bottomAnchor, constant: 10).isActive = true
        secondCourseLabel.leftAnchor.constraint(equalTo: secondView.centerXAnchor).isActive = true
        secondCourseLabel.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -10).isActive = true
        secondCourseLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        thirdCourseLabel.topAnchor.constraint(equalTo: secondCourseLabel.bottomAnchor, constant: 10).isActive = true
        thirdCourseLabel.leftAnchor.constraint(equalTo: secondView.centerXAnchor).isActive = true
        thirdCourseLabel.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -10).isActive = true
        thirdCourseLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        fourthCourseLabel.topAnchor.constraint(equalTo: thirdCourseLabel.bottomAnchor, constant: 10).isActive = true
        fourthCourseLabel.leftAnchor.constraint(equalTo: secondView.centerXAnchor).isActive = true
        fourthCourseLabel.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -10).isActive = true
        fourthCourseLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        fifthCourseLabel.topAnchor.constraint(equalTo: fourthCourseLabel.bottomAnchor, constant: 10).isActive = true
        fifthCourseLabel.leftAnchor.constraint(equalTo: secondView.centerXAnchor).isActive = true
        fifthCourseLabel.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -10).isActive = true
        fifthCourseLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        sixthCourseLabel.topAnchor.constraint(equalTo: fifthCourseLabel.bottomAnchor, constant: 10).isActive = true
        sixthCourseLabel.leftAnchor.constraint(equalTo: secondView.centerXAnchor).isActive = true
        sixthCourseLabel.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -10).isActive = true
        sixthCourseLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        tipsLabel.topAnchor.constraint(equalTo: demoImage.bottomAnchor, constant: 10).isActive = true
        tipsLabel.leftAnchor.constraint(equalTo: secondView.leftAnchor, constant: 20).isActive = true
        tipsLabel.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -20).isActive = true
        tipsLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        setupNavBar()
        setupView()
        view.backgroundColor = .white
        checkIfUserIsLoggedIn()
        
    }

}
