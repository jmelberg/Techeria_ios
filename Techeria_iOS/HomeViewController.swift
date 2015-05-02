//
//  HomeViewController.swift
//  Techeria_iOS
//
//  Created by Jordan Melberg on 4/29/15.
//  Copyright (c) 2015 RayWenderlich. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet weak var first: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var user_description: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        let loggedIn = NSUserDefaults.standardUserDefaults().stringForKey("access_token")
        if (loggedIn == nil){
            self.performSegueWithIdentifier("login", sender: self)
        }
        else{
            getUserInfo()
        }
    }
    
    @IBAction func logout(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "access_token")
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "username")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func getUserInfo(){
        var current_user = NSUserDefaults.standardUserDefaults().stringForKey("username")
        println(current_user!)
        var URL = NSURL(string: "http://techeria1.appspot.com/api/profile/\(current_user!)")
        var data = NSData(contentsOfURL: URL!)
        var users = [User()]
        if let json: NSDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary {
            println(json)
            var user = User()
            if let username = json["username"] as? NSObject {
                if let friendCount = json["friend_count"] as? NSObject {
                    user.friendCount = friendCount
                    if let picture = json["picture"] as? NSObject {
                        user.picture = picture
                        if let url = NSURL(string: "http://techeria1.appspot.com\(picture)"){
                            let data = NSData(contentsOfURL: url, options: NSDataReadingOptions.DataReadingUncached, error:nil)
                            profilePicture.contentMode = UIViewContentMode.ScaleAspectFit
                            profilePicture.image = UIImage(data:data!)
                        }
                        if let account = json["account_type"] as? NSObject {
                            user.account_type = account
                            if let firstname = json["firstname"] as? NSObject {
                                user.firstName = firstname
                                if let subscriptions = json["subscriptions"] as? NSArray {
                                    //user.subScriptions = subscriptions
                                    if let lastname = json["lastname"] as? NSObject {
                                        user.lastName = lastname
                                        var name = "\(firstname) \(lastname)"
                                        first.text = name as String
                                        if let profession = json["profession"] as? NSObject {
                                            user.profession = profession
                                            if let employer = json["employer"] as? NSObject {
                                                user.employer = employer
                                                user_description.text = "\(profession) @ \(employer)"
                                                if let email = json["email"] as? NSObject {
                                                    user.email = email
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            users[0] = user
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
