//
//  FooterView.swift
//  iMusic
//
//  Created by Сергей on 17.07.2024.
//

import UIKit

final class FooterView: UIView {
    
    private var myLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.6919150949, green: 0.7063220143, blue: 0.7199969292, alpha: 1)
        return label
    }()
    
    private var loader: UIActivityIndicatorView = {
       let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        return loader
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupElements() {
        [myLabel, loader].forEach {
            addSubview($0)
        }
        
        
        NSLayoutConstraint.activate([
            loader.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            loader.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            loader.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            myLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            myLabel.topAnchor.constraint(equalTo: loader.bottomAnchor, constant: 8)
        ])
    }
    
    func showLoader() {
        loader.startAnimating()
        myLabel.text = "Loading"
    }
    
    func hideLoader() {
        loader.stopAnimating()
        myLabel.text = ""
    }
    
}
