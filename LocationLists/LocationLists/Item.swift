//
//  Item.swift
//  LocationLists
//
//  Created by Michael Pujol on 8/3/17.
//  Copyright © 2017 Michael Pujol. All rights reserved.
//

import Foundation

class Item: NSObject, Codable  {
    
    var name: String
    var isItemComplete: Bool
    
    
    init(name: String, isItemComplete: Bool) {
        self.name = name
        self.isItemComplete = isItemComplete
        
    }
    
    override var description: String {
        return "\(name)"
    }
    
    //MARK: - NSCoding Protocols
    
    struct PropertyKeys {
        static let name = "itemName"
        static let isItemComplete = "isItemComplete"
    }

    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKeys.name)
        aCoder.encode(isItemComplete, forKey: PropertyKeys.isItemComplete)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: PropertyKeys.name) as? String else { return nil }
        
        let isItemComplete = aDecoder.decodeBool(forKey: PropertyKeys.isItemComplete)
        
        self.init(name: name, isItemComplete: isItemComplete)
        
    }

}

