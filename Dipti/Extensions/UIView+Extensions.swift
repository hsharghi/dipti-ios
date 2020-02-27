//
//  UIView+Extensions.swift
//  RAF
//
//  Created by Hadi Sharghi on 4/4/1397 .
//  Copyright © 1397 Hadi Sharghi. All rights reserved.
//

import UIKit

extension UIView {
    
    func pinEdges(to other: UIView) {
        leadingAnchor.constraint(equalTo: other.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: other.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: other.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: other.bottomAnchor).isActive = true
    }
    
    
    // Example use: myView.addBorder(toSide: .Left, withColor: UIColor.redColor().CGColor, andThickness: 1.0)
    
    enum ViewSide {
        case Left, Right, Top, Bottom
    }
    
    func addBorder(toSide side: ViewSide, withColor color: UIColor, andThickness thickness: CGFloat) {
        
        let border = CALayer()
        border.backgroundColor = color.cgColor
        
        switch side {
        case .Left: border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height); break
        case .Right: border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height); break
        case .Top: border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness); break
        case .Bottom: border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness); break
        }
        
        self.layer.addSublayer(border)
    }
    
    
    @objc func rounded(color: UIColor? = nil, width: CGFloat = 1, paddingX: CGFloat = 0, paddingY: CGFloat = 0) {
        self.frame.size.width += paddingX
        self.frame.size.height += paddingY
        let lenght = min(self.bounds.height, self.bounds.width)
        self.layer.cornerRadius = lenght / 2
        if color != nil {
            self.layer.borderColor = color?.cgColor
        }
        self.layer.borderWidth = width
        self.clipsToBounds = true
    }
    
    func roundConrners(masks: CACornerMask, radius: CGFloat, color: UIColor? = nil) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        if let color = color {
            self.layer.borderColor = color.cgColor
        } else {
            self.layer.borderColor = UIColor.clear.cgColor
        }
        
        if self.layer.borderWidth == 0 {
            self.layer.borderWidth = 1
        }
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = masks
            
        } else {
            // Fallback on earlier versions
            //            func roundedButton(){
            //                let maskPath1 = UIBezierPath(roundedRect: bounds,
            //                                             byRoundingCorners: [.topLeft , .topRight],
            //                                             cornerRadii: CGSize(width: 8, height: 8))
            //                let maskLayer1 = CAShapeLayer()
            //                maskLayer1.frame = bounds
            //                maskLayer1.path = maskPath1.cgPath
            //                layer.mask = maskLayer1
            //            }
            
        }
    }
    
    //    func roundCorners(corners: UIRectCorner, radiusWidth: CGFloat, radiusHeight: CGFloat) {
    //        self.clipsToBounds = true
    //        let path = UIBezierPath(roundedRect: self.bounds,
    //                                byRoundingCorners: corners,
    //                                cornerRadii: CGSize(width: radiusWidth, height: radiusHeight))
    //
    //        let maskLayer = CAShapeLayer()
    //        maskLayer.path = path.cgPath
    //
    //        self.layer.mask = maskLayer
    //    }
    //
    
    func createGradientLayer(color1: UIColor, color2: UIColor, startPoint: CGPoint = CGPoint(x: 0,y: 0), endPoint: CGPoint = CGPoint(x:1.0,y:1.0)) {
        var gradientLayer: CAGradientLayer!
        
        gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.bounds
        
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        
        
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.zPosition = -1
        self.layer.addSublayer(gradientLayer)
    }
    
    var heightConstraint: NSLayoutConstraint? {
        get {
            return constraints.filter {
                if $0.firstAttribute == .height, $0.relation == .equal {
                    return true
                }
                return false
                }.first
        }
        set{ setNeedsLayout() }
    }
    
    var widthConstraint: NSLayoutConstraint? {
        get {
            return constraints.filter {
                if $0.firstAttribute == .width, $0.relation == .equal {
                    return true
                }
                return false
                }.first
        }
        set{ setNeedsLayout() }
    }
    
    fileprivate var bezierPathIdentifier:String { return "bezierPathBorderLayer" }
    
    fileprivate var bezierPathBorder:CAShapeLayer? {
        return (self.layer.sublayers?.filter({ (layer) -> Bool in
            return layer.name == self.bezierPathIdentifier && (layer as? CAShapeLayer) != nil
        }) as? [CAShapeLayer])?.first
    }
    
    func bezierPathBorder(_ color:UIColor = .white, width:CGFloat = 1) {
        
        var border = self.bezierPathBorder
        let path = UIBezierPath(roundedRect: self.bounds, cornerRadius:self.layer.cornerRadius)
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        
        if (border == nil) {
            border = CAShapeLayer()
            border!.name = self.bezierPathIdentifier
            self.layer.addSublayer(border!)
        }
        
        border!.frame = self.bounds
        let pathUsingCorrectInsetIfAny =
            UIBezierPath(roundedRect: border!.bounds, cornerRadius:self.layer.cornerRadius)
        
        border!.path = pathUsingCorrectInsetIfAny.cgPath
        border!.fillColor = UIColor.clear.cgColor
        border!.strokeColor = color.cgColor
        border!.lineWidth = width * 2
    }
    
    func removeBezierPathBorder() {
        self.layer.mask = nil
        self.bezierPathBorder?.removeFromSuperlayer()
    }
    

}

public extension UIAlertController {
    func show() {
        let win = UIWindow(frame: UIScreen.main.bounds)
        let vc = UIViewController()
        vc.view.backgroundColor = .clear
        win.rootViewController = vc
        win.windowLevel = UIWindow.Level.alert + 1
        win.makeKeyAndVisible()
        vc.present(self, animated: true, completion: nil)
    }
}



protocol Bluring {
    func addBlur(_ alpha: CGFloat)
}

extension Bluring where Self: UIView {
    func addBlur(_ alpha: CGFloat = 0.5) {
        // create effect
        let effect = UIBlurEffect(style: .dark)
        let effectView = UIVisualEffectView(effect: effect)

        // set boundry and alpha
        effectView.frame = self.bounds
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        effectView.alpha = alpha

        self.addSubview(effectView)
    }
}

// Conformance
extension UIView: Bluring {}
