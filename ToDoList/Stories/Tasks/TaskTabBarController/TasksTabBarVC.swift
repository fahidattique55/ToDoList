//
//  TasksTabBarVC.swift
//  ToDoList
//
//  Created by Fahid Attique on 13/09/2017.
//  Copyright © 2017 Fahid Attique. All rights reserved.
//

import UIKit

class TasksTabBarVC: UITabBarController {


    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    
    
    // MARK: - Functions
    
    func updateTasksBadge() {

        tabBar.items?[0].badgeValue = taskUtility.pendingTasksCount
        tabBar.items?[1].badgeValue = taskUtility.completedTasksCount
    }
    
}
