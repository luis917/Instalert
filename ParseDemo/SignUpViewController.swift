//
//  SignUpViewController.swift
//  ParseDemo
//
//  Created by Rumiya Murtazina on 7/30/15.
//  Copyright (c) 2015 abearablecode. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpAction(sender: AnyObject) {
        let firstName = self.firstNameField.text
        let lastName = self.lastNameField.text
        let username = self.usernameField.text
        let password = self.passwordField.text
        let email = self.emailField.text
        let phoneNumber = self.phoneNumberField.text
        let finalEmail = email?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        //Validate the text fields
        if username!.characters.count < 5 {
            let alert = UIAlertView(title: "Invalid", message: "Username must be greater than 5 characters", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } else if password!.characters.count < 8 {
            let alert = UIAlertView(title: "Invalid", message: "Password must be greater than 8 characters", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } else if email!.characters.count < 8 {
            let alert = UIAlertView(title: "Invalid", message: "Please enter a valid email address", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } else {
            // Run a spinner to show a task in progress
            let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
            spinner.startAnimating()
            
            let newUser = PFUser()
            
            newUser.username = username
            newUser.password = password
            newUser.email = finalEmail
            newUser["firstName"] = firstName
            newUser["lastName"] = lastName
            newUser["phoneNumber"] = phoneNumber
           // newUser["Contact"] = [String](count: 10, repeatedValue: "")
           // newUser["numContacts"] = 0
            
            // Sign up the user asynchronously
            newUser.signUpInBackgroundWithBlock({ (succeed, error) -> Void in
            
                // Stop the spinner
                spinner.stopAnimating()
                if ((error) != nil) {
                    let alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    
                } else {
                    let alert = UIAlertView(title: "Success", message: "Signed Up", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Home")
                        self.presentViewController(viewController, animated: true, completion: nil)
                    })
                }
            })
        }
    }

}


