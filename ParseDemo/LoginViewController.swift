//
//  LoginViewController.swift
//  ParseDemo
//
//  Created by Rumiya Murtazina on 7/28/15.
//  Copyright (c) 2015 abearablecode. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let testObject = PFObject(className: "TestObject")
        testObject["foo"] = "bar"
        testObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("Object has been saved.")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func unwindToLogInScreen(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func loginAction(sender: AnyObject) {
            let username = self.usernameField.text
            let password = self.passwordField.text
            
            // Validate the text fields
            if username!.characters.count < 5 {
                let alert = UIAlertView(title: "Invalid", message: "Username must be greater than 5 characters", delegate: self, cancelButtonTitle: "OK")
                alert.show()
                
            } else if password!.characters.count < 8 {
                let alert = UIAlertView(title: "Invalid", message: "Password must be greater than 8 characters", delegate: self, cancelButtonTitle: "OK")
                alert.show()
                
            } else {
                // Run a spinner to show a task in progress
                let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
                spinner.startAnimating()
                
                // Send a request to login
                PFUser.logInWithUsernameInBackground(username!, password: password!, block: { (user, error) -> Void in
                    
                    // Stop the spinner
                    spinner.stopAnimating()
                    
                    if ((user) != nil) {
                        let alert = UIAlertView(title: "Success", message: "Logged In", delegate: self, cancelButtonTitle: "OK")
                        alert.show()
                        
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
                            
                            self.presentViewController(viewController, animated: true, completion: nil)
                            
                            
                            let currentInstallation = PFInstallation.currentInstallation()
                            // currentInstallation.addUniqueObject((currentUser?.username)!, forKey: "channels")
                            currentInstallation.addUniqueObject(username!, forKey: "channels")
                            
                            currentInstallation.saveInBackground()
                        })
                        
                    } else {
                        let alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                        alert.show()
                    }
                })
            }
        }
    

}
