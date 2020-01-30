//
//  IntroSimplePageViewController.swift
//  Dipti
//
//  Created by Hadi Sharghi on 1/16/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit

protocol IntroSimplePage: UIViewController {
    func setLogo(image: UIImage)
    func setTextLogo(image: UIImage)
    func setMessage(message: String)
    func setBackgroundImage(image: UIImage)
}

extension IntroSimplePage {
    func setLogo(image: UIImage) { }
    func setTextLogo(image: UIImage) { }
    func setMessage(message: String) { }
    func setBackgroundImage(image: UIImage) { }
}


class SimpleIntroPageViewController: UIViewController, IntroSimplePage {
    func setTextLogo(image: UIImage) {
        logoImageView.image = image
    }
    
    func setMessage(message: String) {
        messageLabel.text = message
    }
    
    func setLogo(image: UIImage) {
        logoImageView.image = image
    }
    
    func setBackgroundImage(image: UIImage) {
        backgroundImageView.image = image
    }

    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var textImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    
    
}


class IntroPageFactory {
    
    class func createIntroPage(logoImage: UIImage? = nil,
                               textImage: UIImage? = nil,
                               message: String? = nil,
                               backgroundImage: UIImage? = nil) -> IntroSimplePage {
        
        let vc = UIStoryboard
            .init(name: "IntroStoryboard", bundle: nil)
            .instantiateViewController(identifier: String(describing: SimpleIntroPageViewController.self)) as? IntroSimplePage
        
        _ = vc?.view
        
        if let image = logoImage {
            vc?.setLogo(image: image)
        }
        if let image = textImage {
            vc?.setTextLogo(image: image)
        }
        if let message = message {
            vc?.setMessage(message: message)
        }
        if let image = backgroundImage {
            vc?.setBackgroundImage(image: image)
        }
        
        
        
        return vc!
    }
    
    
}
