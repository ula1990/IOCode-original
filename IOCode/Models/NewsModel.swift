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
    var id: Int
    var dateSystem: Date
    var resource: String
    
    var dictionary:[String:Any] {
        return [
            "title": title,
            "description": description,
            "url": url,
            "urlToImage": urlToImage,
            "content": content,
            "approved": approved,
            "date": date,
            "id": id,
            "dateSystem": dateSystem,
            "resource": resource
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
            let date = dictionary["date"] as? String,
            let id = dictionary["id"] as? Int,
            let dateSystem = dictionary["dateSystem"] as? Date,
            let resource = dictionary["resource"] as? String else {return nil}
        self.init(title: title, description: description, url: url, urlToImage: urlToImage,content: content, approved: approved, date: date, id: id, dateSystem: dateSystem, resource: resource)
    }
}
