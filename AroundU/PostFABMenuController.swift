//
//  FABMenuController.swift
//  AroundU
//
//  Created by Richer Archambault on 2017-03-05.
//  Copyright © 2017 LassondeHacks. All rights reserved.
//

import UIKit
import Material

class PostFABMenuController: FABMenuController {
    let fabMenuSize = CGSize(width: 56, height: 56)
    
    var fabButton: FABButton!
    var photoItem: FABMenuItem!
    var textItem: FABMenuItem!
    
     override func prepare() {
        super.prepare()
        view.backgroundColor = .white
        
        prepareFABButton()
        preparePhotoItem()
        prepareTextItem()
        prepareFABMenu()
    }

     func prepareFABButton() {
        fabButton = FABButton(image: Icon.cm.add, tintColor: .white)
        fabButton.pulseColor = .white
        fabButton.backgroundColor = .accent
    }
    
     func preparePhotoItem() {
        photoItem = FABMenuItem()
        photoItem.fabButton.image = Icon.cm.photoCamera
        photoItem.fabButton.tintColor = .white
        photoItem.fabButton.pulseColor = .white
        photoItem.fabButton.backgroundColor = .divider
        photoItem.fabButton.addTarget(self, action: #selector(handlePhotoItem(button:)), for: .touchUpInside)
    }
    
    func prepareTextItem() {
        textItem = FABMenuItem()
        textItem.fabButton.image = Icon.cm.pen
        textItem.fabButton.tintColor = .white
        textItem.fabButton.pulseColor = .white
        textItem.fabButton.backgroundColor = .divider
        textItem.fabButton.addTarget(self, action: #selector(handleTextItem(button:)), for: .touchUpInside)
    }
    
     func prepareFABMenu() {
        fabMenu.fabButton = fabButton
        fabMenu.fabMenuItems = [photoItem, textItem]
        
        view.layout(fabMenu)
            .size(fabMenuSize)
            .bottom(24)
            .center()
    }

    @objc
     func handleVideoItem(button: UIButton) {
        //        transition(to: NotesViewController())
        fabMenu.close()
        //        fabMenu.fabButton?.animate(animation: Motion.rotate(angle: 0))
    }
    
    @objc
    func handlePhotoItem(button: UIButton) {
        //        transition(to: NotesViewController())
        fabMenu.close()
        //        fabMenu.fabButton?.animate(animation: Motion.rotate(angle: 0))
    }
    
    @objc
    func handleTextItem(button: UIButton) {
        //        transition(to: NotesViewController())
        fabMenu.close()
        //        fabMenu.fabButton?.animate(animation: Motion.rotate(angle: 0))
    }

    @objc
     func fabMenuWillOpen(fabMenu: FABMenu) {
        //        fabMenu.fabButton?.animate(animation: Motion.rotate(angle: 45))
        
        print("fabMenuWillOpen")
    }
    
    @objc
     func fabMenuDidOpen(fabMenu: FABMenu) {
        print("fabMenuDidOpen")
    }
    
    @objc
     func fabMenuWillClose(fabMenu: FABMenu) {
        //        fabMenu.fabButton?.animate(animation: Motion.rotate(angle: 0))
        
        print("fabMenuWillClose")
    }
    
    @objc
     func fabMenuDidClose(fabMenu: FABMenu) {
        print("fabMenuDidClose")
    }
    
    @objc
     func fabMenu(fabMenu: FABMenu, tappedAt point: CGPoint, isOutside: Bool) {
        print("fabMenuTappedAtPointIsOutside", point, isOutside)
        
        guard isOutside else {
            return
        }
    }
}
