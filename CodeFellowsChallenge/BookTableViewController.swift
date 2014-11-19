//
//  BookTableViewController.swift
//  CodeFellowsChallenge
//
//  Created by Jon Vogel on 11/13/14.
//  Copyright (c) 2014 Jon Vogel. All rights reserved.
//

import Foundation
import UIKit

class BookTableViewController: UITableViewController {
    
    var theLibrary: Library?
    var selectedShelf: Int?
    var selectedBooktitle: String?
    var selectedBookauthor: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Books on Shelf \(selectedShelf! + 1)"
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var b = theLibrary?.getBooksForShelf(selectedShelf!)
        return b!.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var Cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        var b = theLibrary?.getBooksForShelf(selectedShelf!)
        Cell.textLabel?.text = b![indexPath.row].bookTitle
        Cell.detailTextLabel?.text = b![indexPath.row].bookAuthor
        return Cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var iP = tableView.indexPathForSelectedRow()
        var Cell = tableView.cellForRowAtIndexPath(iP!) as UITableViewCell!
        selectedBooktitle = Cell?.textLabel?.text
        selectedBookauthor = Cell?.detailTextLabel?.text
        performSegueWithIdentifier("bookDetailSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "bookDetailSegue" {
            var DVC = segue.destinationViewController as BookDetailViewController
            DVC.library = theLibrary
            DVC.passedTitle = selectedBooktitle
            DVC.passedAuthor = selectedBookauthor
        }else if segue.identifier == "checkedOutBooks" {
            var DC = segue.destinationViewController as CheckedOutBooksTableViewController
            DC.library = self.theLibrary!
        }else {
            println("Unable Segue")
        }
    }
    
    @IBAction func viewCheckedOutBooks(sender: AnyObject) {
        performSegueWithIdentifier("checkedOutBooks", sender: self)
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete{
            var Cell = tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell!
            theLibrary!.deleteBook(Cell.textLabel!.text!, author: Cell.detailTextLabel!.text!)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Bottom)
        }
    }
    
    
        
}