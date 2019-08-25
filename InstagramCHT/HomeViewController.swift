//
//  HomeViewController.swift
//  InstagramCHT
//
//  Created by Alex Kravchook on 23.08.2019.
//  Copyright © 2019 DanKravchook. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func logout_touchUpInside(_ sender: Any) {
        print(Auth.auth().currentUser)
        do{
            try Auth.auth().signOut()
        }catch let logoutError {
            print(logoutError)
        }
        print(Auth.auth().currentUser)
        
        let storyboard = UIStoryboard(name:"Start", bundle: nil)
        let signInVC = storyboard.instantiateViewController(withIdentifier: "SingleViewController")
        self.present(signInVC, animated: true, completion: nil)
        
    }
}
