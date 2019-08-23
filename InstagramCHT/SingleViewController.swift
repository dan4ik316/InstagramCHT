//
//  SingleViewController.swift
//  InstagramCHT
//
//  Created by Alex Kravchook on 22.08.2019.
//  Copyright © 2019 DanKravchook. All rights reserved.
//

import UIKit

class SingleViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.backgroundColor = UIColor.clear
        emailTextField.tintColor = UIColor.white
        emailTextField.textColor = UIColor.white
        emailTextField.attributedPlaceholder =
            NSAttributedString(string: emailTextField.placeholder!,
                               attributes:[NSForegroundColorAttributeName: UIColor(white:
                                1.0,alpha:0.6)])
        let bottomLayerEmail = CALayer()
        bottomLayerEmail.frame = CGRect(x: 0, y: 29, width: 1000,height:0.6)
        bottomLayerEmail.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
        emailTextField.layer.addSublayer(bottomLayerEmail)
        
        passwordTextField.backgroundColor = UIColor.clear
        passwordTextField.tintColor = UIColor.white
        passwordTextField.textColor = UIColor.white
        passwordTextField.attributedPlaceholder =
            NSAttributedString(string: passwordTextField.placeholder!,
                               attributes:[NSForegroundColorAttributeName: UIColor(white:
                                1.0,alpha:0.6)])
        let bottomLayerPassword = CALayer()
        bottomLayerPassword.frame = CGRect(x: 0, y: 29, width: 1000,height:0.6)
        bottomLayerPassword.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
        passwordTextField.layer.addSublayer(bottomLayerPassword)

        // Do any additional setup after loading the view.
    }
 }
