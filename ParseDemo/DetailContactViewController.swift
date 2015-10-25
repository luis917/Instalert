//
//  DetailContactViewController.swift
//  ParseDemo
//
//  Created by Mac on 10/24/15.
//  Copyright © 2015 abearablecode. All rights reserved.
//

import UIKit
import Parse

class DetailContactViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var navBar: UINavigationItem!
 //   @IBOutlet weak var navBar: UINavigationItem!
    
    var labelUsername: String?
    var labelText: String?
    var labelPhoneNumber: String?
    var labelEmail: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = labelText
        phoneNumber.text = labelPhoneNumber
        email.text = labelEmail
        navBar.title = labelUsername
    }
    
    @IBAction func sendAlert(sender: AnyObject) {
        let push = PFPush()
        push.setChannel(labelUsername!)
        push.setMessage("Please call me ASAP!")
        push.sendPushInBackground()
    }
    
   // @IBAction func deleteContact(sender: AnyObject) {
        
    //}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
