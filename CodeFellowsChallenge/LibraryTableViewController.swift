//
//  ViewController.swift
//  CodeFellowsChallenge
//
//  Created by Jon Vogel on 11/13/14.
//  Copyright (c) 2014 Jon Vogel. All rights reserved.
//

import UIKit

class LibraryTableViewController: UITableViewController {

    lazy var libraries: [Library] = [Library]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateLibraries()
        self.navigationItem.title = "Libraries"
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return libraries.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var Cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        Cell.textLabel?.text = libraries[indexPath.row].libraryName!
        return Cell
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("goToShelves", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier{
            case "goToShelves":
                var i = tableView.indexPathForCell(sender as UITableViewCell) as NSIndexPath!
                var DC = segue.destinationViewController as ShelfTableViewController
                DC.theLibrary = libraries[i.row]
            case "addABook":
                var DVC = segue.destinationViewController as AddBookTableViewController
                DVC.arrayOfLibraries = libraries
            default:
                println("Unable Segue")
        }
    }
    
    
    @IBAction func addABookButton(sender: AnyObject) {
        performSegueWithIdentifier("addABook", sender: self)
    }

    
    
    
    
    func populateLibraries(){
        
        //create an array of book titles for use in libraries.
        let arrayOfBookTitles: [String] = [
            "The Dark Moon Letdowns",
            "Typing for Blind People",
            "Perfect Skylights",
            "Turning Pizza into Software",
            "No Sex, No Love, Just Coding",
            "When I Spun Myself Silly",
            "Smuckers",
            "Perfect Percolation",
            "Turn the Volume Up! I Can’t Hear That Gif",
            "Weird Wednesdays",
            "The Friend Factor",
            "Midnight by Rail",
            "Dumbfounded",
            "Point of Avoidance",
            "Splicing your Genes",
            "Fake Plants",
            "Popovers and Blood Pressure",
            "Three Careers Before 30"]
        
        //create an array of Autors for use in libraries.
        let arrayOfAuthors: [String] = [
            "Peter Pixel",
            "Amanda the Great",
            "Conan the Regulator",
            "Dan Deluge",
            "Frustrated Russ",
            "Carol Mettenberger",
            "Jam Jones",
            "Great Scott",
            "Ron Nguyen",
            "Quinn Hemmons",
            "Julie Flake",
            "James Lockett",
            "Zach Christy",
            "Celeste Luna",
            "God",
            "Bill Fence",
            "Scammy Sam",
            "Jon Vogel"]
        
        
        //create three libraries
        var lOne: Library = Library(libraryName: "SLU Public Library")
        var lTwo: Library = Library(libraryName: "The Great Book Case")
        var lThree: Library = Library(libraryName: "Silence of the Students")
        
        //add the libraries to the libraries array
        libraries = [lOne,lTwo,lThree]
        
        //add two shelves to Each Library
        for var i = 0; i < libraries.count; ++i{
            libraries[i].addShelf()
            libraries[i].addShelf()
            libraries[i].addShelf()
        }
        
        //for each library in array of Libraries
        for l in libraries{
            //add each book to the library
            for var i = 0; i < arrayOfBookTitles.count; ++i{
                //add first half of books to shelf 1
                if i < ((arrayOfBookTitles.count + 1)/2){
                    l.addBook(arrayOfBookTitles[i], author: arrayOfAuthors[i], shelf: 0)
                }else{
                // add second half of books to shelf 2
                    l.addBook(arrayOfBookTitles[i], author: arrayOfAuthors[i], shelf: 1)

                }
            }
        }
    }

}

