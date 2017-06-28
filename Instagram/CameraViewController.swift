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
    
    var originalImage: UIImage?
    var editedImage: UIImage?
    var photoPreview: UIImage?
    
    @IBAction func choosePicture(_ sender: Any) {
    let CameraViewController = UIImagePickerController()
        CameraViewController.delegate = self
        CameraViewController.allowsEditing = true
        CameraViewController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(CameraViewController, animated: true, completion: nil)
    }
    
    @IBAction func takePicture(_ sender: Any) {
    takeCameraPhoto()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func takeCameraPhoto () {
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

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        print("We have an image!")
        dismiss(animated: true, completion: nil)
        
        self.performSegue(withIdentifier: "postSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let postingViewController = segue.destination as! PostingViewController
        let photoPreview = editedImage as! UIImage
        postingViewController.greatPicture = photoPreview
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
