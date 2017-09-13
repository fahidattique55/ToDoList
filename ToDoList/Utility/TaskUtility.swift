//
//  AppUtility.swift
//  ToDoList
//
//  Created by Fahid Attique on 13/09/2017.
//  Copyright © 2017 Fahid Attique. All rights reserved.
//

import UIKit


let appUtility = TaskUtility.sharedInstance

class TaskUtility: NSObject {


    // MARK: - Static

    static let sharedInstance = TaskUtility()
    
    

    // MARK: - Life Cycle
    
    override init() {
        super.init()
    }
    

    
    
    // MARK: - Properties


    var allTasks = [Task]()
    var pendingTasks: [Task] { get { return allTasks.filter({ $0.isPending }) } }
    var completedTasks: [Task] { get { return allTasks.filter({ !$0.isPending }) } }

    var pendingTasksCount: String { get { return String(describing: pendingTasks.count) } }
    var completedTasksCount: String { get { return String(describing: completedTasks.count) } }

    

    // MARK: - Functions

    func addTask(_ task: Task) {
        allTasks.append(task)
    }
    
    
    func removeTask(_ task: Task) -> Bool {
        return allTasks.removeObject(task)
    }


    
}
