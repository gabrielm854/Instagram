//
//  LogoutViewController.swift
//  Instagram
//
//  Created by Gabriel Muñiz on 6/27/17.
//  Copyright © 2017 Gabriel Muñiz. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class LogoutViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    let query = PFQuery(className: "Post")
    var posts: [PFObject?] = []
    let followAlertController = UIAlertController(title: "Loner Error", message: "Unfortunately you cannot follow yourself...", preferredStyle: .alert)
    
    @IBOutlet weak var postCount: UILabel!
    @IBOutlet weak var didFollow: UIButton!
    @IBOutlet weak var usernameLabe: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBAction func didLogout(_ sender: Any) {
        PFUser.logOutInBackground { (error: Error?) -> Void in
            PFUser.current() == nil
            self.performSegue(withIdentifier: "logoutSegue", sender: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePicture.layer.cornerRadius = 0.5*profilePicture.frame.width
        profilePicture.layer.masksToBounds = true
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 1
        didFollow.layer.cornerRadius = 0.05*didFollow.frame.width
        didFollow.layer.masksToBounds = true
        flowLayout.itemSize = CGSize(width: 1/3*collectionView.frame.width-1, height: 1/3*collectionView.frame.height-1)
        let currentUser = PFUser.current() as! PFUser
        self.usernameLabe.text = currentUser.username as? String
        let OKAction = UIAlertAction(title: "Try Again", style: .default, handler: nil)
        self.followAlertController.addAction(OKAction)
        getPosts()
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func didPressFollow(_ sender: Any) {
        self.present(followAlertController, animated: true)
    }
    
    
    func getPosts() {
        query.whereKey("author", equalTo: PFUser.current()!)
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.findObjectsInBackground {(posts: [PFObject]?, error: Error?) in
            if let posts = posts {
                self.posts = posts
                for post in posts {
                    let picture = post["media"] as? PFFile
                    print("got the image")
                }
                self.collectionView.reloadData()
                
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "selfPost", for: indexPath) as! SelfPostCellCollectionViewCell
        
        print("I wanna be a cat")
        let post = posts[indexPath.item]
        cell.instaPost = post
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        postCount.text = String(posts.count)
        return posts.count
    }

    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
