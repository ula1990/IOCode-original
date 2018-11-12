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
        self.textColor = UIColor.darkGray
        self.textAlignment = .left
        self.isSecureTextEntry = isSecure
        self.attributedPlaceholder = NSAttributedString(string: placeHolderText,attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray.withAlphaComponent(0.8)])
        self.font = UIFont.systemFont(ofSize: 14)
        self.returnKeyType = UIReturnKeyType.done
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
