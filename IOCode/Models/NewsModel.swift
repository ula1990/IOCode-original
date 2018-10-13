//
//  NewsModel.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 9/11/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

protocol DocumentArticleSerializable {
    init?(dictionary:[String:Any])
}

struct Article {
    var title: String
    var description: String
    var url: String
    var urlToImage: String
    var content: String
    var approved: Bool
    var date: String
    
    var dictionary:[String:Any] {
        return [
            "title": title,
            "description": description,
            "url": url,
            "urlToImage": urlToImage,
            "content": content,
            "approved": approved,
            "date": date
        ]
    }
    
}

extension Article: DocumentArticleSerializable {
    init?(dictionary: [String:Any]){
        guard let title = dictionary["title"] as? String,
            let description = dictionary["description"] as? String,
            let url = dictionary["url"] as? String,
            let urlToImage = dictionary["urlToImage"] as? String,
            let content = dictionary["content"] as? String,
            let approved = dictionary["approved"] as? Bool,
            let date = dictionary["date"] as? String else {return nil}
        self.init(title: title, description: description, url: url, urlToImage: urlToImage,content: content, approved: approved, date: date)
    }
}
