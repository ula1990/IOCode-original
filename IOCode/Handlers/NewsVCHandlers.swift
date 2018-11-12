//
//  NewsVCHandlers.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 9/11/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit
import Firebase

extension NewsVC {
    
    @objc public func finishedWithInput (){
        view.endEditing(true)
    }
    
    
    @objc public func observeArticles(){
        
        fetchingMore = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        var query: Query!
        
        if listOfArticle.isEmpty {
            query = db.collection("articlesItems").order(by: "dateSystem", descending: true).limit(to: 5)
        }else{
            query = db.collection("articlesItems").order(by: "dateSystem", descending: true).start(afterDocument: lastDocumentSnapshot!).limit(to: 4)
        }
        
        query.getDocuments(){
            QuerySnapshot , error in
            if error != nil {
                Alert.showBasic(title: "Network Error", msg: "Please check connection and try again", vc: self)
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
            }else if QuerySnapshot!.isEmpty {
                self.fetchingMore = false
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
                return
            }else{
                let articles = QuerySnapshot!.documents.compactMap({Article(dictionary: $0.data())})
                self.listOfArticle.append(contentsOf: articles)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.feedCollection.reloadData()
                    self.fetchingMore = false
                    self.activityIndicator.isHidden = true
                    self.activityIndicator.stopAnimating()
                })
                
                self.lastDocumentSnapshot = QuerySnapshot!.documents.last
                
            }
        }
    }
    
    public func tempFunc(){
        let date = Date()
        let newArticle = Article(title: "Cloudflare rolls out its 1.1.1.1 privacy service to iOS, Android", description: "Apple has rolled out a new release of iOS 12.1 specifically for the iPhone XR, with the update rolling out to the iPhone model if it has not already gone through the update process with the version released seven days ago", url: "https://www.macworld.co.uk/news/mac/new-macbook-pro-2018-3661715/", urlToImage: "https://techcrunch.com/wp-content/uploads/2018/11/spraypainted-1.1.1.1.jpg?w=1390&crop=1",content: "Months after announcing its privacy-focused DNS service, Cloudflare is bringing 1.1.1.1 to mobile users.Granted, nothing ever stopped anyone from using 1.1.1.1 on their phones or tablets already. But now the app, now available for iPhones, iPads and Android devices, aims to make it easier for anyone to use its free consumer DNS service.The app is a one-button push to switch on and off again. That’s it.Cloudflare rolled out 1.1.1.1 earlier this year on April Fools’ Day, no less, but privacy is no joke to the San Francisco-based networking giant. In using the service, you let Cloudflare handle all of your DNS information, like when an app on your phone tries to connect to the internet, or you type in the web address of any site. By funneling that DNS data through 1.1.1.1, it can make it more difficult for your internet provider to know which sites you’re visiting, and also ensure that you can get to the site you want without having your connection censored or hijacked.It’s not a panacea to perfect privacy, mind you — but it’s better than nothing.The service is also blazing fast, shaving valuable seconds off page loading times — particularly in parts of the world where things work, well, a little slower.“We launched 1.1.1.1 to offer consumers everywhere a better choice for fast and private Internet browsing,” said Matthew Prince, Cloudflare chief executive said. “The 1.1.1.1 app makes it even easier for users to unlock fast and encrypted DNS on their phones.”", approved: true, date: "02 Nov 18", id: 7, dateSystem: date, resource: "verge")
        
        let deviceRef = db.collection("articlesItems")
        deviceRef.document().setData(newArticle.dictionary){ err in
            if err != nil {
                
            } else {
                
            }
        }
    }
    
}
