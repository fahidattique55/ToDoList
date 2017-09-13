//
//  Task.swift
//  ToDoList
//
//  Created by Fahid Attique on 13/09/2017.
//  Copyright © 2017 Fahid Attique. All rights reserved.
//

import UIKit



//  TaskType

enum TaskType: String {
    case pending = "pending", completed = "completed"
}



//  Task

class Task: NSObject {

    
    //  MARK:- Class Properties
    
    static var numberOfTasks: UInt = 0    //  Task with same name can be created due to it
    static let typeMarkedPending   = "typeMarkedPending"        //  Notification name
    static let typeMarkedCompleted = "typeMarkedCompleted"      //  Notification name
    
    
    
    
    //  MARK:- Object Properties

    var name: String = ""
    var id: UInt = 0
    var type: TaskType = .pending
    var isPending: Bool { get { return type == .pending } }
    
    
    
    
    
    //  MARK:- Life Cycle

    convenience init(_ name: String) {
        self.init()
        self.id = Task.numberOfTasks
        self.name = name
    }
    
    override init() {
        super.init()
        Task.numberOfTasks += 1
    }
    
    deinit {
        Task.numberOfTasks -= 1
    }

    override func isEqual(_ object: Any?) -> Bool {

        guard let task = object as? Task else { return false }
        return self.id == task.id
    }


    
    
    
    
    //  MARK:- Functions

    
    func markCompleted() {
        type = .completed
    }

    func markPending() {
        type = .pending
    }
}
