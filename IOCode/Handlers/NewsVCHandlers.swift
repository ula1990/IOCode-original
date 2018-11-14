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
        if fetchingMore {
            return
        }
        fetchingMore = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        var query: Query!
        
        if listOfArticle.isEmpty {
            query = db.collection("articlesItems").order(by: "dateSystem", descending: true).limit(to: 4)
        }else{
            query = db.collection("articlesItems").order(by: "dateSystem", descending: true).start(afterDocument: lastDocumentSnapshot!).limit(to: 4)
        }
        
        query.getDocuments(){
            QuerySnapshot , error in
            if error != nil {
                Alert.showBasic(title: "Network Error", msg: "Please check connection and try again", vc: self)
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
                self.fetchingMore = false
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
    
    
    @objc public func freshUpdateArticles(){
        if fetchingMore {
            return
        }
        
        self.listOfArticle.removeAll()
        self.lastDocumentSnapshot = nil
        fetchingMore = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        let query = db.collection("articlesItems").order(by: "dateSystem", descending: true).limit(to: 4)
        query.getDocuments(){
            QuerySnapshot , error in
            if error != nil {
                Alert.showBasic(title: "Network Error", msg: "Please check connection and try again", vc: self)
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
                self.fetchingMore = false
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
    
//    public func tempFunc(){
//        let date = Date()
//        let newArticle = Article(title: "eBay will now let you book home installation and assembly services", description: "Get someone to help assemble that bike or table you just bought", url: "https://www.theverge.com/2018/11/11/18084590/ebay-home-services-handy-porch-installernet-e-commerce", urlToImage: "https://boygeniusreport.files.wordpress.com/2014/11/ebay-sign.jpg?quality=98&strip=all&w=782",content: "eBay has partnered with three companies to allow customers to book home installation or assembly services for items like televisions, furniture, bikes, and other things that need to be put together, right from the product page.Various product pages for applicable items now list an option for customers to select assembly and installation services from one of three companies: Handy, InstallerNet, and Porch. The feature allows them to add the services to the purchase, much like you would add on a protection plan. Once you’ve completed your purchase of your item and the services, the applicable company will get in touch to set up an appointment.In a statement to TechCrunch, eBay Vice President of Merchandising Alyssa Steele says that the company sells a lot of things that require assembly, and the partnerships will allow customers to tap into a larger network of professionals. TechCrunch notes that this isn’t the first time major e-commerce sites have offered up such services — eBay launched something similar last year for customers who bought tires, while Handy partnered with Walmart earlier this year to book installation appointments for shoppers.The partnerships allow eBay to help catch up to Amazon, which launched Home Services back in 2015, a portal that allows customers to hire people for a variety of services, including assembly and installation. However, eBay’s placement of the option to purchase services right on the page streamlines the entire process, making it easy for people to not only click buy, but also schedule someone to help assemble it so you can begin to use that television or bike.", approved: true, date: "02 Nov 18", id: 7, dateSystem: date, resource: "verge")
//        
//        let deviceRef = db.collection("articlesItems")
//        deviceRef.document().setData(newArticle.dictionary){ err in
//            if err != nil {
//                
//            } else {
//                
//            }
//        }
//    }
    
}
