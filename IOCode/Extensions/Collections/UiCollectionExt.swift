//
//  UiCollectionExt.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 10/9/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

extension DocumentationVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearching{
            if filtredElements.isEmpty{
                return 0
            }else{
                return filtredElements.count
            }
        }else{
            if listOfElements.isEmpty {
                uiCollection.isHidden = true
                noDataLabel.isHidden = false
                return 0
            }else{
                uiCollection.isHidden = false
                noDataLabel.isHidden = true
                return listOfElements.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let element: UiElement
        let cell = uiCollection.dequeueReusableCell(withReuseIdentifier: uiCellId, for: indexPath) as! UiCell
        if isSearching{
            element = filtredElements[indexPath.row]
        }else{
            element = listOfElements[indexPath.row]
        }
        cell.backgroundColor = UIColor.white.withAlphaComponent(0)
        cell.updateData(element: element)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let element: UiElement
        if isSearching{
            element = filtredElements[indexPath.row]
        }else{
            element = listOfElements[indexPath.row]
        }
        handleDetails(element: element)
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
            uiCollection.reloadData()
        }else{
            isSearching = true
            filtredElements = listOfElements.filter({$0.name!.range(of: searchBar.text!, options: .caseInsensitive) != nil})
            uiCollection.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        isSearching = false
        self.searchBar.endEditing(true)
    }
}
