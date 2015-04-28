//
//  SearchViewController.swift
//  Techeria
//  Created by Jordan Melberg

//
import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchText: UITextField!
    @IBAction func searchSelected(sender: AnyObject) {
        let user = searchText.text
        NSUserDefaults.standardUserDefaults().setObject(user, forKey: "user")
        NSUserDefaults.standardUserDefaults().synchronize()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        searchText.resignFirstResponder()
        return true
    }

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent){
        self.view.endEditing(true)
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


