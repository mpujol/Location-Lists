//
//  LocationLists.swift
//  LocationLists
//
//  Created by Michael Pujol on 8/2/17.
//  Copyright © 2017 Michael Pujol. All rights reserved.
//

import Foundation
import UIKit

class LocationList: NSObject, NSCoding {
    
    //MARK: - Properties
    
    var name: String
    var list: [Item]
    
    var activeLists: Int {
        get {
            var activeItemCount = 0
            for item in list {
                if item.isItemComplete == true {
                    activeItemCount += 1
                }
            }
            return activeItemCount
        }
    }
    
    var inactiveLists: Int {
        get {
            return list.count - activeLists
        }
    }

    
    var image: UIImage?
    
    var isActive: Bool {
        get {
            var numberOfCompletedItems = 0
            for item in list {
                if item.isItemComplete == true {
                    numberOfCompletedItems += 1
                }
            }
            if numberOfCompletedItems == list.count {
                return false
            } else {
                return true
            }
        }
    }
    
    override var description: String {
        return "\(name): has \(list.count) item/s"
    }

    init(name: String, list: [Item], image: UIImage?) {
        self.name = name
        self.list = list
        self.image = image
        
    }
    
    //MARK: - Helper Functions
    static func loadSampleLocationLists() -> [LocationList] {
        
        let sampleItem1 = Item(name: "Item 1", isItemComplete: false)
        let sampleItem2 = Item(name: "Item 2", isItemComplete: true)
        let sampleItem3 = Item(name: "Item 3", isItemComplete: false)
        
        let sampleItemArray = [sampleItem1,sampleItem2,sampleItem3]
        
        let locationList1 = LocationList(name: "One", list: [], image: nil)
        let locationList2 = LocationList(name: "Two", list: sampleItemArray, image: nil)
        let locationList3 = LocationList(name: "Three", list: sampleItemArray, image: nil)
        let locationList4 = LocationList(name: "Four", list: sampleItemArray, image: nil)
        let locationList5 = LocationList(name: "Five", list: sampleItemArray, image: nil)
        let locationList6 = LocationList(name: "Six", list: sampleItemArray, image: nil)
        let locationList7 = LocationList(name: "Seven", list: sampleItemArray, image: nil)
        
        return [locationList1,locationList2,locationList3,locationList4,locationList5,locationList6,locationList7]
    }
    
    //MARK: - NSCoding Protocols + Saving & Loading
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("locationList")
    
    static func saveLocationLists(_ locationLists: [LocationList]) {
        NSKeyedArchiver.archiveRootObject(locationLists, toFile: LocationList.ArchiveURL.path)
    }
    
    static func loadLocationLists() -> [LocationList]? {
        
        return NSKeyedUnarchiver.unarchiveObject(withFile: LocationList.ArchiveURL.path) as? [LocationList]
        
    }
    
    struct PropertyKeys {
        static let name = "name"
        static let list = "list"
        static let image = "image"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKeys.name)
        aCoder.encode(list, forKey: PropertyKeys.list)
        aCoder.encode(image, forKey: PropertyKeys.image)
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        guard let name = aDecoder.decodeObject(forKey: PropertyKeys.name) as? String,
            let list = aDecoder.decodeObject(forKey: PropertyKeys.list) as? [Item] else { return nil }
        
        print("decoded List \(list)")
        
        let image = aDecoder.decodeObject(forKey: PropertyKeys.image) as? UIImage
        
        self.init(name: name, list: list, image: image)
        
    }
    
    
}
