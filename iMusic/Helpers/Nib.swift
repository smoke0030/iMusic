//
//  Nib.swift
//  iMusic
//
//  Created by Сергей on 19.07.2024.
//

import UIKit


//расширение на получение экрана из xib файла
extension UIView {
    class func loadFromNib<T:UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)?[0] as! T
    }
}
