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
                println("Server Response: \(response)")
                // Response Body
                let responseString = NSString(data:data, encoding: NSUTF8StringEncoding)
                println("Response Data: \(responseString)")
                
                var err: NSError?
                if let json: NSDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary {
                    if let token = json["token"] as? String {
                        println("Token: \(token)")
                        
                        // Stores User's username and access token for future use //
                        NSUserDefaults.standardUserDefaults().setObject(token, forKey: "access_token")
                        NSUserDefaults.standardUserDefaults().setObject(username, forKey: "username")
                        NSUserDefaults.standardUserDefaults().synchronize()
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                    else{
                        var alertView: UIAlertView = UIAlertView()
                        alertView.title = "Signin Failed"
                        alertView.message = "Please try again"
                        alertView.delegate = self
                        alertView.addButtonWithTitle("Continue")
                        alertView.show()
                    }

                }
                
            }
            task.resume()
        }
    }
}
