//
//  NewsVCHandlers.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 9/11/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore

extension NewsVC {
    
    @objc public func finishedWithInput (){
        view.endEditing(true)
    }
    
    @objc public func observeArticles(){
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        db.collection("articles").getDocuments(){
            QuerySnapshot , error in
            if let error = error {
                print("\(error.localizedDescription)")
            }else{
                self.listOfArticle = QuerySnapshot!.documents.compactMap({Article(dictionary: $0.data())}).sorted(by: {$1.date < $0.date}).filter({$0.approved == true})
                DispatchQueue.main.async {
                    self.newsCollection.reloadData()
                    self.activityIndicator.isHidden = true
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    @objc public func checkForUpdates(){
        db.collection("articles")
            .addSnapshotListener {
                querySnapshot, error in
                guard let snapshot  = querySnapshot else {return}
                snapshot.documentChanges.forEach {
                    diff in
                    if diff.type == .added {
                        if Article(dictionary: diff.document.data()) != nil && Article(dictionary: diff.document.data())?.approved == true{
                            self.listOfArticle.append(Article(dictionary: diff.document.data())!)
                            self.listOfArticle.sort(by: {$1.date < $0.date})
                            DispatchQueue.main.async {
                                self.newsCollection.reloadData()
                            }
                        }else{
                            print(error?.localizedDescription ?? "Error")
                        }
                    }
                    if diff.type == .removed {
                        self.observeArticles()
                    }
                    if diff.type == .modified {
                        self.observeArticles()
                    }
                }
        }
    }
    
  @objc public func addArticleToDb(){
        let vc = UINavigationController(rootViewController: AddNewsVC())
        vc.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        present(vc, animated: true, completion: nil)
    }
    
    fileprivate func getTodayDate()  -> String {
        let today = Calendar.current.date(byAdding: .day, value: 0, to: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.string(from: today!)
        return date
    }

}
