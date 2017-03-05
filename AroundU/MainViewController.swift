//
//  ViewController.swift
//  AroundU
//
//  Created by Richer Archambault on 2017-03-04.
//  Copyright © 2017 LassondeHacks. All rights reserved.
//

import UIKit
import Material

class TabViewController: UIViewController {
    var table: CardTable!
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        table = CardTable()
        
        view.layout(table).edges()
        
        table.posts = [Post(), Post()]
        
        refreshControl = UIRefreshControl()
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.backgroundColor = .divider
        refreshControl.tintColor = .primaryText
        refreshControl.addTarget(self, action: #selector(self.refresh), for: UIControlEvents.valueChanged)
        table.addSubview(refreshControl)
    }
    
    func refresh(sender: AnyObject?) {
        reloadData()
        refreshControl.endRefreshing()
    }
    
    func reloadData() {
        table.posts = [Post(), Post()]
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        preparePageTabBarItem()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        preparePageTabBarItem()
    }
    
    func preparePageTabBarItem() {}
    
}

class HotViewController: TabViewController {
    override func preparePageTabBarItem() { pageTabBarItem.setImage(UIImage(named: "ic_whatshot"), for: .normal) }
}

class RecentViewController: TabViewController {
    override func preparePageTabBarItem() { pageTabBarItem.setImage(UIImage(named: "ic_schedule"), for: .normal) }
}

class NearViewController: TabViewController {
    override func preparePageTabBarItem() { pageTabBarItem.setImage(UIImage(named: "ic_my_location"), for: .normal) }
}

class ArchivedViewController: TabViewController {
    override func preparePageTabBarItem() { pageTabBarItem.setImage(UIImage(named: "ic_person"), for: .normal) }
}

class MainViewController: PageTabBarController {
    
    public init() {
        
        var viewControllers = [UIViewController]()
        
        viewControllers.append(HotViewController())
        viewControllers.append(RecentViewController())
        viewControllers.append(NearViewController())
        viewControllers.append(ArchivedViewController())
        
        super.init(viewControllers: viewControllers)
    }

    open override func prepare() {
        super.prepare()
        view.backgroundColor = UIColor.white
        
        delegate = self
        preparePageTabBar()
    }
    
    func preparePageTabBar() {
        pageTabBarAlignment = .top
        pageTabBar.dividerColor = nil
        pageTabBar.lineColor = .lightPrimary
        pageTabBar.lineAlignment = .bottom
        pageTabBar.backgroundColor = .primary
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension MainViewController : PageTabBarControllerDelegate {
    func pageTabBarController(pageTabBarController: PageTabBarController, didTransitionTo viewController: UIViewController) {
        print("pageTabBarController", pageTabBarController, "didTransitionTo viewController:", viewController)
    }
}

