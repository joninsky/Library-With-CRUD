//
//  AddBookDetailViewController.swift
//  CodeFellowsChallenge
//
//  Created by Jon Vogel on 11/18/14.
//  Copyright (c) 2014 Jon Vogel. All rights reserved.
//

import Foundation
import UIKit

class AddBookDetailViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var theLibrary: Library?
    var selectedShelf: Int?
    
    @IBOutlet weak var txtBookTitle: UITextField!
    @IBOutlet weak var txtBookAuthor: UITextField!
    @IBOutlet weak var shelfPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shelfPicker.delegate = self
        self.navigationItem.title = theLibrary!.libraryName
    }
    
    @IBAction func addTheBookButton(sender: AnyObject) {
        println(txtBookTitle.text)
        if txtBookAuthor.text != "" && txtBookTitle.text != "" && shelfPicker != nil{
            theLibrary?.addBook(txtBookTitle.text, author: txtBookAuthor.text, shelf: selectedShelf!)
        }else{
            println("Unable To Add Book")
        }
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return theLibrary!.arrayOfShelves.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return "Shelf \(theLibrary!.arrayOfShelves[row].shelfNumber!)"
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedShelf = pickerView.selectedRowInComponent(component)
    }

    
    
    
}