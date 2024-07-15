//
//  MainTabBarController.swift
//  iMusic
//
//  Created by Сергей on 15.07.2024.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        view.backgroundColor = .white
        tabBar.tintColor = #colorLiteral(red: 1, green: 0.1719063818, blue: 0.4505617619, alpha: 1)
        viewControllers = [
            generateViewController(rootVC: SearchViewController(), image: UIImage(named: "search") ?? UIImage(), title: "Search"),
            generateViewController(rootVC: ViewController(), image: UIImage(named: "library") ?? UIImage(), title: "Library")
        ]
    }
    
    private func generateViewController(rootVC: UIViewController, image: UIImage, title: String) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootVC)
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.title = title
        rootVC.navigationItem.title = title
        navigationVC.navigationBar.prefersLargeTitles = true
        return navigationVC
    }
}
