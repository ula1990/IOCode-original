//
//  CommunityCell.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 9/18/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class CommunityCell: UICollectionViewCell {
    
    var youtubeUrl: String?
    var patreonUrl: String?
    var webPageUrl: String?
    var instagramUrl: String?
    var twitterUrl: String?
    
    let shadowView = ShadowView()
    lazy var profileImage = MainImageView(imageName: "seanAllen")
    let youtubeButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.setBackgroundImage(UIImage(named: "youtube"), for: .normal)
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    let twitterButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.setBackgroundImage(UIImage(named: "twitter"), for: .normal)
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    let patreonButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.setBackgroundImage(UIImage(named: "patreon"), for: .normal)
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    let webpageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.setBackgroundImage(UIImage(named: "webpage"), for: .normal)
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    let instagramButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.setBackgroundImage(UIImage(named: "instagram"), for: .normal)
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    let profileTitleLabel = MainTitleLabel(text: "Sean Allen", size: 15, textAligment: .left)
    let profilePositionLabel = MainTitleLabel(text: "Youtuber & iOS Developer", size: 15, textAligment: .left)
    let profileDescText = MainTextView()
    
    fileprivate func setpView(){
        contentView.addSubview(shadowView)
        contentView.addSubview(youtubeButton)
        contentView.addSubview(twitterButton)
        contentView.addSubview(patreonButton)
        contentView.addSubview(webpageButton)
        contentView.addSubview(profileTitleLabel)
        contentView.addSubview(profilePositionLabel)
        contentView.addSubview(instagramButton)
        contentView.addSubview(profileDescText)
        shadowView.addSubview(profileImage)
        shadowView.layer.cornerRadius = 50
        profileImage.layer.cornerRadius = 50
        profileDescText.textAlignment = .left
        profileDescText.font = UIFont(name: "AppleSDGothicNeo-Light", size: 14)
        style(view: contentView)
        shadowView.topAnchor.constraint(equalTo: self.topAnchor,constant: 20).isActive = true
        shadowView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        shadowView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        shadowView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        

        profileImage.centerYAnchor.constraint(equalTo: shadowView.centerYAnchor).isActive = true
        profileImage.centerXAnchor.constraint(equalTo: shadowView.centerXAnchor).isActive = true
        profileImage.topAnchor.constraint(equalTo: shadowView.topAnchor).isActive = true
        profileImage.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor).isActive = true
        profileImage.leftAnchor.constraint(equalTo: shadowView.leftAnchor).isActive = true
        profileImage.rightAnchor.constraint(equalTo: shadowView.rightAnchor).isActive = true
        
        youtubeButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        youtubeButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        youtubeButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        youtubeButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        twitterButton.topAnchor.constraint(equalTo: youtubeButton.bottomAnchor, constant: 5).isActive = true
        twitterButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        twitterButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        twitterButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        patreonButton.bottomAnchor.constraint(equalTo: youtubeButton.topAnchor, constant: -5).isActive = true
        patreonButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        patreonButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        patreonButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        webpageButton.bottomAnchor.constraint(equalTo: patreonButton.topAnchor, constant: -5).isActive = true
        webpageButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        webpageButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        webpageButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        instagramButton.topAnchor.constraint(equalTo: twitterButton.bottomAnchor, constant: 5).isActive = true
        instagramButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        instagramButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        instagramButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        profileTitleLabel.topAnchor.constraint(equalTo: profileImage.topAnchor, constant: 0).isActive = true
        profileTitleLabel.leftAnchor.constraint(equalTo: shadowView.rightAnchor, constant: 10).isActive = true
        profileTitleLabel.rightAnchor.constraint(equalTo: instagramButton.leftAnchor, constant: -10).isActive = true
        profileTitleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        profilePositionLabel.topAnchor.constraint(equalTo: profileTitleLabel.bottomAnchor, constant: 5).isActive = true
        profilePositionLabel.leftAnchor.constraint(equalTo: shadowView.rightAnchor, constant: 10).isActive = true
        profilePositionLabel.rightAnchor.constraint(equalTo: instagramButton.leftAnchor, constant: -10).isActive = true
        profilePositionLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        profileDescText.topAnchor.constraint(equalTo: shadowView.bottomAnchor, constant: 15).isActive = true
        profileDescText.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        profileDescText.rightAnchor.constraint(equalTo: instagramButton.leftAnchor, constant: -10).isActive = true
        profileDescText.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateData(developer: Developer){
        profileImage.image = UIImage(named: developer.profileImage)
        profileTitleLabel.text = developer.name
        profilePositionLabel.text = developer.title
        profileDescText.text = developer.descriptionInfo
        youtubeUrl = developer.youtubeUrl
        patreonUrl = developer.patreonUrl
        twitterUrl = developer.twitterUrl
        instagramUrl = developer.instagramUrl
        webPageUrl = developer.siteUrl
        
        youtubeButton.addTarget(self, action: #selector(handleYoutube), for: .touchUpInside)
        instagramButton.addTarget(self, action: #selector(handleInstagram), for: .touchUpInside)
        webpageButton.addTarget(self, action: #selector(handleWebPage), for: .touchUpInside)
        patreonButton.addTarget(self, action: #selector(handlePatreon), for: .touchUpInside)
        twitterButton.addTarget(self, action: #selector(handleTwitter), for: .touchUpInside)
    }
    
    @objc public func handleYoutube(){
        guard let url = URL(string: youtubeUrl!) else {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    @objc public func handleInstagram(){
        guard let url = URL(string: instagramUrl!) else {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    @objc public func handleWebPage(){
        guard let url = URL(string: webPageUrl!) else {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    @objc public func handlePatreon(){
        guard let url = URL(string: patreonUrl!) else {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    @objc public func handleTwitter(){
        guard let url = URL(string: twitterUrl!) else {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    fileprivate func style(view: UIView) {
        view.layer.masksToBounds = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 5

        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 1, height: 5)
        view.layer.shadowRadius = 8
        view.layer.shadowOpacity = 0.2
        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 14, height: 14)).cgPath
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale
    }
    
}
