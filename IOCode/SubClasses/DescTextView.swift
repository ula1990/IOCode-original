//
//  DescTextView.swift
//  DN News
//
//  Created by Uladzislau Daratsiuk on 11/7/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class DescTextView: UITextView {

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
        self.font = UIFont.systemFont(ofSize: 14)
        self.setContentOffset(CGPoint.zero, animated: true)
        let spacing = NSMutableParagraphStyle()
        spacing.lineSpacing = 7
        let attr = [NSAttributedString.Key.paragraphStyle : spacing, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
        self.typingAttributes = attr

    }
}
