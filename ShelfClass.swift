//
//  ShelfClass.swift
//  CodeFellowsChallenge
//
//  Created by Jon Vogel on 11/13/14.
//  Copyright (c) 2014 Jon Vogel. All rights reserved.
//

import Foundation

class Shelf {
    
    //declare an array of books and 
    lazy var booksOnShelf: [Book] = [Book]()
    var shelfNumber: Int?
    
    //function that is called when a book is checked out. It returns the book to check out and calls the unshelf method of the book
    func checkOutBook(bookToCheckOut: Book) -> Book {
        for var i = 0; i < booksOnShelf.count; ++i {
            if bookToCheckOut.bookTitle == booksOnShelf[i].bookTitle && bookToCheckOut.bookAuthor == booksOnShelf[i].bookAuthor {
                booksOnShelf.removeAtIndex(i)
            }
        }
        return bookToCheckOut.unshelf()
    }
    
    //function to check in book to this shelf.
    func checkInBook(bookToCheckIn: Book, shelfToPlaceBookOn: Shelf) {
        bookToCheckIn.enshelf(shelfToPlaceBookOn)
        booksOnShelf.append(bookToCheckIn)
    }

    init (shelfNumber: Int){
        self.shelfNumber = shelfNumber
    }
    
    
}