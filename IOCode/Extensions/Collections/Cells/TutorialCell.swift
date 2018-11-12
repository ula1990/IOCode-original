//
//  TutorialCell.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 9/18/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class TutorialCell: UICollectionViewCell {
    
    let tutorialImage = NewsImageView(frame: .zero)
    let tutorialTitle = NewsTextView()
    lazy var seperatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        return view
    }()
    lazy var resourceImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.image = UIImage(named: "xcode")
        return image
    }()
    let resourceName  = MainLabel(text: "Xcode 10.1 Swift 4.2", size: 12, textAligment: .left)
    
    fileprivate func setupView(){
        contentView.addSubview(tutorialImage)
        contentView.addSubview(tutorialTitle)
        contentView.addSubview(seperatorView)
        contentView.addSubview(resourceName)
        contentView.addSubview(resourceImage)

        style(view: contentView)
        NSLayoutConstraint.activate([
            
            tutorialImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            tutorialImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            tutorialImage.widthAnchor.constraint(equalToConstant: 60),
            tutorialImage.heightAnchor.constraint(equalToConstant: 60),
            
            tutorialTitle.topAnchor.constraint(equalTo: tutorialImage.topAnchor, constant: 0),
            tutorialTitle.leftAnchor.constraint(equalTo: tutorialImage.rightAnchor, constant: 10),
            tutorialTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5),
            tutorialTitle.bottomAnchor.constraint(equalTo: tutorialImage.bottomAnchor, constant: 0),
            
            seperatorView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100),
            seperatorView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            seperatorView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            seperatorView.heightAnchor.constraint(equalToConstant: 0.5),
            
            resourceImage.centerYAnchor.constraint(equalTo: resourceName.centerYAnchor),
            resourceImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            resourceImage.heightAnchor.constraint(equalToConstant: 20),
            resourceImage.widthAnchor.constraint(equalToConstant: 20),
            
            resourceName.leftAnchor.constraint(equalTo: resourceImage.rightAnchor, constant: 10),
            resourceName.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            resourceName.topAnchor.constraint(equalTo: seperatorView.bottomAnchor, constant: 0),
            resourceName.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            
            ])
        
    }
    
    public func updateData(tutorial: Tutorial){
        tutorialTitle.text = tutorial.snippet.title
        tutorialImage.image = UIImage(named: "tutorial")
        tutorialImage.contentMode = .scaleAspectFit
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
