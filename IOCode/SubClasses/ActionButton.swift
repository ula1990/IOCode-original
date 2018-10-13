//
//  PhoneButton.swift
//  Leeroy Crew
//
//  Created by Uladzislau Daratsiuk on 7/16/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit
import Foundation

class ActionButton: UIButton {
    
    var currentUrl: String?
    
    init(url: String, image: String) {
        super.init(frame: .zero)
        currentUrl = url
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = .scaleAspectFit
        self.setImage(UIImage(named: image), for: .normal)
        self.addTarget(self, action: #selector(openButtonUrl), for: .touchUpInside)
        self.tintColor = UIColor(named: "system")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc public func openButtonUrl() {
        if let url = NSURL(string:currentUrl!) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
}
