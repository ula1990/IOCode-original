//
//  CommentTextView.swift
//  Leeroy Crew
//
//  Created by Uladzislau Daratsiuk on 7/30/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class MainTextView: UITextView {
    
    let mainTextSize: CGFloat = 14

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
        spacing.alignment = .left
        self.typingAttributes = [NSAttributedStringKey.paragraphStyle.rawValue: spacing,
                                 NSAttributedStringKey.font.rawValue: UIFont(name: "AppleSDGothicNeo-Light", size: mainTextSize) ?? UIFont.systemFont(ofSize: mainTextSize)]
    }
}
