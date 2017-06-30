//
//  SelfPostCellCollectionViewCell.swift
//  Instagram
//
//  Created by Gabriel Muñiz on 6/29/17.
//  Copyright © 2017 Gabriel Muñiz. All rights reserved.
//

import UIKit
import Parse
import ParseUI


class SelfPostCellCollectionViewCell: UICollectionViewCell {
 
    @IBOutlet weak var postPicture: PFImageView!

    var instaPost: PFObject! {
        didSet {
            self.postPicture.file = instaPost["media"] as? PFFile
            self.postPicture.loadInBackground()
        }
    }

    
    
}
