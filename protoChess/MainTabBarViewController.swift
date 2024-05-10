//
//  ViewController.swift
//  protoChess
//
//  Created by alexandre VINCENT on 01/05/2024.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    let username : String

    init(username: String) {
        self.username = username
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let bluryBot = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        let vc1 = UINavigationController(rootViewController: HomeViewController(username: username))
        let vc2 = UINavigationController(rootViewController: GamesHistoryViewController(username: username))
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc1.title = "Home"
        
        vc2.tabBarItem.image = UIImage(systemName: "list.bullet")
        vc2.title = "Games History"

        tabBar.tintColor = UIColor(named: "TextColor")
        bluryBot.frame = view.bounds
        tabBar.addSubview(bluryBot)
        tabBar.sendSubviewToBack(bluryBot)
        setViewControllers([vc1, vc2], animated: true)
    }


}

