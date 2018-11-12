//
//  DocumentationVC.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 8/2/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class DocumentationVC: UIViewController {
    
    let uiCellId = "uiCellId"
    var listOfElements = [UiElement]()
    var filtredElements = [UiElement]()
    var isSearching = false
    var detailsShowing = false
    var detailsHeightAnchor: NSLayoutConstraint?
    
    let searchBar = MainSearchBar()
    let noDataLabel = MainLabel(text: "No data to display", size: 12, textAligment: .center)
    let detailsView = ShadowView()
    let detailsImage = MainImageView(imageName: "")
  
    lazy var uiCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(UiCell.self, forCellWithReuseIdentifier: uiCellId)
        view.isScrollEnabled = true
        view.backgroundColor = .white
        return view
    }()
    
    fileprivate func setupNavBar(){
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.title = "UI Elements"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont(name: "Chalkduster", size: 30) ?? UIFont.systemFont(ofSize: 30)]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black,.font: UIFont(name: "Chalkduster", size: 20) ?? UIFont.systemFont(ofSize: 20)]
        navigationItem.leftBarButtonItem?.tintColor = UIColor.darkGray
        navigationItem.rightBarButtonItem?.tintColor = UIColor.darkGray
        navigationController?.navigationBar.tintColor = .black

    }
    
    fileprivate func toolBarSetup() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.finishedWithInput))
        doneButton.tintColor = .black
        toolBar.setItems([flexibleSpace, doneButton], animated: true)
        searchBar.inputAccessoryView = toolBar
    }
    
   
    
    fileprivate func setupView(){
        view.backgroundColor = .white
        view.addSubview(searchBar)
        view.addSubview(uiCollection)
        view.addSubview(noDataLabel)
        view.addSubview(detailsView)
        detailsView.addSubview(detailsImage)
        searchBar.delegate = self
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = convertToNSAttributedStringKeyDictionary([NSAttributedString.Key.font.rawValue: UIFont.systemFont(ofSize: 14)])
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = convertToNSAttributedStringKeyDictionary([NSAttributedString.Key.foregroundColor.rawValue:UIColor.gray])
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "Search..", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "Search..", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])
        
        detailsHeightAnchor = detailsView.heightAnchor.constraint(equalToConstant: 0)
        detailsHeightAnchor?.isActive = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(fullscreen))
        self.detailsImage.addGestureRecognizer(tapGestureRecognizer)
        detailsImage.isUserInteractionEnabled = true
        
        
       
        
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
            
            detailsImage.centerXAnchor.constraint(equalTo: detailsView.centerXAnchor),
            detailsImage.centerYAnchor.constraint(equalTo: detailsView.centerYAnchor),
            detailsImage.leftAnchor.constraint(equalTo: detailsView.leftAnchor),
            detailsImage.rightAnchor.constraint(equalTo: detailsView.rightAnchor),
            detailsImage.topAnchor.constraint(equalTo: detailsView.topAnchor),
            detailsImage.bottomAnchor.constraint(equalTo: detailsView.bottomAnchor),
            
            uiCollection.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            uiCollection.topAnchor.constraint(equalTo: detailsView.bottomAnchor, constant: 5),
            uiCollection.leftAnchor.constraint(equalTo: view.leftAnchor),
            uiCollection.rightAnchor.constraint(equalTo: view.rightAnchor),
            uiCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            noDataLabel.centerXAnchor.constraint(equalTo: uiCollection.centerXAnchor),
            noDataLabel.centerYAnchor.constraint(equalTo: uiCollection.centerYAnchor, constant: -30),
            noDataLabel.heightAnchor.constraint(equalToConstant: 20),
            noDataLabel.widthAnchor.constraint(equalToConstant: 150)
            
            ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupView()
        toolBarSetup()
        uiCollection.delegate = self
        uiCollection.dataSource = self
        listOfElements = creatListOfElemnts()
        
    }

}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToNSAttributedStringKeyDictionary(_ input: [String: Any]) -> [NSAttributedString.Key: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
