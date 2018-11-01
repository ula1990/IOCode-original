//
//  TutorialCollectionExt.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 9/18/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

extension TutotrialVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearching{
            if filtredTutorials.isEmpty{
                return 0
            }else{
                return filtredTutorials.count
            }
        }else{
            if tutorialList.isEmpty {
                tutorialCollection.isHidden = true
                noDataLabel.isHidden = false
                return 0
            }else{
                tutorialCollection.isHidden = false
                noDataLabel.isHidden = true
                return tutorialList.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tutorial: Tutorial
        let cell = tutorialCollection.dequeueReusableCell(withReuseIdentifier: tutorialCellId, for: indexPath) as! TutorialCell
        if isSearching{
            tutorial = filtredTutorials[indexPath.row]
        }else{
            tutorial = tutorialList[indexPath.row]
        }
        cell.backgroundColor = UIColor.white.withAlphaComponent(0)
        cell.updateData(tutorial: tutorial)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tutorial = tutorialList[indexPath.row]
        handleDetails(tutorial: tutorial )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width - 40, height: 60)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            tutorialCollection.reloadData()
        }else{
            isSearching = true
            filtredTutorials = tutorialList.filter({$0.snippet.title.range(of: searchBar.text!, options: .caseInsensitive) != nil})
            tutorialCollection.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        isSearching = false
        self.searchBar.endEditing(true)
    }
}
