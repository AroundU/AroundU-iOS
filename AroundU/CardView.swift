//
//  CardView.swift
//  AroundU
//
//  Created by Richer Archambault on 2017-03-04.
//  Copyright © 2017 LassondeHacks. All rights reserved.
//

import UIKit
import Material
import Stevia

class CardView: TableViewCell {
    var lastCard: Bool = false
    var post: Post!
    var card = Card()
    var top = Toolbar()
    var repliesLabel = UILabel()
    var votes = Toolbar()
    var dateFormatter = DateFormatter()
    
    override func prepare() {
        super.prepare()
        
        dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        
        renderCard()

    }
    
    func renderCard() {
        //Caption
        
        top.title = "Card Caption long enough to be cropped by the line break mode"
        top.titleLabel.textAlignment = .left
        top.titleLabel.lineBreakMode = .byTruncatingTail
        top.titleLabel.font = RobotoFont.regular(with: 14)
        //Date
        top.detail = dateFormatter.string(from: Date())
        top.detailLabel.textAlignment = .left
        top.detailLabel.textColor = Color.grey.base
        //Replies
        repliesLabel.textAlignment = .left
        repliesLabel.text = "15 replies"
        repliesLabel.textColor = Color.grey.base
        repliesLabel.font = RobotoFont.regular(with: 14)
        
        votes.title = "14 K"
        votes.titleLabel.textAlignment = .left
        votes.titleLabel.textColor = Color.grey.base
        votes.titleLabel.font = RobotoFont.regular(with: 12)
        
        card.toolbar = top
        card.toolbarEdgeInsetsPreset = .horizontally1
        card.toolbarEdgeInsets.bottom = 0
        card.toolbarEdgeInsets.right = 8
        
        card.contentView = repliesLabel
        card.bottomBar = votes
        card.contentViewEdgeInsetsPreset = .horizontally1
        card.bottomBarEdgeInsetsPreset = .horizontally1
        
        card.image = UIImage(named: "kk")

        
        card.height = 80
        
        sv(card)
        
        layout(card).horizontally(left: 10, right: 10).center()
        
    }
}

