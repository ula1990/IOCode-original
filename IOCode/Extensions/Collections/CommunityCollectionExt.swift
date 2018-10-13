//
//  CommunityCollectionExt.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 9/18/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

extension CommunityVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return developerList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dev = developerList[indexPath.row]
        let cell = communityCollection.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CommunityCell
        cell.updateData(developer: dev)
//        cell.youtubeButton.addTarget(self, action: #selector(handleYoutube), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
            return CGSize(width: view.frame.width - 40, height: 250)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

            return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    @objc public func handleYoutube(){
        print("works")
        guard let url = URL(string: "http://google.com") else {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
