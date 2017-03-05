//
//  ViewController.swift
//  AroundU
//
//  Created by Richer Archambault on 2017-03-04.
//  Copyright © 2017 LassondeHacks. All rights reserved.
//

import UIKit
import CoreLocation
import Material
import Stevia

class TabViewController: UIViewController, CLLocationManagerDelegate {
    var table: CardTable!
    var refreshControl: UIRefreshControl!
    
    var locationManager:CLLocationManager!
    var userLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        determineMyCurrentLocation()
        
        startUserLocation()
        
        table = CardTable()
        
        view.layout(table).edges()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "DataDidFinishLoading"), object: nil, queue: nil, using: DataDidFinishLoading)
        
        refreshControl = UIRefreshControl()
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.backgroundColor = .divider
        refreshControl.tintColor = .primaryText
        refreshControl.addTarget(self, action: #selector(self.refresh), for: UIControlEvents.valueChanged)
        table.addSubview(refreshControl)
    }
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestAlwaysAuthorization()
    }
    
    func startUserLocation(){
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func getUserLocation() -> CLLocation {
        return userLocation
    }
    
    func stopUserLocation(){
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            userLocation = locations[0] as CLLocation
            reloadData(userLocation)
    }
    
    func refresh(sender: AnyObject?) {
        reloadData(userLocation)
        refreshControl.endRefreshing()
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
    
    func reloadData(_ location: CLLocation) {}
    
    func DataDidFinishLoading(notification: Notification) {}
    
}

class HotViewController: TabViewController {
    override func preparePageTabBarItem() { pageTabBarItem.setImage(UIImage(named: "ic_whatshot"), for: .normal) }
    
    override func reloadData(_ location: CLLocation) {
        DispatchQueue.global().async {
            Connection.fetchHot(location: location)
        }

    }
    
    override func DataDidFinishLoading(notification: Notification) {
        table.posts = notification.userInfo?["posts"] as! [Post]
    }
}

class RecentViewController: TabViewController {
    override func preparePageTabBarItem() { pageTabBarItem.setImage(UIImage(named: "ic_schedule"), for: .normal) }
    
    override func reloadData(_ location: CLLocation) {
        DispatchQueue.global().async {
            Connection.fetchRecent(location: location)
        }
        
    }
    
    override func DataDidFinishLoading(notification: Notification) {
        table.posts = notification.userInfo?["posts"] as! [Post]
    }
}

class NearViewController: TabViewController {
    override func preparePageTabBarItem() { pageTabBarItem.setImage(UIImage(named: "ic_my_location"), for: .normal) }
    
    override func reloadData(_ location: CLLocation) {
        DispatchQueue.global().async {
            Connection.fetchNear(location: location)
        }
        
    }
    
    override func DataDidFinishLoading(notification: Notification) {
        table.posts = notification.userInfo?["posts"] as! [Post]
    }
}

class ArchivedViewController: TabViewController {
    override func preparePageTabBarItem() { pageTabBarItem.setImage(UIImage(named: "ic_person"), for: .normal) }
    
    override func reloadData(_ location: CLLocation) {
        DispatchQueue.global().async {
            Connection.fetchArchived(location: location)
        }
        
    }
    
    override func DataDidFinishLoading(notification: Notification) {
        table.posts = notification.userInfo?["posts"] as! [Post]
    }
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

