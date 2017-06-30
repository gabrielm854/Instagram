//
//  DetailViewController.swift
//  Instagram
//
//  Created by Gabriel Muñiz on 6/28/17.
//  Copyright © 2017 Gabriel Muñiz. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class DetailViewController: UIViewController {

    @IBOutlet weak var postImage: PFImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var postCaption: UILabel!
    
    var post: PFObject?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let post = post {
            self.postImage.file = post["media"] as? PFFile
            self.postImage.loadInBackground()
            self.postCaption.text = post["caption"] as? String
            let author = post["author"] as! PFUser
            let username = author.username as! String
            self.usernameLabel.text = username as? String
            let createdAt = post.createdAt
            if let timestamp = createdAt{
                self.timestampLabel.text = "Posted \(timestamp)"
            }
        }
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
