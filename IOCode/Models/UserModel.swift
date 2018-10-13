//
//  File.swift
//  UlaChat
//
//  Created by Uladzislau Daratsiuk on 2018-03-05.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

protocol DocumentUserSerializable {
    init?(dictionary:[String:Any])
}

struct UserModel {
    var id: Int
    var name: String
    var email: String
    var created: String
    
    
    var dictionary:[String:Any] {
        return [
            "id": id,
            "name": name,
            "email": email,
            "created": created
        ]
    }
}

extension UserModel: DocumentUserSerializable {
    init?(dictionary: [String:Any]){
        guard let id = dictionary["id"] as? Int,
            let name = dictionary["name"] as? String,
            let email = dictionary["email"] as? String,
            let created = dictionary["created"] as? String else {return nil}
        self.init(id: id, name: name, email: email, created: created)
    }
}
