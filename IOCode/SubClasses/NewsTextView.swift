//
//  NewsTextView.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 10/10/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class NewsTextView: UITextView {

    let mainTextSize: CGFloat = 15
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView(){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = .left
        self.textColor = UIColor.darkGray
        self.backgroundColor = UIColor.white.withAlphaComponent(0)
        self.isEditable = false
        let spacing = NSMutableParagraphStyle()
        spacing.lineSpacing = 7
        spacing.alignment = .center
        self.typingAttributes = [NSAttributedStringKey.paragraphStyle.rawValue: spacing,
                                 NSAttributedStringKey.font.rawValue: UIFont(name: "AppleSDGothicNeo-Light", size: mainTextSize) ?? UIFont.systemFont(ofSize: mainTextSize)]
        self.layer.borderColor = UIColor(named: "tabBarColor")?.cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 5
    }
    
}

