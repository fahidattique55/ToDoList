//
//  UINib+Additions.swift
//  ToDoList
//
//  Created by Fahid Attique on 13/09/2017.
//  Copyright © 2017 Fahid Attique. All rights reserved.
//

import UIKit

extension UINib {
    
    convenience init(nibClassName:UIView.Type) {
        let bundle = Bundle(for: nibClassName)
        self.init(nibName: className(nibClassName), bundle: bundle)
    }
}
