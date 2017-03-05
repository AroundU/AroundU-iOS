//
//  AppToolbarController.swift
//  AroundU
//
//  Created by Richer Archambault on 2017-03-04.
//  Copyright © 2017 LassondeHacks. All rights reserved.
//

import UIKit
import Material

class AppToolbarController: ToolbarController {
    
    var menuButton : IconButton!
    
    override func prepare() {
        super.prepare()
        prepareMenuButton()
        prepareStatusBar()
        prepareToolbarStyle()
    }
    
    func prepareMenuButton() {
        menuButton = IconButton(image: Icon.cm.menu, tintColor: .white)
        menuButton.pulseColor = .white
    }
    
    func prepareStatusBar() {
        statusBarStyle = .lightContent
        statusBar.backgroundColor = .darkPrimary
    }
    
    func prepareToolbarStyle() {
        toolbar.depthPreset = .none
        toolbar.backgroundColor = .primary
        
        toolbar.title = "AroundU"
        toolbar.titleLabel.textColor = .white
        toolbar.titleLabel.textAlignment = .center
        
        toolbar.detailLabel.textColor = .white
        toolbar.detailLabel.textAlignment = .center
        
        toolbar.leftViews = [menuButton]
    }
    
    func sendMediaPost() {
        
    }
    
    func sendCaptionPost() {
        
    }
    
}

