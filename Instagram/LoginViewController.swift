//
//  LoginViewController.swift
//  Instagram
//
//  Created by Gabriel Muñiz on 6/27/17.
//  Copyright © 2017 Gabriel Muñiz. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    //User authentification
    let loginalertController = UIAlertController(title: "Login Error", message: "The username or password entered is not correct.", preferredStyle: .alert)
    let signupalertController = UIAlertController(title: "Sign Up Error", message: "You need to enter a valid username and password.", preferredStyle: .alert)
    
    
    @IBAction func onTap(_ sender: Any) {
    view.endEditing(true)
    }
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    @IBAction func didLogin(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: Error?) -> Void in
            if user != nil {
                print("Login successful!")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print(error?.localizedDescription)
                let OKAction = UIAlertAction(title: "Try Again", style: .default) {(action) in
                }
                self.loginalertController.addAction(OKAction)
                self.present(self.loginalertController, animated: true) {

            }
        }
    }
    }
    
    @IBAction func didSignUp(_ sender: Any) {
        let newUser = PFUser()
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if success {
                print("Registration successful!")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print(error?.localizedDescription)
                let OKAction = UIAlertAction(title: "Try Again", style: .default) {(action) in
                }
                self.signupalertController.addAction(OKAction)
                self.present(self.signupalertController, animated: true)
                    
                }
            }
        }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
