//
//  LoginView.swift
//  AroundU
//
//  Created by Richer Archambault on 2017-03-04.
//  Copyright © 2017 LassondeHacks. All rights reserved.
//

import UIKit
import Material
import Stevia
import Just

class LoginView:UIView, TextFieldDelegate {
    let email = ErrorTextField()
    let password = TextField()
    let login = RaisedButton()
    let signupLabel = UILabel()
    let signup = FlatButton()
    
    convenience init() {
        self.init(frame:CGRect.zero)
        
        render()
    }
    
    
    func render() {
        backgroundColor = Color.white
        
        sv(
            email.style(textFieldStyle).style(emailFieldStyle),
            password.style(textFieldStyle).style(passwordFieldStyle),
            login.text("Login").style(buttonSytle).tap(loginTapped),
            signupLabel.text("Not registered yet? ").style(labelSytle),
            signup.text("Register").style(labelButtonSytle).tap(wantToRegister)
            
        )
        
        layout(
            <=100,
            |-24-email-24-| ~ 40,
            24,
            |-24-password-24-| ~ 40,
            48,
            |-24-login-24-| ~ 40,
            24,
            |-24-signupLabel-1-signup ~ 40
        )
    }
    
    func textFieldStyle(_ f: TextField) {
        f.delegate = self
        f.placeholderNormalColor = .secondaryText
        f.placeholderActiveColor = .primary
        f.dividerNormalColor = .divider
        f.dividerActiveColor = .primary
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
        if (textField == email) {
            password.becomeFirstResponder()
        } else {
            loginTapped()
        }
        return false
    }
    
    func loginTapped() {
        endEditing(true)
        Connection.login(username: email.text!, password: password.text!)
    }
    
    func wantToRegister() {
        endEditing(true)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "wantToRegister"), object: nil)
    }
}
