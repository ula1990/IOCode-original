//
//  AboutVC.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 8/2/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {
    
    let mainView = ShadowView()
    let titleLabel = MainTitleLabel(text: "Developed by monkey for developers.", size: 17, textAligment: .center)
    let mainImage = MainImageView(imageName: "monkey")
    let hintLabel = MainLabel(text: "In order if you want to help us to improve our application you can contact with us in the next ways:", size: 15, textAligment: .center)
    let patreonButton = ActionButton(url: "https://www.patreon.com/ula", image: "patreon")
    let slackButton = ActionButton(url: "https://iosdeveloperula.slack.com/", image: "slack")
    let twitterButton = ActionButton(url: "https://twitter.com/daratsiuk", image: "twitter")
    
    fileprivate func setupNavBar(){
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.title = "About"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont(name: "Chalkduster", size: 30) ?? UIFont.systemFont(ofSize: 30)]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black,.font: UIFont(name: "Chalkduster", size: 20) ?? UIFont.systemFont(ofSize: 20)]
        navigationItem.leftBarButtonItem?.tintColor = UIColor.darkGray
        navigationItem.rightBarButtonItem?.tintColor = UIColor.darkGray
        navigationController?.navigationBar.tintColor = .black
    }
    
    fileprivate func setupView(){
        view.addSubview(mainView)
        mainView.addSubview(titleLabel)
        mainView.addSubview(mainImage)
        mainView.addSubview(hintLabel)
        mainView.addSubview(patreonButton)
        mainView.addSubview(slackButton)
        mainView.addSubview(twitterButton)
        
        NSLayoutConstraint.activate([
        
        mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        mainView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
        mainView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
        mainView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20 ),
        mainView.heightAnchor.constraint(equalToConstant: 350),
            
        titleLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
        titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 20),
        titleLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 40),
        titleLabel.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -40 ),
        titleLabel.heightAnchor.constraint(equalToConstant: 40),
        
        mainImage.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
        mainImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
        mainImage.widthAnchor.constraint(equalToConstant: 100),
        mainImage.heightAnchor.constraint(equalToConstant: 100),
        
        hintLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
        hintLabel.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: 20),
        hintLabel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 20),
        hintLabel.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -20 ),
        hintLabel.heightAnchor.constraint(equalToConstant: 60),
        
        patreonButton.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
        patreonButton.topAnchor.constraint(equalTo: hintLabel.bottomAnchor, constant: 20),
        patreonButton.widthAnchor.constraint(equalToConstant: 40),
        patreonButton.heightAnchor.constraint(equalToConstant: 40),
        
        slackButton.rightAnchor.constraint(equalTo: patreonButton.leftAnchor, constant: -20),
        slackButton.topAnchor.constraint(equalTo: hintLabel.bottomAnchor, constant: 20),
        slackButton.widthAnchor.constraint(equalToConstant: 40),
        slackButton.heightAnchor.constraint(equalToConstant: 40),
        
        twitterButton.leftAnchor.constraint(equalTo: patreonButton.rightAnchor, constant: 20),
        twitterButton.topAnchor.constraint(equalTo: hintLabel.bottomAnchor, constant: 20),
        twitterButton.widthAnchor.constraint(equalToConstant: 40),
        twitterButton.heightAnchor.constraint(equalToConstant: 40),
        
        
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavBar()
        setupView()
    }

}
