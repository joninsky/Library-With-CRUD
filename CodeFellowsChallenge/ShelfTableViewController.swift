//
//  ShelfTableViewController.swift
//  CodeFellowsChallenge
//
//  Created by Jon Vogel on 11/13/14.
//  Copyright (c) 2014 Jon Vogel. All rights reserved.
//

import Foundation
import UIKit

class ShelfTableViewController: UITableViewController {
    
    var theLibrary: Library?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Shelves"
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return theLibrary!.arrayOfShelves.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var Cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        Cell.textLabel?.text = "Shelf \(theLibrary!.arrayOfShelves[indexPath.row].shelfNumber!)"
        return Cell
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("goToBooks", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier {
            case "goToBooks":
                var i = tableView.indexPathForCell(sender as UITableViewCell)
                var DC = segue.destinationViewController as BookTableViewController
                DC.theLibrary = self.theLibrary
                DC.selectedShelf = i!.row
            case "goToAllBooks":
                var DVC = segue.destinationViewController as AllBooksTableViewController
                DVC.library = theLibrary!
        default:
            println("Unable segue")
        }
        
    }
    
    
    @IBAction func seeAllBooksInLibrary(sender: AnyObject) {
        performSegueWithIdentifier("goToAllBooks", sender: self)
    }
    
    
}