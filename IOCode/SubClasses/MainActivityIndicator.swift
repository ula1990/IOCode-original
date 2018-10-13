//
//  MainActivityIndicator.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 9/11/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class MainActivityIndicator: UIActivityIndicatorView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isHidden = true
        self.color = UIColor.orange
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
