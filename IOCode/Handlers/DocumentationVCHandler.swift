//
//  DocumentationVCHandler.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 10/9/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

extension DocumentationVC {
    
    public func creatListOfElemnts() -> [UiElement]{
        var tempArray = [UiElement]()
        
        tempArray.append(UiElement(name: "UIButton",version: "Swift 4.2 Xcode 10", image: "uibutton"))
        tempArray.append(UiElement(name: "UITextField",version: "Swift 4.2 Xcode 10", image: "uitextfield"))
        tempArray.append(UiElement(name: "UILabel",version: "Swift 4.2 Xcode 10", image: "uilabel"))
        tempArray.append(UiElement(name: "UIImage",version: "Swift 4.2 Xcode 10", image: "uiimage"))
        tempArray.append(UiElement(name: "UITextView",version: "Swift 4.2 Xcode 10", image: "uitextview"))
        tempArray.append(UiElement(name: "UIActivityIndicatorView", version: "Swift 4.2 Xcode 10", image: "uiactivityindicatorview"))
        tempArray.append(UiElement(name: "UISearchBar", version: "Swift 4.2 Xcode 10", image: "uisearchbar"))
        tempArray.append(UiElement(name: "UIPageControl", version: "Swift 4.2 Xcode 10", image: "uipagecontrol"))
        tempArray.append(UiElement(name: "UIPickerView", version: "Swift 4.2 Xcode 10", image: "uipickerview"))
        tempArray.append(UiElement(name: "UITableView", version: "Swift 4.2 Xcode 10", image: "uitableview"))
        tempArray.append(UiElement(name: "UIScrollView", version: "Swift 4.2 Xcode 10", image: "uiscrollview"))
        tempArray.append(UiElement(name: "UITabBarController", version: "Swift 4.2 Xcode 10", image: "uitabbarcontroller"))
        tempArray.append(UiElement(name: "UIAlertController", version: "Swift 4.2 Xcode 10", image: "uialertcontroller"))
        tempArray.append(UiElement(name: "UINavigationController", version: "Swift 4.2 Xcode 10", image: "navigationcontroller"))
        
        return tempArray
    }
    
    @objc public func handleDetails(element: UiElement){
            UIView.animate(withDuration: 0.3, animations: {
                self.detailsHeightAnchor?.isActive = false
                self.detailsHeightAnchor = self.detailsView.heightAnchor.constraint(equalToConstant: 200)
                self.detailsHeightAnchor?.isActive = true
                self.view.layoutIfNeeded()
            }) { (true) in }
        
            UIView.transition(with: detailsImage,
                          duration: 0.60,
                          options: .transitionCrossDissolve,
                          animations: { self.detailsImage.image = UIImage(named: element.image!)},
                          completion: nil)
    }
    
    @objc public func fullscreen(){
        let newImageView = UIImageView(image: detailsImage.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    @objc fileprivate func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
}
