//
//  TutorialModel.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 8/2/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

class Tutorials: Decodable  {
    let items: [Tutorial]
}

class Tutorial: Decodable {
    let id: String
    let snippet: Details
    
    init(id: String, snippet: Details) {
        self.id = id
        self.snippet = snippet
    }

}
class Details: Decodable {
    let title: String
    let description: String
    let resourceId: ResourseDetails
    
    init(title:String, description: String, resourceId: ResourseDetails) {
        self.title = title
        self.description = description
        self.resourceId = resourceId
    }
}

class ResourseDetails: Decodable {
    let videoId: String
    init(videoId: String) {
        self.videoId = videoId
    }
}
