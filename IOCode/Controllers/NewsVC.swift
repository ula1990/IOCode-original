//
//  NewsVC.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 9/11/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit
import FirebaseFirestore

var currentArticle: Article?

class NewsVC: UIViewController {
    
    let newsCellId = "newsCellId"
    var listOfArticle = [Article]()
    var filtredArticle = [Article]()
    let activityIndicator = MainActivityIndicator(frame: .zero)
    let noDataLabel = MainLabel(text: "No data to display", size: 12, textAligment: .center)
    let searchBar = MainSearchBar()
    var isSearching = false
    var db: Firestore!
    
    lazy var newsCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(NewsCell.self, forCellWithReuseIdentifier: newsCellId)
        view.isScrollEnabled = true
        view.backgroundColor = .white
        return view
    }()

    fileprivate func setupNavBar(){
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.title = "News"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont(name: "AppleSDGothicNeo-Regular", size: 30) ?? UIFont.systemFont(ofSize: 30)]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black,.font: UIFont(name: "AppleSDGothicNeo-Regular", size: 20) ?? UIFont.systemFont(ofSize: 20)]
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"download"), style: .plain, target: self, action: #selector(observeArticles))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"add"), style: .plain, target: self, action: #selector(addArticleToDb))
        navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "tabBarColor")
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "tabBarColor")
        navigationController?.navigationBar.tintColor = .black
    }
    
    fileprivate func setupView(){
        view.backgroundColor = .white
        view.addSubview(searchBar)
        view.addSubview(newsCollection)
        view.addSubview(noDataLabel)
        newsCollection.addSubview(activityIndicator)
        noDataLabel.isHidden = true
        searchBar.delegate = self
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedStringKey.font.rawValue: UIFont(name: "AppleSDGothicNeo-Light", size: 15) ?? UIFont.systemFont(ofSize: 15)]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue:UIColor.gray]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "Search..", attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray])
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "Search..", attributes: [NSAttributedStringKey.font: UIFont(name: "AppleSDGothicNeo-Light", size: 15) ?? UIFont.systemFont(ofSize: 15)])
        
        NSLayoutConstraint.activate([
            
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
            
            newsCollection.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newsCollection.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            newsCollection.leftAnchor.constraint(equalTo: view.leftAnchor),
            newsCollection.rightAnchor.constraint(equalTo: view.rightAnchor),
            newsCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            noDataLabel.centerXAnchor.constraint(equalTo: newsCollection.centerXAnchor),
            noDataLabel.centerYAnchor.constraint(equalTo: newsCollection.centerYAnchor, constant: -30),
            noDataLabel.heightAnchor.constraint(equalToConstant: 20),
            noDataLabel.widthAnchor.constraint(equalToConstant: 150),
            
            activityIndicator.centerXAnchor.constraint(equalTo: newsCollection.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: newsCollection.centerYAnchor),
            activityIndicator.heightAnchor.constraint(equalToConstant: 30),
            activityIndicator.widthAnchor.constraint(equalToConstant: 30)
            ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavBar()
        newsCollection.delegate = self
        newsCollection.dataSource = self
        db = Firestore.firestore()
        observeArticles()
        checkForUpdates()

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        observeArticles()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        newsCollection.reloadData()
    }
}
