//
//  AddContactViewController.swift
//  ParseDemo
//
//  Created by Mac on 10/24/15.
//  Copyright © 2015 abearablecode. All rights reserved.
//

import UIKit
import Parse

protocol communicationControllerContact {
    func addContact(username: String, firstName: String, lastName: String, phoneNumber: String, email: String)
}

class AddContactViewController: UIViewController {

    
    @IBOutlet weak var username: UITextField!
    var delegate: communicationControllerContact?
    var onDataAvailable: ((data: String) -> ())?
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func back(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
   
    @IBAction func done(sender: AnyObject) {
        
        var username2 = ""
        var firstName = ""
        var lastName = ""
        var email = ""
        var phoneNumber = ""
        let query = PFUser.query()
        query!.whereKey("username", equalTo: username.text!)
        query?.findObjectsInBackgroundWithBlock {
            (users: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                if let users = users! as [PFObject]? {
                    for user in users {
                        username2 = user["username"] as! String
                        firstName = user["firstName"] as! String
                        lastName = user["lastName"] as! String
                        email = user["email"] as! String
                        phoneNumber = user["phoneNumber"] as! String
                       // print(username2 + firstName + lastName + email + phoneNumber)
                        
                        self.delegate?.addContact(username2, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, email: email)
                    }
                }
            }
            else {
                print(error)
            }
        }
       
        self.sendData(username.text!)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func sendData(data: String) {
        self.onDataAvailable?(data: data)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
