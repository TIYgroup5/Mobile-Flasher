//
//  LoginViewController.swift
//  login
//
//  Created by Susanne Burnham on 10/15/15.
//  Copyright © 2015 Susanne Kasahara. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {

    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!

    @IBAction func pressedLogin(sender: AnyObject) {
        
        let usernameRequest = RailsRequest.session()
        
        guard let username = usernameField.text where !username.isEmpty else { return }
        guard let password = passwordField.text where !password.isEmpty else { return }
        
        
        
        usernameRequest.loginWithUsername(username, andPassword: password)
        
        
    }
        
   
    @IBAction func pressedRegister(sender: AnyObject) {
        
        
    }
        
        
            
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    }