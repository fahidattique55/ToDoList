//
//  TaskCell.swift
//  ToDoList
//
//  Created by Fahid Attique on 13/09/2017.
//  Copyright © 2017 Fahid Attique. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {

    
    //  MARK:- Properties
    
    static let identifier = "TaskCell"
    
    
    
    
    //  MARK:- IBOutlets
    
    @IBOutlet var taskName: UILabel!
    
    
    

    //  MARK:- Life Cycle
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    
    //  MARK:- Functions

    func configure(task: Task) {
        taskName.text = task.name
    }
}
