//
//  MainLabel.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 8/2/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class MainLabel: UILabel {

    init(text: String, size: CGFloat, textAligment: NSTextAlignment) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = .black
        self.textAlignment = textAligment
        self.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: size)
        self.text = text
        self.numberOfLines = 4
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    public func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
            
            guard let labelText = self.text else { return }
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineSpacing
            paragraphStyle.lineHeightMultiple = lineHeightMultiple
            
            let attributedString:NSMutableAttributedString
            if let labelattributedText = self.attributedText {
                attributedString = NSMutableAttributedString(attributedString: labelattributedText)
            } else {
                attributedString = NSMutableAttributedString(string: labelText)
            }

            attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
            self.attributedText = attributedString
        }
    
}
