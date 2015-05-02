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
    @IBOutlet weak var user_job: UILabel!
    @IBOutlet weak var user_employer: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.performSegueWithIdentifier("login", sender:self)
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
