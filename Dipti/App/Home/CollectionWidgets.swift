//
//  CollectionWidgetFullWidth.swift
//  Dipti
//
//  Created by Hadi Sharghi on 1/22/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit
import UIImageColors

protocol CollectionWidgetDelegate: UIViewController {
    func viewButtonTapped(identifier: String)
    func backgroundImageTapped(identifier: String)
}

extension CollectionWidgetDelegate {
    func backgroundImageTapped(identifier: String) { }
}

class CollectionFullWidthWidget: UIViewController, UIImageViewObserverDelegate {
    
    @IBOutlet weak var viewAllButton: UIButton!
    @IBOutlet weak var backgroundImageView: ObservableImageView!
    @IBOutlet weak var collectionLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    var backgroundImage: UIImage?
    var identifier: String = "fullWidget"
    weak var delegate: CollectionWidgetDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewAllButton.rounded(color: .clear, width: 1, paddingX: 0, paddingY: 0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        backgroundImageView.delegate = self
        backgroundImageView.image = backgroundImage
    }
    
    func imageDidSet(image: UIImage?, colors: UIImageColors?) {
            AppHelper.addGradientLayer(to: self.backgroundImageView,
                                       startColor: colors?.background ?? .clear,
                                       endColor: .clear,
                                       startPoint: CGPoint(x: 0, y: 0.5),
                                       endPoint: CGPoint(x: 0.8, y: 0.5))
    }
    
    @IBAction func viewAllButtonTapped(_ sender: Any) {
        delegate?.viewButtonTapped(identifier: identifier)
    }
    
    func imageTapped(_ sender: Any) {
        delegate?.backgroundImageTapped(identifier: identifier)
    }

    
    
}

class CollectionHalfWidthWidget: UIViewController {
    
    @IBOutlet weak var viewAllButton: UIButton!
    @IBOutlet weak var backgroundImageView: ObservableImageView!
    @IBOutlet weak var collectionLabel: UILabel!
    
    var identifier: String = "halfWidget"
    weak var delegate: CollectionWidgetDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewAllButton.rounded(color: .clear, width: 1, paddingX: 0, paddingY: 0)

    }
        
    @IBAction func viewAllButtonTapped(_ sender: Any) {
        delegate?.viewButtonTapped(identifier: identifier)
    }
}



protocol UIImageViewObserverDelegate: class {
    func imageDidSet(image: UIImage?, colors: UIImageColors?)
    func imageTapped(_ sender: Any)
}


import Cachy

class ObservableImageView: UIImageView {
    
    weak var delegate: UIImageViewObserverDelegate?
    var imageFile: UIImage?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let imageFile = imageFile {
            self.image = imageFile
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true
    }
    
    @objc private func imageTapped(_ sender: Any) {
        print("tapped")
        delegate?.imageTapped(sender)
    }
    
    override var image: UIImage? {
        didSet {
            super.image = image
            if let key = image?.md5,
                let colors: UIImageColors = AppData.cacheManager.get(key: key, as: UIImageColors.self, { () -> UIImageColors? in
                    self.image?.getColors()
                })
            {
                self.delegate?.imageDidSet(image: self.image, colors: colors)
                return
            }
        }
    }
}
