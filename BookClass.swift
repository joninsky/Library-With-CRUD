//
//  BookClass.swift
//  CodeFellowsChallenge
//
//  Created by Jon Vogel on 11/13/14.
//  Copyright (c) 2014 Jon Vogel. All rights reserved.
//

import Foundation

class Book  {
    
    var bookTitle: String?
    var bookAuthor: String?
    var shelfBookIsOn: Shelf?
    var isCheckedOut: Bool?
    
    
    //method to check a book in
    func enshelf (shelfToAddTo: Shelf){
        self.shelfBookIsOn = shelfToAddTo
        self.isCheckedOut = false
    }
    
    //method to check a book out
    func unshelf() -> Book{
        shelfBookIsOn = nil
        isCheckedOut = true
        return self
    }

    
    
    
    init (Title t: String, Author a: String, TheShelf s: Shelf) {
        bookTitle = t
        bookAuthor = a
        shelfBookIsOn = s
        s.booksOnShelf.append(self)
        isCheckedOut = false
    }
    
    
}