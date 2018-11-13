//
//  NewsVC.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 9/11/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit
import Firebase

var currentArticle: Article?

class NewsVC: UIViewController {
    
    let feedCellId = "feedCellId"
    var listOfArticle = [Article]()
    var filtredArticle = [Article]()
    let activityIndicator = MainActivityIndicator(frame: .zero)
    let noDataLabel = MainLabel(text: "Updating...", size: 12, textAligment: .center)
    let searchBar = MainSearchBar()
    var isSearching = false
    var db: Firestore!
    var lastDocumentSnapshot: DocumentSnapshot?
    var fetchingMore = false
    let settings = FirestoreSettings()
    
    lazy var feedCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(FeedCell.self, forCellWithReuseIdentifier: feedCellId)
        view.isScrollEnabled = true
        view.backgroundColor = .white
        view.alwaysBounceVertical = true
        return view
    }()
    
    fileprivate func setupNavBar(){
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.title = "Feed"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(named: "background")
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont(name: "Chalkduster", size: 35) ?? UIFont.systemFont(ofSize: 35)]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black,.font: UIFont(name: "Chalkduster", size: 20) ?? UIFont.systemFont(ofSize: 20)]
    }
    
    fileprivate func setupView(){
        view.backgroundColor = .white
        view.addSubview(searchBar)
        view.addSubview(feedCollection)
        view.addSubview(noDataLabel)
        view.addSubview(activityIndicator)
        noDataLabel.isHidden = true
        searchBar.delegate = self
        feedCollection.delegate = self
        feedCollection.dataSource = self
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "Search..", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "Search..", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])
        
        NSLayoutConstraint.activate([
            
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
            
            feedCollection.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            feedCollection.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            feedCollection.leftAnchor.constraint(equalTo: view.leftAnchor),
            feedCollection.rightAnchor.constraint(equalTo: view.rightAnchor),
            feedCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            noDataLabel.centerXAnchor.constraint(equalTo: feedCollection.centerXAnchor),
            noDataLabel.centerYAnchor.constraint(equalTo: feedCollection.centerYAnchor, constant: -30),
            noDataLabel.heightAnchor.constraint(equalToConstant: 20),
            noDataLabel.widthAnchor.constraint(equalToConstant: 150),
            
            activityIndicator.centerXAnchor.constraint(equalTo: feedCollection.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: feedCollection.centerYAnchor),
            activityIndicator.heightAnchor.constraint(equalToConstant: 30),
            activityIndicator.widthAnchor.constraint(equalToConstant: 30)
            
            ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavBar()
        db = Firestore.firestore()
        observeArticles()
        //        checkForUpdates()
//            tempFunc()
    }
    
    
}

