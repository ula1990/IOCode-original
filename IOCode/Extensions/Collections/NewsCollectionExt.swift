//
//  NewsCollectionExt.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 9/18/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

extension NewsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearching{
            if filtredArticle.isEmpty{
                return 0
            }else{
                return filtredArticle.count
            }
        }else{
            if listOfArticle.isEmpty {
                newsCollection.isHidden = true
                noDataLabel.isHidden = false
                return 0
            }else{
                newsCollection.isHidden = false
                noDataLabel.isHidden = true
                return listOfArticle.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let article: Article
        let cell = newsCollection.dequeueReusableCell(withReuseIdentifier: newsCellId, for: indexPath) as! NewsCell
        if isSearching{
            article = filtredArticle[indexPath.row]
        }else{
            article = listOfArticle[indexPath.row]
        }
        cell.backgroundColor = UIColor.white.withAlphaComponent(0)
        cell.updateData(article: article)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let article = listOfArticle[indexPath.row]
        currentArticle = article
        let vc = NewsDetailsVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width - 40, height: 65)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            newsCollection.reloadData()
        }else{
            isSearching = true
            filtredArticle = listOfArticle.filter({$0.title.range(of: searchBar.text!, options: .caseInsensitive) != nil})
            newsCollection.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        isSearching = false
        self.searchBar.endEditing(true)
    }
}
