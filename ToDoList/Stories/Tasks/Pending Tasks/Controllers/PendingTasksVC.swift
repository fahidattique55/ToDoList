//
//  PendingTasksVC.swift
//  ToDoList
//
//  Created by Fahid Attique on 13/09/2017.
//  Copyright © 2017 Fahid Attique. All rights reserved.
//

import UIKit


class PendingTasksVC: UIViewController {
    
    
    //  MARK:- IBOutlets
    
    @IBOutlet var pendingTasksTableView: UITableView!

    
    
    
    
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
        
        pendingTasksTableView.register(UINib(nibClassName: TaskCell.self), forCellReuseIdentifier: TaskCell.identifier)
        pendingTasksTableView.estimatedRowHeight = 44
        pendingTasksTableView.rowHeight = UITableViewAutomaticDimension
        pendingTasksTableView.emptyDataSetSource = self
        pendingTasksTableView.emptyDataSetDelegate = self
    }
    
    fileprivate func addTasksObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateViewWith), name: NSNotification.Name(rawValue: Task.typeMarkedPending), object: nil)
    }
    
    func updateViewWith(_ notification: NSNotification) {

        pendingTasksTableView.reloadData()
    }
    
    fileprivate func createTaskWithName( _ name: String) {
        
        taskUtility.addTask(Task(name))
        pendingTasksTableView.reloadData()
        updateTasksBadge()
    }
    
    fileprivate func updateTasksBadge()  {
        
        let tabBarVC = tabBarController as! TasksTabBarVC
        tabBarVC.updateTasksBadge()
    }

    
    

    
    
    
    //  MARK:- IBActions
    
    @IBAction func createNewTask(_ sender: Any) {
        
        let alert = UIAlertController(title: "", message: "Task Information", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: {(_ textField: UITextField) -> Void in
            textField.placeholder = "Enter Task Name"
            textField.autocapitalizationType = .sentences
        })
        
        let createAction = UIAlertAction(title: buttonCreate, style: .default, handler: {(_ action: UIAlertAction) -> Void in
            
            let textfields = alert.textFields
            let taskfield: UITextField = textfields![0]
            
            if taskfield.text!.isEmpty {
                Utility.showAlert("", message: "Please enter task name", onController: self)
            }
            else { self.createTaskWithName(taskfield.text!) }
        })

        let cancelAction = UIAlertAction(title: buttonCancel, style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
        })
        
        alert.addAction(createAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}












extension PendingTasksVC: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskUtility.pendingTasks.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: TaskCell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier) as! TaskCell
        let pendingTask = taskUtility.pendingTasks[indexPath.row]
        cell.configure(task: pendingTask)
        return cell
    }
    
}






extension PendingTasksVC: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let task = taskUtility.pendingTasks[indexPath.row]
        task.markCompleted()

        tableView.deleteRows(at: [indexPath], with: .none)
        tableView.reloadEmptyDataSet()

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Task.typeMarkedCompleted), object: nil)
        
        Utility.showAlert("", message: messageTaskCompleted, onController: self)
        
        updateTasksBadge()
    }

    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let task = taskUtility.pendingTasks[indexPath.row]
            _ = taskUtility.removeTask(task)
            tableView.deleteRows(at: [indexPath], with: .none)
            updateTasksBadge()
        }
    }
    
    
}











extension PendingTasksVC : DZNEmptyDataSetSource {
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineBreakMode = .byWordWrapping
        paragraph.alignment = .center
        
        let attributes = [NSFontAttributeName : UIFont.systemFont(ofSize: 16),
                          NSForegroundColorAttributeName : UIColor.black,
                          NSParagraphStyleAttributeName : paragraph]
        
        return NSAttributedString(string: messageEmptyPendingVC, attributes: attributes)
        
    }
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return UIColor.clear
    }
}






extension PendingTasksVC : DZNEmptyDataSetDelegate {
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
}
