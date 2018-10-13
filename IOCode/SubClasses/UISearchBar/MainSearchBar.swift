//
//  MainSearchBar.swift
//  Leeroy Order
//
//  Created by Uladzislau Daratsiuk on 9/5/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class MainSearchBar: UISearchBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.masksToBounds = false
        self.backgroundColor = UIColor.white.withAlphaComponent(0)
        self.layer.cornerRadius = 14
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 5)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.2
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.backgroundImage = UIImage()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
