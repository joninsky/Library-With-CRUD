//
//  AllBooksTableViewController.swift
//  CodeFellowsChallenge
//
//  Created by Jon Vogel on 11/15/14.
//  Copyright (c) 2014 Jon Vogel. All rights reserved.
//

import Foundation
import UIKit

class AllBooksTableViewController: UITableViewController {
    
    var library: Library?
    var titleToPass: String?
    var authorToPass: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "All Books"
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var allBooks: [Book] = library!.getAllBooks()
        //allBooks += library!.arrayOfCheckedOutBooks
        return allBooks.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var Cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        var allBooks: [Book] = library!.getAllBooks()
        allBooks += library!.arrayOfCheckedOutBooks
        Cell.textLabel?.text = allBooks[indexPath.row].bookTitle
        Cell.detailTextLabel?.text = allBooks[indexPath.row].bookAuthor
        return Cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var i = tableView.indexPathForSelectedRow()
        var Cell = tableView.cellForRowAtIndexPath(i!) as UITableViewCell!
        titleToPass = Cell.textLabel?.text
        authorToPass = Cell.detailTextLabel?.text
        performSegueWithIdentifier("showAllBooksDetail", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier{
            case "showAllBooksDetail":
                var DC = segue.destinationViewController as BookDetailViewController
                DC.library = self.library!
                DC.passedTitle = self.titleToPass
                DC.passedAuthor = self.authorToPass
            case "showCheckedOutBooks":
                var DVC = segue.destinationViewController as CheckedOutBooksTableViewController
                DVC.library = self.library!
        default:
            println("Unable Segue")
        }
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
    
    @IBAction func seeAllCheckedOutBooks(sender: AnyObject) {
        performSegueWithIdentifier("showCheckedOutBooks", sender: self)
    }
    
    
}