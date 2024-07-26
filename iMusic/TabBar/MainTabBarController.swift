//
//  MainTabBarController.swift
//  iMusic
//
//  Created by Сергей on 15.07.2024.
//

import UIKit
import SwiftUI

protocol MainTabBarControllerDelegate: AnyObject {
    func minimizeTrackDetailView()
    func maximizeTrackDetailView(view: SearchViewModel.Cell?)
}

final class MainTabBarController: UITabBarController {
    
    private var minimizedTopAnchorConstraint: NSLayoutConstraint!
    private var maximizedTopAnchorConstraint: NSLayoutConstraint!
    private var minBottomAnchorConstraint: NSLayoutConstraint!
    private var maxBottomAnchorConstraint: NSLayoutConstraint!
    
    let searchVC: SearchViewController = SearchViewController.loadFromStoryboard()
    let trackDetailView: TrackDetailView = TrackDetailView.loadFromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchVC.tabBarDelegate = self
        setupTabBar()
        setupTrackDetailView()
        
    }
    
    private func setupTabBar() {
        let library = Library()
        let hostVC = UIHostingController(rootView: library)
        view.backgroundColor = .white
        tabBar.tintColor = #colorLiteral(red: 1, green: 0.1719063818, blue: 0.4505617619, alpha: 1)
        viewControllers = [
            generateViewController(rootVC: searchVC, image: UIImage(named: "search") ?? UIImage(), title: "Search"),
           hostVC
        ]
        hostVC.tabBarItem.image = UIImage(named: "library")
        hostVC.tabBarItem.title = "Library"
        
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
       
        trackDetailView.tabBarDelegate = self
        trackDetailView.delegate = searchVC
        view.insertSubview(trackDetailView, belowSubview: tabBar)
        
        //use autolayout
        trackDetailView.translatesAutoresizingMaskIntoConstraints = false
        
        minimizedTopAnchorConstraint = trackDetailView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -64)
        maximizedTopAnchorConstraint = trackDetailView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height)
        minBottomAnchorConstraint = trackDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height)
        maxBottomAnchorConstraint = trackDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        NSLayoutConstraint.activate([
            maximizedTopAnchorConstraint,
            minBottomAnchorConstraint,
            trackDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trackDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
    }
}

//MARK: - MainTabBarControllerDelegate
extension MainTabBarController: MainTabBarControllerDelegate {
    func maximizeTrackDetailView(view: SearchViewModel.Cell?) {
        
        minimizedTopAnchorConstraint.isActive = false
        maximizedTopAnchorConstraint.isActive = true
        maximizedTopAnchorConstraint.constant = 0
        
        minBottomAnchorConstraint.isActive = false
        maxBottomAnchorConstraint.isActive = true
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut) {
            self.view.layoutIfNeeded()
            self.tabBar.alpha = 0
            self.trackDetailView.miniTrackView.alpha = 0
            self.trackDetailView.maximizedStackView.alpha = 1
        }
        
        guard let viewModel = view else { return }
        self.trackDetailView.set(viewModel: viewModel)
    }
    
    func minimizeTrackDetailView() {
        maxBottomAnchorConstraint.isActive = false
        minBottomAnchorConstraint.isActive = true
        maximizedTopAnchorConstraint.isActive = false
        minimizedTopAnchorConstraint.isActive = true
        
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut) {
            self.view.layoutIfNeeded()
            self.tabBar.alpha = 1
            self.trackDetailView.miniTrackView.alpha = 1
            self.trackDetailView.maximizedStackView.alpha = 0

        }
    }
    
    
}
