//
//  LibraryClass.swift
//  CodeFellowsChallenge
//
//  Created by Jon Vogel on 11/13/14.
//  Copyright (c) 2014 Jon Vogel. All rights reserved.
//

import Foundation

//My goal of the library class is to set it up in such a way that the ViewControllers only have to use a library object. The library object in turn uses shelf objects and the shelf object has book abjects. The library will also have an array of book abjects that are currently checked out.
class Library {
    
    //Varible to hold the library name, this gets set on init
    var libraryName: String?
    //An instantiated empty array of Shelf Objects. I instantiate it so that I don't have to check for instantiation when I use it
    lazy var arrayOfShelves: [Shelf] = [Shelf]()
    
    lazy var arrayOfCheckedOutBooks: [Book] = [Book]()

    //function to add a shelf to the library. When a Library is created it does not come with shelves
    func addShelf(){
        //create a shelf and number it accordign to the position in the array + 1. I add one because the shelfNumber property will be read by a human and I don't want 0 showing up
        var NS: Shelf = Shelf(shelfNumber: arrayOfShelves.count + 1)
        arrayOfShelves.append(NS)
    }
    
    //even though I don't use this function in the project I wanted to create it for OCD reasons.
    func deleteShelf(shelftoRemove: Int) {
        //check to make sure the shelve that we want to remove exists
        if shelftoRemove < arrayOfShelves.count{
            arrayOfShelves.removeAtIndex(shelftoRemove-1)
        }
    }
    
    func numberOfShelves() -> Int {
        return arrayOfShelves.count
    }
    
    //function to check in a book. Have to pass this funciton a book to check in and a shelf to check it into
    func checkIn (b: Book, s: Shelf){
        //call the check in book funciton for the shelf we are checking the book into
        s.checkInBook(b, shelfToPlaceBookOn: s)
        //search the array of checked out books to remove that book
        for var i = 0; i < arrayOfCheckedOutBooks.count; ++i{
            if b.bookTitle == arrayOfCheckedOutBooks[i].bookTitle && b.bookAuthor == arrayOfCheckedOutBooks[i].bookAuthor{
                arrayOfCheckedOutBooks.removeAtIndex(i)
            }
        }
    }
    
    //function to check out a book
    func checkOut (b: Book, s: Shelf) {
        //add the book that we are checking out to the array of books to check in
        arrayOfCheckedOutBooks.append(s.checkOutBook(b))
    }
    
    //get Book
    func getBook(title: String, author: String) -> Book?{

            var i: Int = 0
            //search checked out book for the book
            if arrayOfCheckedOutBooks.isEmpty == false{
                for  i ; i < arrayOfCheckedOutBooks.count; ++i{
                    if title == arrayOfCheckedOutBooks[i].bookTitle && author == arrayOfCheckedOutBooks[i].bookAuthor{
                        return arrayOfCheckedOutBooks[i]
                    }
                }
            }
            //search books on the shelves for the book
            for s in arrayOfShelves{
                for i = 0; i < s.booksOnShelf.count; ++i {
                    if title == s.booksOnShelf[i].bookTitle && author == s.booksOnShelf[i].bookAuthor{
                        return s.booksOnShelf[i]
                    }
                }
            }
        //if book does not exist return nil
        return nil
    }
    
    
    
    //addition of a book needs three things: title, author, and Shelf to put it on
    func addBook (title: String, author: String, shelf: Int) {
        //create a Book object
        var b = Book(Title: title, Author: author, TheShelf: arrayOfShelves[shelf])
        //Check the book into the shelf. The Shelves checkInBook method calls the Books enshelf method
    }
    
    func deleteBook (title: String, author: String) -> Bool?{
        //declare bool to return
        var didWork = false
        //search every shelf in the array of shelves
        for s in arrayOfShelves{
            //search every book in the array of books for each Shelf
            for var i = 0; i < s.booksOnShelf.count; ++i {
                //check if book exists based of title and author
                if s.booksOnShelf[i].bookAuthor == author && s.booksOnShelf[i].bookTitle == title{
                    //remove book if found
                    s.booksOnShelf.removeAtIndex(i)
                   //return true
                    didWork = true
                }
            }
        }
    
            for var i = 0; i < arrayOfCheckedOutBooks.count; ++i {
                //check if book exists based of title and author
                if arrayOfCheckedOutBooks[i].bookAuthor == author && arrayOfCheckedOutBooks[i].bookTitle == title{
                    //remove book if found
                    arrayOfCheckedOutBooks.removeAtIndex(i)
                    //return true
                    didWork = true
                }
            }
        return didWork
    }
    
    //Get the books on a particular Shelf. Takes an int paramater because the index of the table view row will be used to determine which shelf we get book from
    func getBooksForShelf (shelfToLookAtBooks: Int) ->[Book]{
        //return the array of books on a given shelf
        return arrayOfShelves[shelfToLookAtBooks].booksOnShelf
    }
    
    //To update a book we need a book and a new title and author
    func updateBook(theOriginalBook: Book, newTitle: String, newAuthor: String) {
        //update the books title
        theOriginalBook.bookTitle = newTitle
        //update the books author
        theOriginalBook.bookAuthor = newAuthor
    }
    
    //get all the books in all the shelves and return them as an array
    func getAllBooks() -> [Book]{
        //declare array to return
        var allBooks = [Book]()
        //for each shelf in the library
        for s in arrayOfShelves{
            //look at each book in the shelf
            for b in s.booksOnShelf{
                //append it to the array to return
                allBooks.append(b)
            }
        }
        //return the array of all the books
        return allBooks
    }
    
    //initalize an array with a name
    init (libraryName: String) {
        self.libraryName = libraryName
    }
    
}