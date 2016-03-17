//
//  AddViewController.swift
//  votes
//
//  Created by Dylan Sharkey on 3/17/16.
//  Copyright © 2016 Dylan Sharkey. All rights reserved.
//

import UIKit
import RealmSwift
import CoreData

class AddViewController: UIViewController  {
    
    let realm = try! Realm()
    let managedContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    let app = UIApplication.sharedApplication().delegate as! AppDelegate
    var delegate: detailsProtocol?
    
    @IBOutlet weak var newTopicTextField: UITextField!
    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        if newTopicTextField.text != "" {
            let myTopic = Topic()
            myTopic.name = newTopicTextField.text!
            try! realm.write{
                realm.add(myTopic)
            }
            
            var entity = NSEntityDescription.entityForName("Topics", inManagedObjectContext: managedContext)
            var topic: Topics = Topics(entity: entity!, insertIntoManagedObjectContext: managedContext)
            topic.setValue(newTopicTextField.text!, forKey: "name")
            topic.setValue(1, forKey: "votes")
            app.saveContext()
            
            //save new item to realm
            delegate?.goBack()
        }
    }
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        delegate?.goBack()
    }
}
