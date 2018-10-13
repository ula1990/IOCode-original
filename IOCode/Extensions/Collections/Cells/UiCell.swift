//
//  UiCell.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 10/9/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class UiCell: UICollectionViewCell {
    let uiImage = NewsImageView(frame: .zero)
    let uiVersion = MainLabel(text: "Version", size: 12, textAligment: .left)
    let uiName = MainLabel(text: "Title here:", size: 14, textAligment: .left)
    
    
    fileprivate func setupView(){
        contentView.addSubview(uiImage)
        contentView.addSubview(uiName)
        contentView.addSubview(uiVersion)
        style(view: contentView)
        uiImage.clipsToBounds = true
        uiImage.layer.cornerRadius = 5
        uiImage.contentMode = .scaleAspectFit
        
        
        NSLayoutConstraint.activate([
            
            uiImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            uiImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            uiImage.widthAnchor.constraint(equalToConstant: 60),
            uiImage.heightAnchor.constraint(equalToConstant: 60),
            
            uiName.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            uiName.leftAnchor.constraint(equalTo: uiImage.rightAnchor, constant: 20),
            uiName.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5),
            uiName.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            
            uiVersion.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            uiVersion.leftAnchor.constraint(equalTo: uiImage.rightAnchor, constant: 20),
            uiVersion.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5),
            uiVersion.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
            
            ])
        
    }
    
    public func updateData(element: UiElement){
        uiName.text = "UIKit Element: \(element.name!)"
        uiName.setLineSpacing(lineSpacing: 5, lineHeightMultiple: 0)
        uiImage.image = UIImage(named: "uielements")
        uiVersion.text = element.version
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
