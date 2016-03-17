//
//  MainTableViewController.swift
//  votes
//
//  Created by Dylan Sharkey on 3/17/16.
//  Copyright © 2016 Dylan Sharkey. All rights reserved.
//

import UIKit
import RealmSwift
import CoreData

class MainTableViewController: UITableViewController, detailsProtocol, tableDelegate {
    let realm = try! Realm()
    var allTopics: Results<Topic>?
    var myTopics: [Topics]?
    
    let managedContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    let app = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBAction func addButtonPressed(sender: UIBarButtonItem) {
        performSegueWithIdentifier("detailsSegue", sender: nil)
    }
    
    func goBack() {
        dismissViewControllerAnimated(true, completion: nil)
        tableView.reloadData()
    }
    
    func upVotePressed(cell: AnyObject) {
        let indexPath = tableView.indexPathForCell(cell as! topicCell)!
        try! realm.write{
            var num = Int(myTopics![indexPath.row].votes!)
            num++
            myTopics![indexPath.row].votes! = NSNumber(integer: num)
            app.saveContext()
        }
        tableView.reloadData()
    }

    func downVotePressed(cell: AnyObject) {
        let indexPath = tableView.indexPathForCell(cell as! topicCell)!
        if allTopics![indexPath.row].votes == 0 {
            try! realm.write{
                realm.delete(allTopics![indexPath.row])
            }
        } else {
            try! realm.write{
                allTopics![indexPath.row].votes--
            }
        }
        tableView.reloadData()
    }

    
    // MARK: - Table view data source

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navController = segue.destinationViewController as! UINavigationController
        let controller = navController.topViewController as! AddViewController
        controller.delegate = self
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        allTopics = realm.objects(Topic)
        let fetchRequest = NSFetchRequest(entityName: "Topics")
        do {
            let fetchedEntities = try managedContext.executeFetchRequest(fetchRequest)
            myTopics = fetchedEntities as? [Topics]
        } catch {
            let nserror = error as NSError
            print(nserror.userInfo)
        }
        return myTopics!.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("topicCell", forIndexPath: indexPath) as! topicCell
        cell.delegate = self
        cell.topicLabel.text = myTopics![indexPath.row].name!
        cell.numVotesLabel.text = "Votes: " + String(myTopics![indexPath.row].votes!)
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
