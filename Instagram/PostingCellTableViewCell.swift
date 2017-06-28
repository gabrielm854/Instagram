//
//  PostingCellTableViewCell.swift
//  Instagram
//
//  Created by Gabriel Muñiz on 6/28/17.
//  Copyright © 2017 Gabriel Muñiz. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PostingCellTableViewCell: UITableViewCell {
    @IBOutlet weak var postPhoto: PFImageView!
    @IBOutlet weak var postCaption: UILabel!

    var instaPost: PFObject! {
        didSet {
            self.postPhoto.file = instaPost["media"] as? PFFile
            self.postPhoto.loadInBackground()
            self.postCaption.text = instaPost["caption"] as? String
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
