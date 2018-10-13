//
//  LoginVCTextField.swift
//  Leeroy Crew
//
//  Created by Uladzislau Daratsiuk on 7/25/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class MainTextField: UITextField {

    init(placeHolderText: String, isSecure: Bool) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = UIColor.white
        self.textAlignment = .left
        self.isSecureTextEntry = isSecure
        self.attributedPlaceholder = NSAttributedString(string: placeHolderText,attributes: [NSAttributedStringKey.foregroundColor: UIColor.white.withAlphaComponent(0.8)])
        self.font = UIFont(name: "AppleSDGothicNeo-Light", size: 15)
        self.returnKeyType = UIReturnKeyType.done
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
