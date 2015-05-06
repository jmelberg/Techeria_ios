//
//  ConnectionTableViewController.swift
//  Techeria_iOS
//
//  Created by Jordan Melberg on 5/4/15.
//
//

import UIKit

class ConnectionTableViewController: UITableViewController {
    var connections: [User] = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let all_connections = NSUserDefaults.standardUserDefaults().stringArrayForKey("posts")
        if(all_connections == nil){
            getConnections()
        }
        else{
            println("No Connections")
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
        return connections.count
    }

    //Get Feed Data
    func getConnections(){
        var current_user = NSUserDefaults.standardUserDefaults().stringForKey("username")!
        var URL = NSURL(string: "http://techeria1.appspot.com/api/connections?username=\(current_user)")
        var data = NSData(contentsOfURL: URL!)
        if let json: NSArray = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSArray {
            println(json)
            var json_error: NSError?
            if let separator: AnyObject  = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: &json_error){
                var i = 0
                println(separator)
                while (i < separator.count) {
                    var user = User()
                    if let employer = separator[i]["employer"] as? NSObject {
                        user.employer = employer
                        if let firstname = separator[i]["firstname"] as? NSObject {
                            user.firstName = firstname
                            if let lastname = separator[i]["lastname"] as? NSObject {
                                user.lastName = lastname
                                if let profession = separator[i]["profession"] as? NSObject {
                                    user.profession = profession
                                    if let type = separator[i]["type"] as? NSObject {
                                        if let username = separator[i]["username"] as? NSObject {
                                            user.username = username
                                        }
                                    }
                                }
                            }
                        }
                    }
                    self.connections.append(user)
                    i+=1
                }
                self.do_table_refresh()
            }
        }
    }


    func do_table_refresh()
    {
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
            return
        })
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Connection", forIndexPath: indexPath) as! UITableViewCell
        var name = "\(connections[indexPath.row].firstName) \(connections[indexPath.row].lastName)"
        var work = "\(connections[indexPath.row].profession) @ \(connections[indexPath.row].employer)"
        
        if let nameLabel = cell.viewWithTag(200) as? UILabel {
            nameLabel.text = name
        }
        if let workLabel = cell.viewWithTag(201) as? UILabel {
            workLabel.text = work
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let rowData = self.tableView.dequeueReusableCellWithIdentifier("Connection", forIndexPath: indexPath) as! UITableViewCell
    
        var connection = connections[indexPath.row].username
            
        NSUserDefaults.standardUserDefaults().setObject(connection, forKey: "connection")
        NSUserDefaults.standardUserDefaults().synchronize()
        println("Stored Connection Data")
        NSOperationQueue.mainQueue().addOperationWithBlock{
            self.performSegueWithIdentifier("connectionView", sender: self)
        }
    }

    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
