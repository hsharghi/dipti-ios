//
//  CollectionWidgetFullWidth.swift
//  Dipti
//
//  Created by Hadi Sharghi on 1/22/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit
import UIImageColors

class CollectionFullWidthWidget: UIViewController, UIImageViewObserverDelegate {
    
    @IBOutlet weak var viewAllButton: UIButton!
    @IBOutlet weak var backgroundImageView: ObservableImageView!
    @IBOutlet weak var collectionLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewAllButton.rounded(color: .clear, width: 1, paddingX: 0, paddingY: 0)
        backgroundImageView.delegate = self
    }
    
    func imageDidSet(image: UIImage?, colors: UIImageColors?) {
        
        AppHelper.addGradientLayer(to: backgroundImageView, startColor: colors?.background ?? .clear, endColor: .clear, startPoint: CGPoint(x: 0, y: 0.5), endPoint: CGPoint(x: 0.5, y: 0.5))
    }
    
    
    
}

class CollectionHalfWidthWidget: UIViewController {
    
    @IBOutlet weak var viewAllButton: UIButton!
    @IBOutlet weak var backgroundImageView: ObservableImageView!
    @IBOutlet weak var collectionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewAllButton.rounded(color: .clear, width: 1, paddingX: 0, paddingY: 0)

    }
        
}



protocol UIImageViewObserverDelegate: class {
    func imageDidSet(image: UIImage?, colors: UIImageColors?)
}

class ObservableImageView: UIImageView {
    
    weak var delegate: UIImageViewObserverDelegate?
    
    override var image: UIImage? {
        didSet {
            super.image = image
            image?.getColors({ (colors) in
                self.delegate?.imageDidSet(image: self.image, colors: colors)
            })
        }
    }
    
}
