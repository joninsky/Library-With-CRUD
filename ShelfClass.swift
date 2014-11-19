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
    
    func checkOutBook(bookToCheckOut: Book) -> Book {
        for var i = 0; i < booksOnShelf.count; ++i {
            if bookToCheckOut.bookTitle == booksOnShelf[i].bookTitle && bookToCheckOut.bookAuthor == booksOnShelf[i].bookAuthor {
                booksOnShelf.removeAtIndex(i)
            }
        }
        return bookToCheckOut.unshelf()
    }
    
    func checkInBook(bookToCheckIn: Book, shelfToPlaceBookOn: Shelf) {
        bookToCheckIn.enshelf(shelfToPlaceBookOn)
        booksOnShelf.append(bookToCheckIn)
    }

    init (shelfNumber: Int){
        self.shelfNumber = shelfNumber
    }
    
    
}