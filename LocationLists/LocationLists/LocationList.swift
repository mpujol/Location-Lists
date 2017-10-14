//
//  LocationList.swift
//  LocationList
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
    
    var progress: Float {
        get {
            return Float(inactiveLists) / Float(list.count)
        }
    }
    
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

    init(name: String, list: [Item]) {
        self.name = name
        self.list = list
        
    }
    
    //MARK: - Helper Functions
    static func loadSampleLocationLists() -> [LocationList] {
        
        let sampleItem1 = Item(name: "Item 1", isItemComplete: false)
        let sampleItem2 = Item(name: "Item 2", isItemComplete: true)
        let sampleItem3 = Item(name: "Item 3", isItemComplete: false)
        
        let sampleItemArray = [sampleItem1,sampleItem2,sampleItem3]
        
        let locationList1 = LocationList(name: "Target", list: [])
        let locationList2 = LocationList(name: "CostCo", list: sampleItemArray)
        let locationList3 = LocationList(name: "GNC", list: sampleItemArray)
        
        
        return [locationList1,locationList2,locationList3]
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
        
        self.init(name: name, list: list)
        
    }
    
    
}
