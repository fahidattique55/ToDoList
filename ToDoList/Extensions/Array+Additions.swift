//
//  Array+Additions.swift
//  ToDoList
//
//  Created by Fahid Attique on 13/09/2017.
//  Copyright © 2017 Fahid Attique. All rights reserved.
//

import Foundation


extension Array {
    
    mutating func removeObject<T: Equatable> (_ objet: T) -> Bool {

        for (idx, objectToCompare) in self.enumerated() {
            if let to = objectToCompare as? T {
                if objet == to {
                    self.remove(at: idx)
                    return true
                }
            }
        }
        return false
    }
    
}
