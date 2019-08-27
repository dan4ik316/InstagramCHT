//
//  HomeViewController.swift
//  InstagramCHT
//
//  Created by Alex Kravchook on 23.08.2019.
//  Copyright © 2019 DanKravchook. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        loadPosts()
    }
    
    func loadPosts(){
        Database.database().reference().child("posts").observe(.childAdded) {(snapshot: DataSnapshot) in
            print(Thread.isMainThread)
            if let dict = snapshot.value as? [String: Any]{
    
                let newPost = Post.transformPostPhoto(dict: dict)
                
                self.posts.append(newPost)
                print(self.posts)
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func logout_touchUpInside(_ sender: Any) {
        print(Auth.auth().currentUser)
        do{
            try Auth.auth().signOut()
            let storyboard = UIStoryboard(name:"Start", bundle: nil)
            let signInVC = storyboard.instantiateViewController(withIdentifier: "SingleViewController")
            self.present(signInVC, animated: true, completion: nil)
        }catch let logoutError {
            print(logoutError)
        }
        print(Auth.auth().currentUser)
        //Previously sign out was here
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
        cell.textLabel?.text = posts[indexPath.row].caption
        return cell
    }
}
