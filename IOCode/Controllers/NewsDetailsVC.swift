//
//  NewsDetailsVC.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 9/17/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class NewsDetailsVC: UIViewController {
    
    var receivedArticle: Article?
    
    lazy var mainScrollView: UIScrollView = {
      let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize.height = 1200
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    let mainView = ShadowView()
    
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
    let articleDate = MainLabel(text: "Nov 7, 8:44 AM", size: 12, textAligment: .right)
    let articleTitle = MainLabel(text: "Title will be here", size: 18, textAligment: .center)
    let articleImage = DescImageView(frame: .zero)
    let articleDescription = DescTextView(frame: .zero)
    
    lazy var articleLink: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFit
        button.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        button.tintColor = .white
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.setImage(UIImage(named: "link"), for: .normal)
        button.addTarget(self, action: #selector(handleLink), for: .touchUpInside)
        return button
    }()
    
    fileprivate func setupNavBar(){
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.title = "More.."
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont(name: "Chalkduster", size: 35) ?? UIFont.systemFont(ofSize: 35)]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black,.font: UIFont(name: "Chalkduster", size: 20) ?? UIFont.systemFont(ofSize: 20)]
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"share"), style: .plain, target: self, action: #selector(handleShare))
        navigationController?.navigationBar.tintColor = .darkGray
        navigationItem.leftBarButtonItem?.tintColor = .darkGray
        navigationItem.rightBarButtonItem?.tintColor = .darkGray
    }
    
    fileprivate func setupView(){
        view.backgroundColor = .white
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(mainView)
        mainView.addSubview(resourceImage)
        mainView.addSubview(resourceName)
        mainView.addSubview(articleDate)
        mainView.addSubview(articleTitle)
        mainView.addSubview(articleImage)
        mainView.addSubview(articleLink)
        mainView.addSubview(articleDescription)
        articleDescription.isScrollEnabled = false
        articleDescription.delegate = self
        receivedArticle = currentArticle
        updateViewDetails(article: receivedArticle!)
        
        NSLayoutConstraint.activate([
            
            mainScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10),
            mainScrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            mainScrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            mainScrollView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            mainView.topAnchor.constraint(equalTo: mainScrollView.topAnchor,constant: 20),
            mainView.bottomAnchor.constraint(equalTo: articleDescription.bottomAnchor, constant: 10),
            mainView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            mainView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            
            resourceImage.topAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.topAnchor, constant: 10),
            resourceImage.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 10),
            resourceImage.heightAnchor.constraint(equalToConstant: 20),
            resourceImage.widthAnchor.constraint(equalToConstant: 20),

            resourceName.leftAnchor.constraint(equalTo: resourceImage.rightAnchor, constant: 10),
            resourceName.rightAnchor.constraint(equalTo: mainView.centerXAnchor, constant: -10),
            resourceName.centerYAnchor.constraint(equalTo: resourceImage.centerYAnchor, constant: 0),
            resourceName.heightAnchor.constraint(equalToConstant: 20),

            articleDate.leftAnchor.constraint(equalTo: mainView.centerXAnchor, constant: 10),
            articleDate.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -10),
            articleDate.centerYAnchor.constraint(equalTo: resourceImage.centerYAnchor, constant: 0),
            articleDate.heightAnchor.constraint(equalToConstant: 20),

            articleTitle.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            articleTitle.topAnchor.constraint(equalTo: resourceImage.bottomAnchor, constant: 20),
            articleTitle.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 10),
            articleTitle.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -10),
            articleTitle.heightAnchor.constraint(equalToConstant: 60),
            
            articleImage.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            articleImage.topAnchor.constraint(equalTo: articleTitle.bottomAnchor, constant: 20),
            articleImage.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 0),
            articleImage.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: 0),
            articleImage.heightAnchor.constraint(equalToConstant: 150),
            
            articleLink.bottomAnchor.constraint(equalTo: articleImage.bottomAnchor, constant: -10),
            articleLink.rightAnchor.constraint(equalTo: articleImage.rightAnchor, constant: -10),
            articleLink.heightAnchor.constraint(equalToConstant: 25),
            articleLink.widthAnchor.constraint(equalToConstant: 25),

            articleDescription.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            articleDescription.topAnchor.constraint(equalTo: articleImage.bottomAnchor, constant: 20),
            articleDescription.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 10),
            articleDescription.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -10),
            articleDescription.heightAnchor.constraint(equalToConstant: 400),

            ])
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
            self.textViewDidChange(self.articleDescription)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavBar()
    }
}
