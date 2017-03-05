//
//  LoginViewController.swift
//  AroundU
//
//  Created by Richer Archambault on 2017-03-04.
//  Copyright © 2017 LassondeHacks. All rights reserved.
//

import UIKit
import Material
import Stevia

class LoginViewController: UIViewController, TextFieldDelegate {
    
    lazy var loginView = LoginView()
    lazy var registerView = RegisterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = loginView
        
        hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "wantToLogin"), object: nil, queue: nil, using: switchToLogin)
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "wantToRegister"), object: nil, queue: nil, using: switchToRegister)
    }
    
    func switchToLogin(notification: Notification) -> Void {
        UIView.transition(with: (UIApplication.shared.delegate as! AppDelegate).window!, duration: 0.5, options: UIViewAnimationOptions.transitionFlipFromRight, animations: { Void in
            self.view = self.loginView
        }, completion: nil)
    }
    
    func switchToRegister(notification: Notification) -> Void {
        UIView.transition(with: (UIApplication.shared.delegate as! AppDelegate).window!, duration: 0.5, options: UIViewAnimationOptions.transitionFlipFromRight, animations: { Void in
            self.view = self.registerView
        }, completion: nil)
    }
}
