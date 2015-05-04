//
//  MessageTableViewController.swift
//  Techeria_iOS
//
//  Created by Jordan Melberg on 5/2/15.
//
//

import UIKit

class MessageTableViewController: UITableViewController {
    var messages:[Message] = [Message]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loggedIn = NSUserDefaults.standardUserDefaults().stringForKey("access_token")
        if (loggedIn == nil){
            self.performSegueWithIdentifier("login", sender: self)
        }
        else{
            getUserMessages()
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return messages.count
    }
    
    
    func getUserMessages(){
        var request = NSMutableURLRequest(URL: NSURL(string: "http://techeria1.appspot.com/api/messages")!)
        var loggedIn = NSUserDefaults.standardUserDefaults().stringForKey("access_token")!
        var token_auth = "token=\(loggedIn)"
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
            if let json: NSArray? = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: &err) as? NSArray{
                var json_error: NSError?
                if let separator: AnyObject  = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: &json_error){
                    var i = 0
                    while (i < separator.count) {
                        var message = Message()
                        if let type = separator[i]["type"] as? String{
                            message.type = type
                            if let sender = separator[i]["sender"] as? String{
                                message.sender = sender
                                if let recipient = separator[i]["recipient"] as? String{
                                    message.recipient = recipient
                                    if let text = separator[i]["text"] as? String{
                                        message.text = text
                                    }
                                }
                            }
                        }
                        self.messages.append(message)
                        i += 1
                    }
                }
                self.do_table_refresh()
            }
        }
    task.resume()
        
    }
    
    func do_table_refresh()
    {
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
            return
        })
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Message", forIndexPath: indexPath) as! UITableViewCell
        var sender = messages[indexPath.row].sender
        var text = messages[indexPath.row].text
        cell.textLabel?.text = sender
        cell.detailTextLabel?.text = text
        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            messages.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
