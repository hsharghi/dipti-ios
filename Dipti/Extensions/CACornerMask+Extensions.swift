//
//  CAMask+Extensions.swift
//  Dipti
//
//  Created by Hadi Sharghi on 4/8/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit


public extension CACornerMask {
    
    static var allCorners: CACornerMask {
        return [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
    }
    
    static var topCorners: CACornerMask {
        return [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    static var bottomCorners: CACornerMask {
        return [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    static var leftCorners: CACornerMask {
        return [.layerMinXMaxYCorner, .layerMinXMinYCorner]
    }
    
    static var rightCorners: CACornerMask {
        return [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
    }
}
