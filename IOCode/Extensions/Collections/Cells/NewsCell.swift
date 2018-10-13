//
//  NewsCell.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 9/18/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class NewsCell: UICollectionViewCell {
 
    let articleImage = NewsImageView(frame: .zero)
    let articleTitle = MainLabel(text: "Title here:", size: 14, textAligment: .left)
    let articleDate = MainLabel(text: "Date:", size: 10, textAligment: .right)
    
    fileprivate func setupView(){
        contentView.addSubview(articleImage)
        contentView.addSubview(articleTitle)
        contentView.addSubview(articleDate)
        style(view: contentView)
        articleImage.clipsToBounds = true
        articleImage.layer.cornerRadius = 5
        articleDate.textColor = .gray

        NSLayoutConstraint.activate([
            
            articleImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            articleImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            articleImage.widthAnchor.constraint(equalToConstant: 70),
            articleImage.heightAnchor.constraint(equalToConstant: 40),
            
            articleTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            articleTitle.leftAnchor.constraint(equalTo: articleImage.rightAnchor, constant: 10),
            articleTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5),
            articleTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            
            articleDate.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5),
            articleDate.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            articleDate.heightAnchor.constraint(equalToConstant: 10),
            articleDate.leftAnchor.constraint(equalTo: self.centerXAnchor)
            
            ])
        
    }
    
    public func updateData(article: Article){
        articleTitle.text = article.title
        articleTitle.setLineSpacing(lineSpacing: 5, lineHeightMultiple: 0)
        let imageURL = URL(string: article.urlToImage)
        articleImage.downloadImageFrom(url: imageURL!, imageMode: .scaleAspectFit)
        articleDate.text = article.date
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
