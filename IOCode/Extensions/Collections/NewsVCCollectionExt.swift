//
//  MainVCCollectionExt.swift
//  DN News
//
//  Created by Uladzislau Daratsiuk on 11/6/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit
import Firebase

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
                feedCollection.isHidden = true
                noDataLabel.isHidden = false
                return 0
            }else{
                feedCollection.isHidden = false
                noDataLabel.isHidden = true
                return listOfArticle.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let article: Article
        let cell = feedCollection.dequeueReusableCell(withReuseIdentifier: feedCellId, for: indexPath) as! FeedCell
        if isSearching{
            article = filtredArticle[indexPath.row]
            cell.updateData(article: article)
        }else{
            if !listOfArticle.isEmpty {
                article = listOfArticle[indexPath.row]
                cell.updateData(article: article)
            }
        }
        cell.backgroundColor = UIColor.white.withAlphaComponent(0)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let article = listOfArticle[indexPath.row]
        currentArticle = article
        let vc = NewsDetailsVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width - 40, height: 140)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            feedCollection.reloadData()
        }else{
            isSearching = true
            filtredArticle = listOfArticle.filter({$0.title.range(of: searchBar.text!, options: .caseInsensitive) != nil})
            feedCollection.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        isSearching = false
        self.searchBar.endEditing(true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height - 50 {
            // Bottom of the screen is reached
            if !fetchingMore {
                observeArticles()
            }
        }else if offsetY < -100 {
            self.listOfArticle.removeAll()
            self.feedCollection.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                if !self.fetchingMore {
                    self.observeArticles()
                }
                
            })
        }
    }
    
}
