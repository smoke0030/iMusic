//
//  MainTabBarController.swift
//  iMusic
//
//  Created by Сергей on 15.07.2024.
//

import UIKit

protocol MainTabBarControllerDelegate: AnyObject {
    func minimizeTrackDetailView()
}

final class MainTabBarController: UITabBarController {
    
    private var minimizedTopAnchorConstraint: NSLayoutConstraint!
    private var maximizedTopAnchorConstraint: NSLayoutConstraint!
    private var minBottomAnchorConstraint: NSLayoutConstraint!
    private var maxBottomAnchorConstraint: NSLayoutConstraint!
    
    let searchVC: SearchViewController = SearchViewController.loadFromStoryboard()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupTrackDetailView()
        
    }
    
    private func setupTabBar() {
        view.backgroundColor = .white
        tabBar.tintColor = #colorLiteral(red: 1, green: 0.1719063818, blue: 0.4505617619, alpha: 1)
        viewControllers = [
            generateViewController(rootVC: searchVC, image: UIImage(named: "search") ?? UIImage(), title: "Search"),
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
    
    private func setupTrackDetailView() {
        let trackDetailView: TrackDetailView = TrackDetailView.loadFromNib()
        trackDetailView.tabBarDelegate = self
        trackDetailView.delegate = searchVC
        trackDetailView.backgroundColor = .red
        view.insertSubview(trackDetailView, belowSubview: tabBar)
        
        //use autolayout
        trackDetailView.translatesAutoresizingMaskIntoConstraints = false
        
        minimizedTopAnchorConstraint = trackDetailView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -64)
        maximizedTopAnchorConstraint = trackDetailView.topAnchor.constraint(equalTo: view.topAnchor)
        minBottomAnchorConstraint = trackDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height)
        maxBottomAnchorConstraint = trackDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        NSLayoutConstraint.activate([
            maximizedTopAnchorConstraint,
            maxBottomAnchorConstraint,
            trackDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trackDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
    }
}

//MARK: - MainTabBarControllerDelegate
extension MainTabBarController: MainTabBarControllerDelegate {
    func minimizeTrackDetailView() {
        
        maximizedTopAnchorConstraint.isActive = false
        minimizedTopAnchorConstraint.isActive = true
        maxBottomAnchorConstraint.isActive = false
        minBottomAnchorConstraint.isActive = true
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut) {
            self.view.layoutIfNeeded()
        }
    }
    
    
}
