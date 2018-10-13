//
//  TutorialCell.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 9/18/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class TutorialCell: UICollectionViewCell {
    
    lazy var tutorialImage = NewsImageView(frame: .zero)
    lazy var titleLabel = MainLabel(text: "", size: 14, textAligment: .left)
    
    fileprivate func setupView(){
        contentView.addSubview(tutorialImage)
        contentView.addSubview(titleLabel)
        style(view: contentView)
        
        tutorialImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        tutorialImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        tutorialImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        tutorialImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: tutorialImage.rightAnchor, constant: 20).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
    public func updateData(tutorial: Tutorial){
        titleLabel.text = tutorial.snippet.title
        titleLabel.setLineSpacing(lineSpacing: 5, lineHeightMultiple: 0)
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
//        view.layer.shadowColor = UIColor(named: "tabBarColor")?.cgColor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 1, height: 5)
        view.layer.shadowRadius = 8
        view.layer.shadowOpacity = 0.2
        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 14, height: 14)).cgPath
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale
    }
}
