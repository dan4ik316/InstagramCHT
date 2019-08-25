//
//  AuthService.swift
//  InstagramCHT
//
//  Created by Alex Kravchook on 25.08.2019.
//  Copyright © 2019 DanKravchook. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class AuthService{
    
    static func signIn(email: String, password: String, onSuccess: @escaping()-> Void, onError: @escaping(_ errorMessage: String?)-> Void){
        print("sign in")
        Auth.auth().signIn(withEmail: email, password: password, completion: {(authResult, error) in
            if error != nil{
                onError(error!.localizedDescription)
                return
            }
            onSuccess()
        })
    }
    
    static func signUp(username: String, email: String, password: String, imageData: Data, onSuccess: @escaping()-> Void, onError: @escaping(_ errorMessage: String?)-> Void){
        Auth.auth().createUser(withEmail: email, password: password, completion: {(authResult, error) in
            if let user = authResult?.user {
                print(user)
    
                let uid = user.uid
                var profileImageUrl: String?
    
                let storageRef = Storage.storage().reference(forURL: Config.STORAGE_ROOF_REF).child("profile_image").child(uid)
                
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
                                self.setUserInformation(profileImageUrl: profileImageUrl!, username: username, email: email, uid: uid, onSuccess: onSuccess)
                            }
    
                        })
    
                    })
                
            } else {
                print(error!.localizedDescription)
                onError(error!.localizedDescription)
                return
            }
    
        })
        
    }
    static func setUserInformation(profileImageUrl: String, username: String, email: String, uid: String, onSuccess: @escaping()-> Void){
        let ref = Database.database().reference()
        let userReference = ref.child("users")
        //print(userReference.description()) : https://instagramcht-50ea5.firebaseio.com
        //let uid = user.uid
        let newUserReference = userReference.child(uid)
        newUserReference.setValue(["username":username, "email": email, "profileImageUrl": profileImageUrl])
        //self.performSegue(withIdentifier: "signUpToTabbarVC", sender: nil)
        onSuccess()
    }
}
