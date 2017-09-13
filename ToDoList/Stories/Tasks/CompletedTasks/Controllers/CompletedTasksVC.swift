//
//  CompletedTasksVC.swift
//  ToDoList
//
//  Created by Fahid Attique on 13/09/2017.
//  Copyright © 2017 Fahid Attique. All rights reserved.
//

import UIKit

class CompletedTasksVC: UIViewController {

    
    //  MARK:- IBOutlets
    
    
    @IBOutlet var completedTasksTableView: UITableView!
    
    
    
    //  MARK:- Life Cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        viewConfigurations()
        addTasksObserver()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    

    //  MARK:- Fuctions
    
    
    fileprivate func viewConfigurations() {
        
        completedTasksTableView.register(UINib(nibClassName: PendingTaskCell.self), forCellReuseIdentifier: PendingTaskCell.identifier)
        completedTasksTableView.emptyDataSetSource = self
        completedTasksTableView.emptyDataSetDelegate = self
    }
    
    fileprivate func addTasksObserver() {

        NotificationCenter.default.addObserver(self, selector: #selector(self.updateViewWith), name: NSNotification.Name(rawValue: Task.typeMarkedCompleted), object: nil)
    }
    
    func updateViewWith(_ notification: NSNotification) {
        completedTasksTableView.reloadData()
        tabBarController?.tabBar.items?[1].badgeValue = appUtility.completedTasksCount
    }
}










extension CompletedTasksVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appUtility.completedTasks.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PendingTaskCell = tableView.dequeueReusableCell(withIdentifier: PendingTaskCell.identifier) as! PendingTaskCell
        let pendingTask = appUtility.completedTasks[indexPath.row]
        cell.configure(task: pendingTask)
        return cell
    }
}





extension CompletedTasksVC: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let task = appUtility.completedTasks[indexPath.row]
        task.markPending()
        tableView.deleteRows(at: [indexPath], with: .none)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Task.typeMarkedPending), object: nil)
        Utility.showAlert("", message: messageTaskPending, onController: self)
    }

    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let task = appUtility.completedTasks[indexPath.row]
            _ = appUtility.removeTask(task)
            tableView.deleteRows(at: [indexPath], with: .none)
        }
    }
}








extension CompletedTasksVC : DZNEmptyDataSetSource {
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineBreakMode = .byWordWrapping
        paragraph.alignment = .center
        
        let attributes = [NSFontAttributeName : UIFont.systemFont(ofSize: 16),
                          NSForegroundColorAttributeName : UIColor.black,
                          NSParagraphStyleAttributeName : paragraph]
        
        return NSAttributedString(string: messageEmptyCompletedVC, attributes: attributes)
        
    }
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return UIColor.clear
    }
}




extension CompletedTasksVC : DZNEmptyDataSetDelegate {
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
}
