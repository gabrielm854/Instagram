//
//  MainScreenViewController.swift
//  Instagram
//
//  Created by Gabriel Muñiz on 6/28/17.
//  Copyright © 2017 Gabriel Muñiz. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class MainScreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let query = PFQuery(className: "Post")
    var picture: PFFile!
    var posts: [PFObject] = []
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector (MainScreenViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        getPosts()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.separatorStyle = .none
        
        print("getting posts")
        self.tableView.reloadData()
        
    }
    
    func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        getPosts()
    }
    
    func getPosts() {
        activityIndicator.startAnimating()
        query.order(byDescending: "_created_at")
        query.limit = 20
        query.findObjectsInBackground {(posts: [PFObject]?, error: Error?) in
            if let posts = posts {
                self.posts = posts
                for post in posts {
                    let caption = post["caption"] as? String
                    print(caption)
                    let picture = post["media"] as? PFFile
                    print("got the image")
                }
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                
            } else {
                print(error?.localizedDescription)
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostingCell", for: indexPath) as! PostingCellTableViewCell
        print("I wanna be a dog")
        let post = posts[indexPath.row]
        cell.instaPost = post
        activityIndicator.stopAnimating()
//        if let picture = post["media"] as? PFFile {
//            let caption = post["caption"] as! String
//            cell.postPhoto.file = picture
//            cell.postCaption.text = caption
        //}
               return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
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
