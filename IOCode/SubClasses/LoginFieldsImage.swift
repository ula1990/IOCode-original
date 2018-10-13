//
//  LoginFieldsImage.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 9/18/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class LoginFieldsImage: UIImageView {

    init(imageName: String) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.image = UIImage(named: imageName)
        self.contentMode = .scaleAspectFit
        self.clipsToBounds = true
        self.tintColor = UIColor.white.withAlphaComponent(1)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
