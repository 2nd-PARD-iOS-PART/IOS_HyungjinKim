//
//  MainTapBar.swift
//  3rd_redo
//
//  Created by hyungjin kim on 2023/10/07.
//

import UIKit

class MainTapBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        let vc1 = UINavigationController(rootViewController: HomePage())
        let vc2 = UINavigationController(rootViewController: SearchPage())
        let vc3 = UINavigationController(rootViewController: ComingSoonPage())
        let vc4 = UINavigationController(rootViewController: DownloadsPage())
        let vc5 = UINavigationController(rootViewController: MorePage())

        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc3.tabBarItem.image = UIImage(systemName: "play.rectangle.on.rectangle")
        vc4.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        vc5.tabBarItem.image = UIImage(systemName: "line.3.horizontal")

        vc1.title = "Home"
        vc2.title = "Search"
        vc3.title = "Coming Soon"
        vc4.title = "Downloads"
        vc5.title = "More"
        
        tabBar.tintColor = .white
        setViewControllers([vc1, vc2, vc3, vc4, vc5], animated: true)
    }
}
