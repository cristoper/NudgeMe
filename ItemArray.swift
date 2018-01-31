//
//  ItemArray.swift
//  NextItem
//
//  Created by cris on 8/4/17.
//

import Foundation

struct ItemArray {
    
    // This is a stored property (whose type is an Array of Strings) which will store the
    // list of items in memory once they are read from the plist file
    var items: [String] = ["Go for a jog", "Work on your novel", "Read 20 pages in your current book"]
    
    init (plistName name: String = "items") {
        /* A note on error handling in this initializer -
           We use everywhere explicit unwrapping of optionals (!), non-propagating exceptions (try!) and forced downcasting (as!). The result is that any error in getting the main bundle, reading the plist.info file, or converting it to a [string] variable will crash the program.

           Since we can be reasonably sure that none of thes will fail (we provide the info.plist along with the application), but a more robust program would allow any of these to fail, log/report the error, then use a reasonable default value for items.
        */
        
        // Build a path to the plist file (assuming it is in the main bundle,
        // which is where Xcode puts things by default
        // see: https://developer.apple.com/documentation/foundation/bundle
        let path = Bundle.main.path(forResource: name, ofType: "plist")!
        
        // Read the file into a variable.
        // the return type of the FileManager contents() method is an NSData object
        // which is basically a bunch of bytes
        let data = FileManager.default.contents(atPath: path)!
        
        // The propertyList method converts our data into an Array
        // we cast it to an array of strings using the 'as' type casting operator:
        // https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/TypeCasting.html
        items = try! PropertyListSerialization.propertyList(
            from: data,
            options:PropertyListSerialization.MutabilityOptions.mutableContainers,
            format: nil) as! [String]
    }
    
    func randomItem() -> String {
        let numItems = UInt32(items.count)
        let randomIndex = Int(arc4random_uniform(numItems))
        
        return items[randomIndex]
    }
}


