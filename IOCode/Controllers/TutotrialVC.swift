//
//  TutotrialVC.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 8/2/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class TutotrialVC: UIViewController {
    let tutorialCellId = "tutorialCellId"
    var tutorialList = [Tutorial]()
    var filtredTutorials = [Tutorial]()
    var apiKey = "AIzaSyDM5jatshunoGE8dJq7U13dHNRZsr3uhrc"
    var isSearching = false
    var detailsShowing = false
    var detailsHeightAnchor: NSLayoutConstraint?
    
    let activityIndicator = MainActivityIndicator(frame: .zero)
    let searchBar = MainSearchBar()
    let noDataLabel = MainLabel(text: "No data to display", size: 12, textAligment: .center)
    let detailsView = ShadowView()
    lazy var loadingLabel = MainLabel(text: "Loading..", size: 12, textAligment: .center)
    
    let videoView: YTPlayerView = {
        let view = YTPlayerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor(named: "tabBarColor")?.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    lazy var tutorialCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(TutorialCell.self, forCellWithReuseIdentifier: tutorialCellId)
        view.isScrollEnabled = true
        view.backgroundColor = .white
        return view
    }()
    
    fileprivate func setupNavBar(){
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.title = "Online Tutorials"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont(name: "AppleSDGothicNeo-Regular", size: 30) ?? UIFont.systemFont(ofSize: 30)]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black,.font: UIFont(name: "AppleSDGothicNeo-Regular", size: 20) ?? UIFont.systemFont(ofSize: 20)]
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"download"), style: .plain, target: self, action: #selector(reload))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.darkGray
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "tabBarColor")
        navigationController?.navigationBar.tintColor = .black
    }
    
    fileprivate func toolBarSetup() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.finishedWithInput))
        doneButton.tintColor = .black
        toolBar.setItems([flexibleSpace, doneButton], animated: true)
        searchBar.inputAccessoryView = toolBar
    }
    
    fileprivate func setupView(){
        view.addSubview(searchBar)
        view.addSubview(detailsView)
        detailsView.addSubview(loadingLabel)
        detailsView.addSubview(videoView)
        view.addSubview(tutorialCollection)
        view.addSubview(noDataLabel)
        view.addSubview(activityIndicator)
        noDataLabel.isHidden = true
        
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedStringKey.font.rawValue: UIFont(name: "AppleSDGothicNeo-Light", size: 15) ?? UIFont.systemFont(ofSize: 15)]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue:UIColor.gray]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "Search..", attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray])
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "Search..", attributes: [NSAttributedStringKey.font: UIFont(name: "AppleSDGothicNeo-Light", size: 15) ?? UIFont.systemFont(ofSize: 15)])
        
        detailsHeightAnchor = detailsView.heightAnchor.constraint(equalToConstant: 0)
        detailsHeightAnchor?.isActive = true
        
        NSLayoutConstraint.activate([
            
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
            
            detailsView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 20),
            detailsView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -20),
            detailsView.topAnchor.constraint(equalTo: searchBar.bottomAnchor,constant: 5),
            detailsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loadingLabel.centerXAnchor.constraint(equalTo: detailsView.centerXAnchor),
            loadingLabel.centerYAnchor.constraint(equalTo: detailsView.centerYAnchor),
            loadingLabel.topAnchor.constraint(equalTo: detailsView.topAnchor),
            loadingLabel.bottomAnchor.constraint(equalTo: detailsView.bottomAnchor),
            loadingLabel.widthAnchor.constraint(equalToConstant: 150),
            
            videoView.centerXAnchor.constraint(equalTo: detailsView.centerXAnchor),
            videoView.centerYAnchor.constraint(equalTo: detailsView.centerYAnchor),
            videoView.leftAnchor.constraint(equalTo: detailsView.leftAnchor),
            videoView.rightAnchor.constraint(equalTo: detailsView.rightAnchor),
            videoView.topAnchor.constraint(equalTo: detailsView.topAnchor),
            videoView.bottomAnchor.constraint(equalTo: detailsView.bottomAnchor),
            
            tutorialCollection.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tutorialCollection.topAnchor.constraint(equalTo: detailsView.bottomAnchor, constant: 15),
            tutorialCollection.leftAnchor.constraint(equalTo: view.leftAnchor),
            tutorialCollection.rightAnchor.constraint(equalTo: view.rightAnchor),
            tutorialCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            noDataLabel.centerXAnchor.constraint(equalTo: tutorialCollection.centerXAnchor),
            noDataLabel.centerYAnchor.constraint(equalTo: tutorialCollection.centerYAnchor, constant: -30),
            noDataLabel.heightAnchor.constraint(equalToConstant: 20),
            noDataLabel.widthAnchor.constraint(equalToConstant: 150),
            
            activityIndicator.centerXAnchor.constraint(equalTo: tutorialCollection.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: tutorialCollection.centerYAnchor),
            activityIndicator.heightAnchor.constraint(equalToConstant: 30),
            activityIndicator.widthAnchor.constraint(equalToConstant: 30)
            ])
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        loadTutorial(apiKey: apiKey)
        tutorialCollection.delegate = self
        tutorialCollection.dataSource = self
        setupNavBar()
        setupView()
        toolBarSetup()
        searchBar.returnKeyType = UIReturnKeyType.done
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadTutorial(apiKey: apiKey)
    }
}
