//
//  AppDelegate.swift
//  AroundU
//
//  Created by Richer Archambault on 2017-03-04.
//  Copyright © 2017 LassondeHacks. All rights reserved.
//

import UIKit
import Material

struct defaultsKeys {
    static let username = "username"
    static let password = "password"
    static let cookie = "Cookie"
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    open class var darkPrimary : UIColor {
        return UIColor(red: 22,green: 137,blue: 206)
    }
    
    open class var primary : UIColor {
        return UIColor(red: 30,green: 170,blue: 241)
    }
    
    open class var lightPrimary : UIColor {
        return UIColor(red: 181,green: 229,blue: 251)
    }
    
    open class var accent : UIColor {
        return UIColor(red: 252,green: 88,blue: 48)
    }
    
    open class var primaryText : UIColor {
        return UIColor(red: 33,green: 33,blue: 33)
    }
    
    open class var secondaryText : UIColor {
        return UIColor(red: 117,green: 117,blue: 117)
    }
    
    open class var divider : UIColor {
        return UIColor(red: 189,green: 189,blue: 189)
    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var loggedIn : Bool {
        let defaults = UserDefaults.standard
        if (defaults.string(forKey: defaultsKeys.username) != nil && defaults.string(forKey: defaultsKeys.password) != nil) {
            Connection.connect()
            return true
        }
        return false
    }
    var created: Bool = false
    var loginViewController: LoginViewController!
    var mainViewController: MainViewController!
    var loginToolbarController: LoginToolbarController!
    var mainToolbarController: AppToolbarController!
    var postFABMenu: PostFABMenuController!


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: Screen.bounds)
        
        loginViewController = LoginViewController()
        loginToolbarController = LoginToolbarController(rootViewController: loginViewController)
        if(!loggedIn) {
            window?.rootViewController = loginToolbarController
        } else {
            renderMainViewController()
        }
        window?.makeKeyAndVisible()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "loggedIn"), object: nil, queue: nil, using: switchToMainViewController)
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "CameraShoulClose"), object: nil, queue: nil, using: closeCamera)
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "CameraShoulOpen"), object: nil, queue: nil, using: closeCamera)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {}
    
    func closeCamera(notification: Notification) {
        UIView.transition(with: window!, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: { Void in
            self.window?.rootViewController = self.mainToolbarController
        }, completion: nil)
    }
    
    func openCamera(notification: Notification) {
        UIView.transition(with: window!, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: { Void in
            self.window?.rootViewController = AppCaptureController(rootViewController: CameraViewController())
        }, completion: nil)
    }

    func switchToMainViewController(notification: Notification) {
        renderMainViewController()
    }
    
    func renderMainViewController() {
        if(!created) {
            mainViewController = MainViewController()
            mainToolbarController = AppToolbarController(rootViewController: mainViewController)
            postFABMenu = PostFABMenuController(rootViewController: mainToolbarController)
            created = true
        }
        
        UIView.transition(with: window!, duration: 0.5, options: UIViewAnimationOptions.transitionFlipFromRight, animations: { Void in
            self.window?.rootViewController = self.postFABMenu
        }, completion: nil)
    }

}

