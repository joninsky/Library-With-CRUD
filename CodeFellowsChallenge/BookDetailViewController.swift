//
//  BookDetailViewController.swift
//  CodeFellowsChallenge
//
//  Created by Jon Vogel on 11/17/14.
//  Copyright (c) 2014 Jon Vogel. All rights reserved.
//

import Foundation

import UIKit

class BookDetailViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblIsChecked: UILabel!
    @IBOutlet weak var btnCheckInOut: UIButton!
    @IBOutlet weak var lblSelectShelfReminder: UILabel!
    @IBOutlet weak var shelfPicker: UIPickerView! = UIPickerView()
    
    var library: Library?
    var passedTitle: String?
    var passedAuthor: String?
    var theBook: Book?
    var selectedShelf: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        theBook = library?.getBook(passedTitle!, author: passedAuthor!)
        self.navigationItem.title = theBook!.bookTitle
        lblAuthor.text = theBook!.bookAuthor
        updateCheckedOutStatus()
        shelfPicker.delegate = self
        //shelfPicker.hidden = true
        //lblSelectShelfReminder.hidden = true
    }
    
    
    func updateCheckedOutStatus(){
        if theBook?.isCheckedOut == false{
            lblIsChecked.text = "Checked Into Shelf \(theBook!.shelfBookIsOn!.shelfNumber!)"
            btnCheckInOut.setTitle("Check Out", forState: UIControlState.Normal)
        }else{
            lblIsChecked.text = "Book is Checked Out"
            btnCheckInOut.setTitle("Check In", forState: UIControlState.Normal)
        }
    }
    
    
    
    @IBAction func btnCheckInOut(sender: AnyObject) {
        if theBook?.isCheckedOut == true {
            //shelfPicker.hidden = false
           //lblSelectShelfReminder.hidden = false
           
            library?.checkIn(theBook!, s: library!.arrayOfShelves[selectedShelf])
            updateCheckedOutStatus()
        }else{
            library?.checkOut(theBook!, s: theBook!.shelfBookIsOn!)
            theBook?.isCheckedOut == true
            updateCheckedOutStatus()
        }
    }
    
    
    
    @IBAction func updateButton(sender: AnyObject) {
        
   

        let updateAlert = UIAlertController(title: "Update \(theBook!.bookTitle!)", message: "You can change the Title and Author of this book", preferredStyle: UIAlertControllerStyle.Alert)
        updateAlert.addAction(UIAlertAction(title: "Update", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in
                var newTitle = updateAlert.textFields![0] as UITextField
                var newAuthor = updateAlert.textFields![1] as UITextField
                self.library!.updateBook(self.theBook!, newTitle: newTitle.text, newAuthor: newAuthor.text)
                self.refreshUI()
            }
        ))
        updateAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        updateAlert.addTextFieldWithConfigurationHandler( {textField in
        
            textField.placeholder = "New Title"
            }
            )
        updateAlert.addTextFieldWithConfigurationHandler( {textField in
                
                textField.placeholder = "New Author"
                }
        )
        presentViewController(updateAlert, animated: true, completion: nil)
        
        
    }
    
    func refreshUI () {
        
        self.navigationItem.title = theBook!.bookTitle
        lblAuthor.text = theBook!.bookAuthor
    }
    
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return library!.arrayOfShelves.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return "Shelf \(library!.arrayOfShelves[row].shelfNumber!)"
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedShelf = pickerView.selectedRowInComponent(component)
    }
    
    
    
}