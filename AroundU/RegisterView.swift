//
//  RegisterView.swift
//  AroundU
//
//  Created by Richer Archambault on 2017-03-04.
//  Copyright © 2017 LassondeHacks. All rights reserved.
//

import UIKit
import Material
import Stevia

class RegisterView:UIView, TextFieldDelegate {
    let username = ErrorTextField()
    let email = ErrorTextField()
    let password = TextField()
    let signup = RaisedButton()
    let loginLabel = UILabel()
    let login = FlatButton()
    
    convenience init() {
        self.init(frame:CGRect.zero)
        
        render()
    }
    
    
    func render() {
        backgroundColor = Color.white
        
        sv(
            username.style(textFieldStyle).style(userFieldStyle),
            email.style(textFieldStyle).style(emailFieldStyle),
            password.style(textFieldStyle).style(passwordFieldStyle),
            signup.text("Register").style(buttonSytle).tap(registerTapped),
            loginLabel.text("Already registered? ").style(labelSytle),
            login.text("Login Now").style(labelButtonSytle).tap(wantToLogin)
            
        )
        
        layout(
            <=100,
            |-24-username-24-| ~ 40,
            24,
            |-24-email-24-| ~ 40,
            24,
            |-24-password-24-| ~ 40,
            48,
            |-24-signup-24-| ~ 40,
            24,
            |-24-loginLabel-1-login ~ 40
        )
    }
    
    func textFieldStyle(_ f: TextField) {
        f.delegate = self
        f.placeholderNormalColor = .secondaryText
        f.placeholderActiveColor = .primary
        f.dividerNormalColor = .divider
        f.dividerActiveColor = .primary
    }
    
    func userFieldStyle(_ f:ErrorTextField) {
        f.keyboardType = .default
        
        f.placeholder = "Username"
        f.detail = "Error, incorrect username"
        f.isClearIconButtonEnabled = true
    }
    
    func emailFieldStyle(_ f:ErrorTextField) {
        f.keyboardType = .emailAddress
        
        f.placeholder = "Email"
        f.detail = "Error, incorrect email"
        f.isClearIconButtonEnabled = true
    }
    
    func passwordFieldStyle(_ f:TextField) {
        f.placeholder = "Password"
        f.detail = "At least 8 characters"
        f.clearButtonMode = .whileEditing
        f.isVisibilityIconButtonEnabled = true
        f.visibilityIconButton?.tintColor = Color.green.base.withAlphaComponent(f.isSecureTextEntry ? 0.38 : 0.54)
        f.isSecureTextEntry = true
        f.returnKeyType = .done
    }
    
    func buttonSytle(_ b:RaisedButton) {
        b.titleColor = .white
        b.pulseColor = .white
        b.backgroundColor = .primary
    }
    
    func labelButtonSytle(_ b: FlatButton) {
        //b.backgroundColor = .white
        b.setTitleColor(.secondaryText, for: .normal)
    }
    
    func labelSytle(_ l:UILabel) {
        l.textColor = .secondaryText
        l.textAlignment = .center
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == username) {
            email.becomeFirstResponder()
        } else if (textField == email) {
            password.becomeFirstResponder()
        } else {
            registerTapped()
        }
        return false
    }
    
    func registerTapped() {
        endEditing(true)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loggedIn"), object: nil)
    }
    
    func wantToLogin() {
        endEditing(true)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "wantToLogin"), object: nil)
    }
}
