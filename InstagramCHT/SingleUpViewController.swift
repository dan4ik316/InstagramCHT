//
//  SingleUpViewController.swift
//  InstagramCHT
//
//  Created by Alex Kravchook on 23.08.2019.
//  Copyright © 2019 DanKravchook. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase

class SingleUpViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.backgroundColor = UIColor.clear
        usernameTextField.tintColor = UIColor.white
        usernameTextField.textColor = UIColor.white
        usernameTextField.attributedPlaceholder =
            NSAttributedString(string: usernameTextField.placeholder!,
                               attributes:[NSForegroundColorAttributeName: UIColor(white:
                                1.0,alpha:0.6)])
        let bottomLayerUsername = CALayer()
        bottomLayerUsername.frame = CGRect(x: 0, y: 29, width: 1000,height:0.6)
        bottomLayerUsername.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
        usernameTextField.layer.addSublayer(bottomLayerUsername)
        
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
        
        profileImage.layer.cornerRadius = 39
        profileImage.clipsToBounds = true

        // Do any additional setup after loading the view.
    }

    @IBAction func dismiss_onClick(_ sender: Any) {
        dismiss(animated:true, completion: nil)
        
    }
    @IBAction func signUpBtn_tuochUpInside(_ sender: Any) {
       
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: {(authResult, error) in
            if let user = authResult?.user {
                print(user)
                self.ref = Database.database().reference()
                let userReference = self.ref.child("users")
                //print(userReference.description()) : https://instagramcht-50ea5.firebaseio.com
                let uid = user.uid
                let newUserReference = userReference.child(uid)
                newUserReference.setValue(["username":self.usernameTextField.text!, "email": self.emailTextField.text!])
                //print(" description: \(newUserReference.description())")
                
                
            
                
        } else {
            print(error!.localizedDescription)
            return
            }
            
        })
        
        
    }
}
