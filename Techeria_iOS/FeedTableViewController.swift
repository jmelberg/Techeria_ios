//
//  FeedTableViewController.swift
//  Techeria_iOS
//
//  Created by Jordan Melberg on 5/2/15.
//
//

import UIKit

class FeedTableViewController: UITableViewController {

    var posts:[Forum] = [Forum]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let current_posts = NSUserDefaults.standardUserDefaults().stringForKey("posts")
        if (current_posts == nil){
            //Update Feed Data
            getFeedData()
        }
        else{
            println("feed here...")
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
        return posts.count
    }
    
    //Get Feed Data
    func getFeedData(){
        var request = NSMutableURLRequest(URL: NSURL(string: "http://techeria1.appspot.com/api/feedlist")!)
        var loggedIn = NSUserDefaults.standardUserDefaults().stringForKey("access_token")!
        var token_auth = "token=\(loggedIn)&page=0&items=feed"
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
                if let separator  = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: &json_error){
                    var i = 0
                    while (i < separator.count) {
                        var post = Forum()
                        if let author = separator[i]["author"] as? String{
                            post.author = author
                            if let forum = separator[i]["forum"] as? String{
                                post.forum = forum
                                if let reference = separator[i]["reference"] as? String{
                                    post.reference = reference
                                    if let text = separator[i]["text"] as? String{
                                        post.text = text
                                        if let type = separator[i]["type"] as? String{
                                            post.type = type
                                            if let url = separator[i]["url"] as? String{
                                                post.url = url
                                                if let votes = separator[i]["votes"] as? Int{
                                                    post.votes = votes
                                                    println(votes)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        self.posts.append(post)
                        i += 1
                    }
                    self.do_table_refresh()
                }
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
        let cell = tableView.dequeueReusableCellWithIdentifier("Post", forIndexPath: indexPath) as! UITableViewCell
        var name = posts[indexPath.row].forum
        var author = posts[indexPath.row].author
        var text = posts[indexPath.row].reference
        var upvote = posts[indexPath.row].votes
        
        println(upvote)
        
        
        if let nameLabel = cell.viewWithTag(100) as? UILabel {
            nameLabel.text = text
        }
        if let descriptionLabel = cell.viewWithTag(101) as? UILabel {
            descriptionLabel.text = "Submitted to \(name) by \(author)"
        }
        if let upvoteLabel = cell.viewWithTag(99) as? UILabel {
            upvoteLabel.text = String(upvote)
        }
//        cell.ForumLabel?.text = text
//        cell.DescriptionLabel?.text = "Submitted to \(name) by \(author)"
        return cell
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
