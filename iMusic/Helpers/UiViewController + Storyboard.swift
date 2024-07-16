//
//  UiViewController + Storyboard.swift
//  iMusic
//
//  Created by Сергей on 16.07.2024.
//

import UIKit

extension UIViewController {
    
    class func loadFromStoryboard<T: UIViewController>() -> T {
        let name = String(describing: T.self)
        let stodyboard = UIStoryboard(name: name, bundle: nil)
        if let viewController = stodyboard.instantiateInitialViewController() as? T {
            return viewController
        } else {
            fatalError("No initial view controller in \(name) storyboard")
        }
    }
    
}
