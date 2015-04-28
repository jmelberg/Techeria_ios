//
//  ViewController.swift
//  Techeria
//  Created by Jordan Melberg
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var first: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var user_job: UILabel!
    @IBOutlet weak var user_employer: UILabel!
    
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    var searchUser = NSUserDefaults.standardUserDefaults().stringForKey("user")
    println(searchUser!)
    var URL = NSURL(string: "http://techeria1.appspot.com/api/profile/\(searchUser!)")
    var data = NSData(contentsOfURL: URL!)
    var users = [User()]
    
    if let json: NSDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary {
        var user = User()
        if let username = json["username"] as? NSObject {
                println(username)
            if let friendCount = json["friend_count"] as? NSObject {
                println(friendCount)
                user.friendCount = friendCount
                if let picture = json["picture"] as? NSObject {
                    user.picture = picture
                    if let url = NSURL(string: "http://techeria1.appspot.com\(picture)"){
                        let data = NSData(contentsOfURL: url, options: NSDataReadingOptions.DataReadingUncached, error:nil)
                            profilePicture.contentMode = UIViewContentMode.ScaleAspectFill
                            profilePicture.image = UIImage(data:data!)
                    }
                    if let account = json["account_type"] as? NSObject {
                        println(account)
                        user.account_type = account
                        if let firstname = json["firstname"] as? NSObject {
                            println(firstname)
                            user.firstName = firstname
                            if let subscriptions = json["subscriptions"] as? NSArray {
                                println(subscriptions)
                                //user.subScriptions = subscriptions
                                if let lastname = json["lastname"] as? NSObject {
                                    println(lastname)
                                    user.lastName = lastname
                                        var name = "\(firstname) \(lastname)"
                                    first.text = name as String
                                    if let profession = json["profession"] as? NSObject {
                                        println(profession)
                                        user.profession = profession
                                        user_job.text = profession as? String
                                        if let employer = json["employer"] as? NSObject {
                                            println(employer)
                                            user.employer = employer
                                            user_employer.text = employer as? String
                                            if let email = json["email"] as? NSObject {
                                                println(email)
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
}

        
        
        

class User: NSObject{
        var username: NSObject!
        var friendCount: NSObject!
        var picture: NSObject!
        var account_type: NSObject!
        var firstName: NSObject!
        var lastName: NSObject!
        var subScriptions: [NSObject]!
        var email: NSObject!
        var profession: NSObject!
        var employer: NSObject!

    }

