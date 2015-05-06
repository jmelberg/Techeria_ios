//
//  ForumViewController.swift
//  Techeria_iOS
//
//  Created by Jordan Melberg on 5/4/15.
//
//

import UIKit

class ForumViewController: UIViewController {

    @IBOutlet weak var forum: UILabel!
    @IBOutlet weak var text: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        var title = NSUserDefaults.standardUserDefaults().stringForKey("forum_name")
        println(title)
        var info = NSUserDefaults.standardUserDefaults().stringForKey("forum_description")
        if title != nil {
            forum.text = title
            text.text = info
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
