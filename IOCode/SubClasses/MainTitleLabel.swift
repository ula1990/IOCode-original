//
//  MainTitleLabel.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 9/17/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class MainTitleLabel: UILabel {

    init(text: String, size: CGFloat, textAligment: NSTextAlignment) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = .black
        self.textAlignment = textAligment
        self.font = UIFont(name: "AppleSDGothicNeo-Regular", size: size)
        self.text = text
        self.numberOfLines = 4
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
