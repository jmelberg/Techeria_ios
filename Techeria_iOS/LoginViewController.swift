//
//  LoginViewController.swift
//  Techeria_iOS
//
//  Created by Jordan Melberg on 4/29/15.
//  Copyright (c) 2015 RayWenderlich. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var username_attempt: UITextField!
    @IBOutlet weak var password_attempt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func signin(sender: AnyObject) {
        //Authenticate
        var username: NSString = username_attempt.text
        var password: NSString = password_attempt.text
        
        if (username.isEqualToString("") || password.isEqualToString("")){
            var alertView: UIAlertView = UIAlertView()
            alertView.title = "Sign in failed"
            alertView.message = "Please enter Username and Password"
            alertView.delegate = self
            alertView.addButtonWithTitle("Continue")
            alertView.show()
        }
        else
        {
            var request = NSMutableURLRequest(URL: NSURL(string: "http://techeria1.appspot.com/api/login")!)
            var login_credentials = "username=\(username)&password=\(password)"
            request.HTTPMethod = "POST"
            request.HTTPBody = login_credentials.dataUsingEncoding(NSUTF8StringEncoding)
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
                data, response, error in
    
                if error != nil {
                    println("Error: \(error)")
                    return
                }
                //Response Object
                println("******** Response: \(response)")
                // Response Body
                let responseString = NSString(data:data, encoding: NSUTF8StringEncoding)
                println("====== Response Data: \(responseString)")
                
                var err: NSError?
                if let json: NSArray? = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: &err) as? NSArray{
                    if let separator  = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil){
                        println("This is my separator: \(separator)")
                        if let element = separator[0] as? NSDictionary{
                            println("Element: \(element)")
                            if let token = element["token"] as? String{
                                println("Token: \(token)")
                                NSUserDefaults.standardUserDefaults().setObject(token, forKey: "access_token")
                                NSUserDefaults.standardUserDefaults().synchronize()
                            }
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
