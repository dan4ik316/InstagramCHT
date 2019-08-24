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
import FirebaseStorage

class SingleUpViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    var ref: DatabaseReference!
    
    var selectedImage: UIImage?

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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SingleUpViewController.handleSelectProfileImageView))
        profileImage.addGestureRecognizer(tapGesture)
        profileImage.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }
    
    func handleSelectProfileImageView(){
        print("Tapped!") //оставлю, ибо залипать на это в консоле приятно
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }

    @IBAction func dismiss_onClick(_ sender: Any) {
        dismiss(animated:true, completion: nil)
        
    }
    @IBAction func signUpBtn_tuochUpInside(_ sender: Any) {
       
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: {(authResult, error) in
            if let user = authResult?.user {
                print(user)
                
                let uid = user.uid
                var profileImageUrl: String?
                
                let storageRef = Storage.storage().reference(forURL: "gs://instagramcht-50ea5.appspot.com").child("profile_image").child(uid)
                if let profileImg = self.selectedImage, let imageData = UIImageJPEGRepresentation(profileImg, 0.1){
                    storageRef.putData(imageData, metadata: nil, completion: {(metadata, error) in
                        if error != nil {
                            return
                        }
                      //let profileImageUrl = metadata?.downloadURL().absoluteString
                        storageRef.downloadURL(completion: { (url, error) in
                            if error != nil {
                                print("Failed to download url:", error!)
                                return
                            } else {
                                //Do something with url
                                profileImageUrl = url?.absoluteString
                            }
                            
                        })
                        
                    })
                }
                
                
                
                
                self.ref = Database.database().reference()
                let userReference = self.ref.child("users")
                //print(userReference.description()) : https://instagramcht-50ea5.firebaseio.com
                //let uid = user.uid
                let newUserReference = userReference.child(uid)
                newUserReference.setValue(["username":self.usernameTextField.text!, "email": self.emailTextField.text!, "profileImageUrl": profileImageUrl])
                print(" description: \(newUserReference.description())")
                
                
            
                
        } else {
            print(error!.localizedDescription)
            return
            }
            
        })
        
        
    }
}

extension SingleUpViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("did Finish Picking Media")
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            selectedImage = image
            profileImage.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}
