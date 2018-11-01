//
//  NewsDetailsVC.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 9/17/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class NewsDetailsVC: UIViewController {
    
    let titleLabel = MainTitleLabel(text: "", size: 17, textAligment: .left)
    let articleImage = NewsImageView(frame: .zero)
    let descriptionText = MainTextView()
    var receivedArticle: Article?
    
    lazy var linkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleLink), for: .touchUpInside)
        button.contentMode = .scaleAspectFit
        button.setImage(UIImage(named: "link"), for: .normal)
        button.tintColor = UIColor(named: "tabBarColor")
        return button
    }()
    
    
    fileprivate func setupNavBar(){
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.title = "More"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont(name: "AppleSDGothicNeo-Regular", size: 30) ?? UIFont.systemFont(ofSize: 30)]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black,.font: UIFont(name: "AppleSDGothicNeo-Regular", size: 20) ?? UIFont.systemFont(ofSize: 20)]
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"share"), style: .plain, target: self, action: #selector(handleShare))
        navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "tabBarColor")
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "tabBarColor")
        navigationController?.navigationBar.tintColor = .black
        
    }

    fileprivate func setupView(){
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(articleImage)
        view.addSubview(descriptionText)
        view.addSubview(linkButton)
        
        NSLayoutConstraint.activate([
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
        titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
        titleLabel.heightAnchor.constraint(equalToConstant: 50),
        
        articleImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
        articleImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        articleImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
        articleImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
        articleImage.heightAnchor.constraint(equalToConstant: 200),
        
        descriptionText.topAnchor.constraint(equalTo: articleImage.bottomAnchor, constant: 10),
        descriptionText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        descriptionText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
        descriptionText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
        descriptionText.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            
        linkButton.bottomAnchor.constraint(equalTo: articleImage.bottomAnchor, constant: -10),
        linkButton.rightAnchor.constraint(equalTo: articleImage.rightAnchor, constant: -10),
        linkButton.heightAnchor.constraint(equalToConstant: 25),
        linkButton.widthAnchor.constraint(equalToConstant: 25)
        
        ])
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupView()
        receivedArticle = currentArticle
        updateData(article: receivedArticle! )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func updateData(article: Article){
        descriptionText.text = article.content
        let url = URL(string: article.urlToImage)
        articleImage.downloadImageFrom(url: url!, imageMode: .scaleAspectFit)
        titleLabel.text = article.title
    }


}
