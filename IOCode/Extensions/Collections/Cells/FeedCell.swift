//
//  NewsCell.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 9/18/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class FeedCell: UICollectionViewCell {
 
    let articleImage = NewsImageView(frame: .zero)
    let articleTitle = NewsTextView()
    let articleDate = MainLabel(text: "Date:", size: 12, textAligment: .left)
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
        image.image = UIImage(named: "verge")
        return image
    }()
    let resourceName  = MainLabel(text: "The Verge", size: 12, textAligment: .left)
    
    fileprivate func setupView(){
        contentView.addSubview(articleImage)
        contentView.addSubview(articleTitle)
        contentView.addSubview(articleDate)
        contentView.addSubview(seperatorView)
        contentView.addSubview(resourceName)
        contentView.addSubview(resourceImage)
        
        articleDate.textColor = UIColor.gray.withAlphaComponent(0.5)
        style(view: contentView)
        NSLayoutConstraint.activate([
            
            articleImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            articleImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            articleImage.widthAnchor.constraint(equalToConstant: 60),
            articleImage.heightAnchor.constraint(equalToConstant: 60),
            
            articleTitle.topAnchor.constraint(equalTo: articleImage.topAnchor, constant: 0),
            articleTitle.leftAnchor.constraint(equalTo: articleImage.rightAnchor, constant: 10),
            articleTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5),
            articleTitle.bottomAnchor.constraint(equalTo: articleImage.bottomAnchor, constant: 0),
            
            articleDate.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            articleDate.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            articleDate.heightAnchor.constraint(equalToConstant: 20),
            articleDate.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            
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
    
    public func updateData(article: Article){
        articleTitle.text = article.title
        let imageURL = URL(string: article.urlToImage)
        articleImage.downloadImageFrom(url: imageURL!, imageMode: .scaleAspectFit)
        articleImage.contentMode = .scaleAspectFill
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm a"
        articleDate.text = dateFormatter.string(from: article.dateSystem)
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
        view.layer.cornerRadius = 10
//        view.layer.shadowColor = UIColor(named: "tabBarColor")?.cgColor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 1, height: 3)
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.2
        view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 10, height: 10)).cgPath
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale
    }
}
