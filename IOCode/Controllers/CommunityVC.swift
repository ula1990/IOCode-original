//
//  CommunityVC.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 9/11/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class CommunityVC: UIViewController {
    
    let cellId = "cellId"
    var developerList = [Developer]()
    
    lazy var communityCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(CommunityCell.self, forCellWithReuseIdentifier: cellId)
        view.isScrollEnabled = true
        view.backgroundColor = .white
        return view
    }()

    fileprivate func setupNavBar(){
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.title = "Community iOS Devs"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont(name: "AppleSDGothicNeo-Regular", size: 30) ?? UIFont.systemFont(ofSize: 30)]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black,.font: UIFont(name: "AppleSDGothicNeo-Regular", size: 20) ?? UIFont.systemFont(ofSize: 20)]
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"about"), style: .plain, target: self, action: #selector(handleAbout))
        navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "tabBarColor")
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "tabBarColor")
        navigationController?.navigationBar.tintColor = .black
    }
    
    fileprivate func setupView(){
        view.addSubview(communityCollection)
        
        communityCollection.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        communityCollection.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        communityCollection.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        communityCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        communityCollection.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        communityCollection.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavBar()
        setupView()
        communityCollection.delegate = self
        communityCollection.dataSource = self
        developerList = createDevArray()
    }
}
