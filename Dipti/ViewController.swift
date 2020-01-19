//
//  ViewController.swift
//  Dipti
//
//  Created by Hadi Sharghi on 1/16/20.
//  Copyright © 2020 Hadi Sharghi. All rights reserved.
//

import UIKit
import SideMenu

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupSideMenu()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        

    }

    private func setupSideMenu() {
        
        SideMenuFactory.shared.setLeftMenu()
        
    }
    
    
    private func updateUI(settings: SideMenuSettings) {
//        let styles:[UIBlurEffect.Style] = [.dark, .light, .extraLight]
//        if let menuBlurEffectStyle = settings.blurEffectStyle {
//            blurSegmentControl.selectedSegmentIndex = (styles.firstIndex(of: menuBlurEffectStyle) ?? 0) + 1
//        } else {
//            blurSegmentControl.selectedSegmentIndex = 0
//        }
//
//        blackOutStatusBar.isOn = settings.statusBarEndAlpha > 0
//        menuAlphaSlider.value = Float(settings.presentationStyle.menuStartAlpha)
//        menuScaleFactorSlider.value = Float(settings.presentationStyle.menuScaleFactor)
//        presentingAlphaSlider.value = Float(settings.presentationStyle.presentingEndAlpha)
//        presentingScaleFactorSlider.value = Float(settings.presentationStyle.presentingScaleFactor)
//        screenWidthSlider.value = Float(settings.menuWidth / min(view.frame.width, view.frame.height))
//        shadowOpacitySlider.value = Float(settings.presentationStyle.onTopShadowOpacity)
    }

}

