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
    var items: [String] = []
    
    init (plistName name: String = "items") {
        
        // Build a path to the plist file (assuming it is in the main bundle,
        // which is where Xcode puts things by default
        // see: https://developer.apple.com/documentation/foundation/bundle
        let path = Bundle.main.path(forResource: name, ofType: "plist")!
        
        // Read the file into a variable.
        // the return type of the FileManager contents() method is an NSData object
        // which is basically a bunch of bytes
        let data = FileManager.default.contents(atPath: path)
        
        // the propertyList() method throws an exception when it encounters an error,
        // so we wrap it in a do-catch construct
        do {
            // The propertyList method converts our data into an Array
            // we cast it to an array of strings using the 'as' type casting operator:
            // https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/TypeCasting.html
            try items = PropertyListSerialization.propertyList(
                from: data!,
                options:PropertyListSerialization.MutabilityOptions.mutableContainers,
                format: nil) as! [String]
        } catch let e as NSError {
            // If there is an error, print its description to the concole
            print(e.localizedDescription)
        }
    }
    
    func randomItem() -> String {
        let numItems = UInt32(items.count)
        let randomIndex = Int(arc4random_uniform(numItems))
        
        return items[randomIndex]
    }
}


