//
//  IssueDetailTableViewController.swift
//  MyGithub
//
//  Created by David Nadri on 6/15/16.
//  Copyright © 2016 David Nadri. All rights reserved.
//

import UIKit
import Alamofire

class IssueDetailTableViewController: UITableViewController {

    var issue: Issue!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("IssueDetailTableViewController: viewDidLoad() called.")
        
        self.title = "Issue #\(issue.number!)"
        
        getIssueComments()
        
        // Self-sizing cells (auto-layout constraints must be set for cell)
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        
        // Removes extra cell separators below tableview (of empty/unused cells)
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
    }
    
    func getIssueComments() {
        
        print("getIssueDetail() called.")
        print("issue: \(issue.commentsURL!)")
        
//        let urlString = issue?.commentsURL!
//        Alamofire.request(.GET, urlString!).validate(statusCode: 200..<300).responseJSON { response in
//            print(response.request)  // original URL request
//            print(response.response) // URL response
//            print(response.data)     // server data
//            print(response.result)   // result of response serialization
//            
//            if let json = response.result.value {
//                print("***json: \(json)")
//                print("***json.count: \(json.count)")
//                
//                for item in json as! [AnyObject] {
//                    print("item in JSON: \(item)")
//                    
//                    let issue = Issue(number: item["number"] as? Int, title: item["title"] as? String, body: item["body"] as? String, comments: item["comments"] as? Int, commentsURL: item["comments_url"] as? String, timestamp: item["updated_at"] as? String, state: item["state"] as? String)
//                    
//                    self.issues.append(issue)
//                    
//                    
//                }
//                
//                self.tableView.reloadData()
//                
//            } else {
//                
//                print("ERROR: \(response.result.error)")
//                let alert = UIAlertController(title: "Error", message: "\(response.result.error)", preferredStyle: .Alert)
//                alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
//                alert.presentViewController(alert, animated: true, completion: nil)
//                
//            }
//            
//        }
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("IssueDetailCell") as! IssueDetailTableViewCell
        
        cell.numberLabel.text = "#\(issue.number!)"
        
        cell.titleLabel.text = issue.title!
        
        cell.bodyLabel.text = issue.body!
        
        // i.e.: "Updated 4 days ago"
        let dateFormatter = NSDateFormatter()
        // The format must match the timestamp string otherwise it will return nil
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:sszzz"
        let date = dateFormatter.dateFromString(issue.timestamp!)
        cell.timestampLabel.text = NSDate().offsetFrom(date!)
        
        if issue.state! == "closed" {
            // Ideal to create constants for things like image names, but in the interest of time...
            cell.stateImageView.image = UIImage(named: "closed")
        } else {
            cell.stateImageView.image = UIImage(named: "opened")
        }
        
        return cell
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showEditIssueTableViewController" {
            
            print("prepareForSegue: showEditIssueTableViewController.")
            
            let nav = segue.destinationViewController as! UINavigationController
            
            let destinationVC = nav.topViewController as! EditIssueTableViewController
            
            // Pass the issue to the EditIssueTableViewController to edit the correct issue
            destinationVC.issue = issue
            
        }
        
    }
    
    
}
