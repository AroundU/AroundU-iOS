//
//  LoginToolbarController.swift
//  AroundU
//
//  Created by Richer Archambault on 2017-03-04.
//  Copyright © 2017 LassondeHacks. All rights reserved.
//

import UIKit
import Material

class LoginToolbarController: ToolbarController {
    
    override func prepare() {
        super.prepare()
        prepareStatusBar()
        prepareToolbarStyle()
    }
    
    func prepareStatusBar() {
        statusBarStyle = .lightContent
        statusBar.backgroundColor = .darkPrimary
    }
    
    func prepareToolbarStyle() {
        toolbar.depthPreset = .none
        toolbar.backgroundColor = .white
    }
}

