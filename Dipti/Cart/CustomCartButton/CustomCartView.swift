//
//  CustomCart.swift
//  FoodCenter
//
//  Created by Hadi Sharghi on 4/5/1397 .
//  Copyright © 1397 SoftWorks. All rights reserved.
//

import UIKit
import QuartzCore

protocol CartButtonDelegate: class {
    func cartButtonTapped()
}

class CustomCartView: UIView {
    
    @IBOutlet private weak var badeLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet private weak var badgeView: UIView!
    weak var delegate: CartButtonDelegate?
    @IBOutlet weak var tapOnBadgeView: UITapGestureRecognizer!
    
    class func instanceFromNib(frame: CGRect) -> CustomCartView {
        let view = UINib(nibName: "CartButton", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CustomCartView
        view.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        return view
    }
    
    var badgeValue: Int = 0 {
        didSet {
            badeLabel.text = "\(badgeValue)".toFa()
        }
    }
    
    @IBAction func badgeViewTapped(_ sender: Any) {
        print("badge Tapped")
        if let _ = delegate {
            delegate?.cartButtonTapped()
        }
    }
    
    public func setBadgeValue(value: Int, pulse: Bool = true) {
        if (pulse) {
            pulseBadgeView(duration: 0.2, scale: 1.5)
        }
        self.badgeValue = value
    }
    
    func pulseBadgeView(duration: TimeInterval = 0.15, scale: Float) {
        let pulseAnimation:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.duration = duration
        pulseAnimation.toValue = NSNumber(value: scale)
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = 1
        badgeView.layer.add(pulseAnimation, forKey: nil)
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        print("*** cart button tapped ***")
        if let _ = delegate {
            delegate?.cartButtonTapped()
        }
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}

