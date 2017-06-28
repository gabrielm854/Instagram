//
//  PostingViewController.swift
//  Instagram
//
//  Created by Gabriel Muñiz on 6/27/17.
//  Copyright © 2017 Gabriel Muñiz. All rights reserved.
//

import UIKit
import Parse

class PostingViewController: UIViewController {
    var greatPicture: UIImage?
    var caption: String?
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var captionField: UITextField!
    @IBAction func didPost(_ sender: AnyObject) {
        caption = captionField.text
        Post.postUserImage(image: greatPicture, withCaption: caption, withCompletion: nil)
        captionField.text = ""
        self.performSegue(withIdentifier: "afterPostSegue", sender: nil)
        print("\n\nposted stuff")
    }
    
    @IBAction func didCancel(_ sender: Any) {
    self.performSegue(withIdentifier: "cancelSegue", sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UIImageView.animate(withDuration: 1.0, animations: {
            self.photoView.image = self.greatPicture
            self.photoView.alpha = 1
        })
        
        // Do any additional setup after loading the view.
    }
    
    func postingPosts() {
        var image = PFObject(className:"Post")
        image["caption"] = captionField.text
        image["author"] = PFUser.current()
        image.saveInBackground {(success: Bool, error: Error?) -> Void in
            if (success) {
                print("The image was saved")
            } else {
                print(error?.localizedDescription)
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
