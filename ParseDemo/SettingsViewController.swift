//
//  SettingsViewController.swift
//  ParseDemo
//
//  Created by Mac on 10/24/15.
//  Copyright © 2015 abearablecode. All rights reserved.
//

import UIKit
import Parse

class SettingsViewController: UIViewController {

    @IBOutlet weak var username: UINavigationItem!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var email: UILabel!
    
    
    
    @IBAction func logOutAction(sender: AnyObject) {
        PFUser.logOut()
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let viewController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login")
            self.presentViewController(viewController, animated: true, completion: nil)
        })
    }
    override func viewDidLoad() {
       
        super.viewDidLoad()
        let currentUser = PFUser.currentUser()
        let firstName = currentUser!["firstName"] as! String!
            
        let lastName = currentUser!["lastName"] as! String!
        username.title = currentUser?.username
        name.text = firstName + " " + lastName
        phoneNumber.text = currentUser!["phoneNumber"] as! String!
        email.text = currentUser!["email"] as! String!
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
