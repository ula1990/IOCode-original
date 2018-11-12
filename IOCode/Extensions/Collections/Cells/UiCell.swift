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
    let uiTitle = NewsTextView()
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
        image.image = UIImage(named: "swift")
        return image
    }()
    let resourceName  = MainLabel(text: "", size: 12, textAligment: .left)
    
    fileprivate func setupView(){
        contentView.addSubview(uiImage)
        contentView.addSubview(uiTitle)
        contentView.addSubview(seperatorView)
        contentView.addSubview(resourceName)
        contentView.addSubview(resourceImage)
        
        style(view: contentView)
        NSLayoutConstraint.activate([
            
            uiImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            uiImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            uiImage.widthAnchor.constraint(equalToConstant: 60),
            uiImage.heightAnchor.constraint(equalToConstant: 60),
            
            uiTitle.topAnchor.constraint(equalTo: uiImage.topAnchor, constant: 0),
            uiTitle.leftAnchor.constraint(equalTo: uiImage.rightAnchor, constant: 10),
            uiTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5),
            uiTitle.bottomAnchor.constraint(equalTo: uiImage.bottomAnchor, constant: 0),
            
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
    
    public func updateData(element: UiElement){
        uiTitle.text = "UIKit Element: \(element.name!)"
        uiImage.image = UIImage(named: "uielements")
        resourceName.text = element.version
        uiImage.contentMode = .scaleAspectFit
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
