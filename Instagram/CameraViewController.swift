//
//  CameraViewController.swift
//  Instagram
//
//  Created by Gabriel Muñiz on 6/27/17.
//  Copyright © 2017 Gabriel Muñiz. All rights reserved.
//

import UIKit
import Parse

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let CameraViewController = UIImagePickerController()
        CameraViewController.delegate = self
        CameraViewController.allowsEditing = true
        CameraViewController.sourceType = UIImagePickerControllerSourceType.camera
        
        self.present(CameraViewController, animated: true, completion: nil)

        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available!")
            CameraViewController.sourceType = .camera
        } else {
            print("Camera NOT available so we will use photo library instead")
            CameraViewController.sourceType = .photoLibrary
        }

    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        dismiss(animated: true, completion: nil)
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
