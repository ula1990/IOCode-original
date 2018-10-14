//
//  TutorialVCHandlers.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 8/2/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

extension TutotrialVC {
    
    @objc public func finishedWithInput (){
        view.endEditing(true)
    }
    
    @objc public func reload(){
        loadTutorial(apiKey: apiKey)
    }
    
    public func handleDetails(tutorial: Tutorial){
        UIView.animate(withDuration: 0.3, animations: {
            self.detailsHeightAnchor?.isActive = false
            self.detailsHeightAnchor = self.detailsView.heightAnchor.constraint(equalToConstant: 200)
            self.detailsHeightAnchor?.isActive = true
            self.view.layoutIfNeeded()
        }) { (true) in }

        UIView.transition(with: videoView,
                          duration: 0.60,
                          options: .transitionCrossDissolve,
                          animations: { self.videoView.load(withVideoId: (tutorial.snippet.resourceId.videoId))},
                          completion: nil)
    }
    
    @objc public func loadTutorial(apiKey: String){
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        let urlBased = "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=50&playlistId=PLWDvxU-3gKka34esCH2qX4iQxgufd4v20&key=\(apiKey)"
        guard let url = URL(string: urlBased) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if error != nil{
                    Alert.showBasic(title: "No connection", msg: "Please check your connection and press refresh button", vc: self)
                }
                else{
                    if data != nil{
                        do{
                            self.tutorialList.removeAll()
                            let json = try JSONDecoder().decode(Tutorials.self, from: data!)
                            self.tutorialList = json.items.reversed()
                        }
                        catch{
                            print(error)
                        }
                    }
                }
                self.tutorialCollection.reloadData()
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
            }
        }
        task.resume()
    }
}
