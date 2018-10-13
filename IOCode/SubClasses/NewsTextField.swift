//
//  NewsTextField.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 10/10/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class NewsTextField: UITextField {
    
    init(placeHolderText: String, isSecure: Bool) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = UIColor.black
        self.textAlignment = .center
        self.isSecureTextEntry = isSecure
        self.attributedPlaceholder = NSAttributedString(string: placeHolderText,attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray.withAlphaComponent(0.8)])
        self.font = UIFont(name: "AppleSDGothicNeo-Light", size: 15)
        self.returnKeyType = UIReturnKeyType.done
        self.layer.borderColor = UIColor(named: "tabBarColor")?.cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 5
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
