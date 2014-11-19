//
//  CheckedOutBooksTableViewController.swift
//  CodeFellowsChallenge
//
//  Created by Jon Vogel on 11/17/14.
//  Copyright (c) 2014 Jon Vogel. All rights reserved.
//

import Foundation
import UIKit

class CheckedOutBooksTableViewController: UITableViewController {
    
    var library: Library?
    var titleToPass: String?
    var authorToPass: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title =  "Checked Out"
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return library!.arrayOfCheckedOutBooks.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var Cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        Cell.textLabel?.text = library!.arrayOfCheckedOutBooks[indexPath.row].bookTitle
        Cell.detailTextLabel?.text = library!.arrayOfCheckedOutBooks[indexPath.row].bookAuthor
        return Cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var IP = tableView.indexPathForSelectedRow()
        var Cell = tableView.cellForRowAtIndexPath(IP!) as UITableViewCell!
        if Cell.textLabel?.text != "No Checked out books"{
            titleToPass = Cell.textLabel?.text
            authorToPass = Cell.detailTextLabel?.text
            performSegueWithIdentifier("showCheckedOutBookDetail", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var DVC = segue.destinationViewController as BookDetailViewController
        DVC.library = self.library
        DVC.passedTitle = titleToPass
        DVC.passedAuthor = authorToPass
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete{
            var Cell = tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell!
            library!.deleteBook(Cell.textLabel!.text!, author: Cell.detailTextLabel!.text!)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Bottom)
        }
    }
    
    
}