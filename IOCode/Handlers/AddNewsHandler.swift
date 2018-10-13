//
//  AddNewsHandler.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 10/10/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit
import Firebase

extension AddNewsVC: UITextFieldDelegate {
    enum ArticleError: Error {
        case emptyTitle
        case emptyDescription
        case emptyUrl
        case emptyImageUrl
        case emtpyContent
    
    }
    
    @objc public func finishedWithInput (){
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @objc public func sendArticle(){
    do{
        try saveArticleToDb()
        }catch ArticleError.emptyTitle{
            Alert.showBasic(title: "Title is empty", msg: "Please first enter a title and try again", vc: self)
        }catch ArticleError.emptyDescription{
            Alert.showBasic(title: "Description is empty", msg: "Please first enter a description and try again", vc: self)
        }catch ArticleError.emptyUrl{
            Alert.showBasic(title: "Url is empty", msg: "Please first enter a url and try again", vc: self)
        }catch ArticleError.emptyImageUrl{
            Alert.showBasic(title: "Image URL is empty", msg: "Please first enter a image url and try again", vc: self)
        }catch ArticleError.emtpyContent{
            Alert.showBasic(title: "Content is empty", msg: "Please first enter some content and try again", vc: self)
        }catch{
            Alert.showBasic(title: "Unable to send article", msg: "Check connection and try again", vc: self)
        }
    }
    
    @objc fileprivate func saveArticleToDb() throws {
        let title = titleField.text!
        let description = descriptionField.text!
        let url = urlField.text!
        let imageUrl = imageUrlField.text!
        let content = contentField.text!
        
        if title.isEmpty{
            throw ArticleError.emptyTitle
        }
        if description.isEmpty{
            throw ArticleError.emptyDescription
        }
        if url.isEmpty{
            throw ArticleError.emptyUrl
        }
        if imageUrl.isEmpty{
            throw ArticleError.emptyImageUrl
        }
        if content.isEmpty{
            throw ArticleError.emtpyContent
        }
        let newArticle = Article(title: title, description: description, url: url, urlToImage: imageUrl,content: content, approved: false, date: getTodayDate())
        let deviceRef = db.collection("articles")
                deviceRef.document().setData(newArticle.dictionary){ err in
                    if err != nil {
                        Alert.showBasic(title: "Article not added", msg: "Failed.Please check connection.", vc: self)
                    } else {
                        Alert.showBasic(title: "Article was sended on moderation", msg: "Thank you", vc: self)
                        self.titleField.text = ""
                        self.descriptionField.text = ""
                        self.urlField.text = ""
                        self.imageUrlField.text = ""
                        self.contentField.text = ""
                        self.dismiss(animated: true, completion: nil)
                    }
                }
    }
    
   fileprivate func getTodayDate()  -> String {
        let today = Calendar.current.date(byAdding: .day, value: 0, to: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: today!)
        return date
    }
    
    @objc public func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
}
