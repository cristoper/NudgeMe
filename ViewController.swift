//
//  FirstViewController.swift
//  TabbedApp
//
//  Created by LouisDotCom on 8/5/17.
//  Copyright © 2017 LB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Stored property references the ItemArray object which serves as the data source for our view controller
    // we instantiate the ItemArray in the viewDidLoad method
    var items: ItemArray? = nil
    
    //LB: this is where I add the IBOutlet (from http://www.richardhsu.me/posts/2015/01/17/textview-border.html)
    @IBOutlet weak var TextViewItem: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //LB: this is where I add border (from http://www.richardhsu.me/posts/2015/01/17/textview-border.html)
        let borderColor : UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)//(red: 0.7, green: 0.2, blue: 0.0, alpha: 1.0)
        TextViewItem.layer.borderWidth = 1
        TextViewItem.layer.borderColor = borderColor.cgColor
        TextViewItem.layer.cornerRadius = 5.0
        
        // Instantiate ItemArray data source object
        items = ItemArray(plistName: "items")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //LB: Outside editing options, this is the only control for the user, to display an item in the TextViewItem
    @IBAction func NextItemControl(_ sender: UIButton) {
        
        // Display a random item
        if let randomItem = items?.randomItem() {
            TextViewItem.text=(" \(randomItem) ")
        }
    }
}
//TODO: modify random function so it recognizes the "Frequency" and "TimeSensitive" fields in the plist
//TODO: when user edits items, he/she should be able to set these fields
//TODO: user should be able to restore defaults
//TODO: user should be able to wipe out customizations (but not go back to defaults) in order to have a blank list
//LB TODO: (from email to Chris 11/28/17) What I envision in the Customize view is this:
// - The table would show all the items, scrollable.
// - Each row would allow a left-swipe with 3 options: delete, edit, and advanced. (edit might not be necessary, just a new button)
// - If advanced were chosen, then the single record would probably have its own screen (a hierarchical drill down), and there the additional fields would show up: Frequency (low, medium, high) and TimeSensitive (all, day, night)--and be editable (otherwise medium and all would be the defaults)
// - Additionally (ultimately), somewhere in the first customize screen would be options to (1) restore defaults... the plist shipped and (2) delete all suggestions (giving the user a blank slate, esp. useful if he/she wants only a short list, say of 5 or 10 items
// - I'm wondering if in the advanced screen, the user could set a suggestion to "remind me once a day or week or month" -- it seems there must be some standard functions for reminders (used in Apple's Reminders app for example... I don't suppose Apple let's us view the code for their standard apps, do they?)

