//
//  UIStroyboard+Extension.swift
//  Dipti
//
//  Created by Hadi Sharghi on 2/22/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

extension UIStoryboard {
    func instantiateVC<T: UIViewController>() -> T? {
        // get a class name and demangle for classes in Swift
        if let name = NSStringFromClass(T.self).components(separatedBy: ".").last {
            return instantiateViewController(withIdentifier: name) as? T
        }
        return nil
    }

}
