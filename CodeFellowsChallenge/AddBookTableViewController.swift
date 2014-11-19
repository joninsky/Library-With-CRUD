//
//  AddBookTableViewController.swift
//  CodeFellowsChallenge
//
//  Created by Jon Vogel on 11/18/14.
//  Copyright (c) 2014 Jon Vogel. All rights reserved.
//

import Foundation
import UIKit

class AddBookTableViewController: UITableViewController {
    
    var arrayOfLibraries: [Library]?
    var IP: NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Selecte A Library!"
        
    }
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfLibraries!.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Please Select A Library to Add a Book To"
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var Cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        Cell.textLabel?.text = arrayOfLibraries![indexPath.row].libraryName!
        return Cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        IP = indexPath
        performSegueWithIdentifier("addBookDetail", sender: self)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier{
            case "addBookDetail":
                //var IP = tableView.in
                var DVC = segue.destinationViewController as AddBookDetailViewController
                DVC.theLibrary = arrayOfLibraries![IP!.row]
           // EXC_BAD_ACCESS (Code=2,address=0x10a2fa38)
        default:
            println("Unable Segue")
        }
    }
    
}