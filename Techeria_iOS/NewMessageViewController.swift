//
//  NewMessageViewController.swift
//  Techeria_iOS
//
//  Created by Jordan Melberg on 5/3/15.
//
//

import UIKit

class NewMessageViewController: UIViewController {

    @IBOutlet weak var recipient: UITextField!
    @IBOutlet weak var subject: UITextField!
    @IBOutlet weak var message: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        message.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).CGColor
        message.layer.borderWidth = 1.0
        message.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendMessage(sender: AnyObject) {
        
        //Get data to be sent
        let loggedIn = NSUserDefaults.standardUserDefaults().stringForKey("access_token")
        if (loggedIn == nil){
            self.performSegueWithIdentifier("login", sender: self)
        }
        else{
            sendMessage()
        }
        
    }
    
    func sendMessage(){
        // Get data from View
        var send_recipient = recipient.text
        var send_subject = subject.text
        var send_body = message.text
        var sent: Bool = false
        
        var request = NSMutableURLRequest(URL: NSURL(string: "http://techeria1.appspot.com/api/compose")!)
        var loggedIn = NSUserDefaults.standardUserDefaults().stringForKey("access_token")!
        var token_auth = "token=\(loggedIn)&subject=\(send_subject)&text=\(send_body)&recipient=\(send_recipient)"
        request.HTTPMethod = "POST"
        request.HTTPBody = token_auth.dataUsingEncoding(NSUTF8StringEncoding)
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
                if let sent = json["text"] as? String {
                    println(sent)
                    if sent != "Recipient does not exist"{
                        NSOperationQueue.mainQueue().addOperationWithBlock {
                            self.performSegueWithIdentifier("home", sender: self)
                        }
                    }
                    else{
                        NSOperationQueue.mainQueue().addOperationWithBlock {
                            var alertView: UIAlertView = UIAlertView()
                            alertView.title = "Message Failed "
                            alertView.message = "Recipeint does not exist"
                            alertView.delegate = self
                            alertView.addButtonWithTitle("Continue")
                            alertView.show()
                        }
                    }
                }
            }
        }
        task.resume()
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
