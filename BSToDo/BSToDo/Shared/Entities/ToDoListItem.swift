//
//  ToDoListItem.swift
//  BSToDo
//
//  Created by Burak SIPCIKOGLU on 17/07/2017.
//  Copyright © 2017 burak. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListItem: Object{
    var note: String?
    var priority: NSNumber = NSNumber(value: 0)
    var date: Date?
    var id: String?
    var done: Bool = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
