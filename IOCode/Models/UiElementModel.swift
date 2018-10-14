//
//  UiElementModel.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 10/9/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

class UiElement: NSObject {
    var name: String?
    var version: String?
    var image: String?
    
    init(name: String,version: String, image: String ){
        self.name = name
        self.version = version
        self.image = image
    }
}

