//
//  MessageViewerViewController.swift
//  Techeria_iOS
//
//  Created by Jordan Melberg on 5/4/15.
//
//

import UIKit

class MessageViewerViewController: UIViewController {

    
    @IBOutlet weak var message_sender: UILabel!
    @IBOutlet weak var message_subject: UILabel!
    @IBOutlet weak var message_text: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        message_sender.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).CGColor
        message_sender.layer.borderWidth = 1.0
        message_sender.layer.cornerRadius = 1
        
        message_subject.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).CGColor
        message_subject.layer.borderWidth = 1.0
        message_subject.layer.cornerRadius = 0
        
        message_text.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).CGColor
        message_text.layer.borderWidth = 1.0
        message_text.layer.cornerRadius = 1
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
            var sender = NSUserDefaults.standardUserDefaults().stringForKey("message_sender")!
            var text = NSUserDefaults.standardUserDefaults().stringForKey("message_text")!
            var subject = NSUserDefaults.standardUserDefaults().stringForKey("message_subject")!
            message_sender.text = "  \(sender)"
            message_subject.text = " \(text)"
            message_text.text = " \(subject)"
            
            // Instantiate View
            
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
