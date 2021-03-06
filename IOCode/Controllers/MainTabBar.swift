//
//  MainTabBar.swift
//  IOCode
//
//  Created by Uladzislau Daratsiuk on 9/11/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class MainTabBar: UITabBarController {
    
    private let mainVC = MainVC()
    private let tutorialVC = TutotrialVC()
    private let newsVC = NewsVC()
    private let docVC = DocumentationVC()
    private let communityVC = CommunityVC()
    private let aboutVC = AboutVC()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [createControllers(title: "Main", imageName: "main", vc: mainVC), createControllers(title: "Tutorial", imageName: "tutorialTab", vc: tutorialVC),createControllers(title: "News", imageName: "news", vc: newsVC),createControllers(title: "UI Elements", imageName: "documents", vc: docVC),createControllers(title: "Community", imageName: "community", vc: communityVC)]
        self.tabBar.barTintColor = UIColor(named: "tabBarColor")
        self.tabBar.tintColor = UIColor.white.withAlphaComponent(0.5)
        self.tabBar.unselectedItemTintColor = .white
        navigationController?.isNavigationBarHidden = true
    }
    
    private func createControllers(title: String, imageName: String, vc: UIViewController) -> UINavigationController{
        let recentVC = UINavigationController(rootViewController: vc)
        recentVC.tabBarItem.title = title
        recentVC.tabBarItem.image = UIImage(named: imageName)
        return recentVC
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = true
    }

}
