//
//  HomeViewController.swift
//  ParseDemo
//
//  Created by Rumiya Murtazina on 7/31/15.
//  Copyright (c) 2015 abearablecode. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate, communicationControllerContact{

    
    @IBOutlet weak var contactTableView: UITableView!
    
    
    var contactsArray = [Contact]()
    var data = [String]()
    var filteredData: [String]!

    
    func addContact(username: String, firstName: String, lastName: String, phoneNumber: String, email: String) {
        
       // var username1 = username as? [String : AnyObject]
        self.contactsArray += [Contact(username: username, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, email: email)]
        
        self.data.append(firstName + " " + lastName)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactTableView.dataSource = self
        filteredData = data
        
        
        
        var username = "taihoang"
        var query = PFUser.query()
        query!.whereKey("username", equalTo: username)
        query?.findObjectsInBackgroundWithBlock {
            (users: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                if let users = users! as [PFObject]? {
                    for user in users {
                        let username2 = user["username"] as! String
                        let firstName = user["firstName"] as! String
                        let lastName = user["lastName"] as! String
                        let email = user["email"] as! String
                        let phoneNumber = user["phoneNumber"] as! String
                        // print(username2 + firstName + lastName + email + phoneNumber)
                        
                        self.addContact(username2, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, email: email)
                        
                        self.contactTableView.reloadData()
                    }
                }
            }
            else {
                print(error)
            }
        }
        
        username = "sarahkhan"
        query = PFUser.query()
        query!.whereKey("username", equalTo: username)
        query?.findObjectsInBackgroundWithBlock {
            (users: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                if let users = users! as [PFObject]? {
                    for user in users {
                        let username2 = user["username"] as! String
                        let firstName = user["firstName"] as! String
                        let lastName = user["lastName"] as! String
                        let email = user["email"] as! String
                        let phoneNumber = user["phoneNumber"] as! String
                        // print(username2 + firstName + lastName + email + phoneNumber)
                        
                        self.addContact(username2, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, email: email)
                        
                        self.contactTableView.reloadData()
                    }
                }
            }
            else {
                print(error)
            }
        }
        
        
        
        //let currentUser = PFUser.currentUser()?.username
        //   currentUser?.username
       // let username5 = (currentUser?.username)!
//        // currentInstallation.addUniqueObject((currentUser?.username)!, forKey: "channels")
       // currentInstallation.addUniqueObject(currentUser!, forKey: "channels")
        
     //   currentInstallation.saveInBackground()

        contactTableView.reloadData()
      
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        contactTableView.reloadData()
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //if the user isn't logged it it redirects to log in screen
    override func viewWillAppear(animated: Bool) {
        if(PFUser.currentUser() == nil) {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login")
                self.presentViewController(viewController, animated: true, completion: nil)
            })
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // we dequeue from the mainTableView since the one passed in might be the
        // tableView for the searchDipslayController with which we never registered
        // a reusable protoype cell
        let cell = self.contactTableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        if tableView == searchDisplayController?.searchResultsTableView {
            //search results table
            cell.textLabel?.text = filteredData[indexPath.row]
        } else {
            // main table
            cell.textLabel?.text = data[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == searchDisplayController?.searchResultsTableView {
            //search results table
            return filteredData.count
        }
        // main table
        return data.count
    }
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String!) -> Bool {
        filteredData = searchString.isEmpty ? data : data.filter({(dataString: String) -> Bool in
            return dataString.rangeOfString(searchString, options: .CaseInsensitiveSearch) != nil
        })
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addContactSegue" {
            let destination = segue.destinationViewController as! AddContactViewController
            destination.delegate = self
        } else if segue.identifier == "detailedContactViewControllerSegue" {
            let destination = segue.destinationViewController as! DetailContactViewController
            let cell = contactTableView.cellForRowAtIndexPath(contactTableView.indexPathForSelectedRow!)
            destination.labelText = cell?.textLabel?.text!
            //    for i in contactsArray.count {
            //      if cell?.textLabel?
            //}
      //      destination.labelUsername = contactsArray[contactTableView.indexOfAccessibilityElement(sender!)].username
        //    destination.labelEmail = contactsArray[contactTableView.indexOfAccessibilityElement(sender!)].email!
          //  destination.labelPhoneNumber = contactsArray[contactTableView.indexOfAccessibilityElement(sender!)].phoneNumber!
            
          //  print(contactTableView.indexOfAccessibilityElement(sender!)-9223372036854775807)
            var j = 0
            for i in 0...contactsArray.count-1 {
                if(destination.labelText! == contactsArray[i].firstName! + " " + contactsArray[i].lastName!) {
                    j = i;
                    //print(j)
                }
            }
            destination.labelUsername = contactsArray[j].username
            destination.labelEmail = contactsArray[j].email
            destination.labelPhoneNumber = contactsArray[j].phoneNumber
        }
        
    }

}
