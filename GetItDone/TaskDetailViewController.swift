//
//  DetailViewController.swift
//  iContact
//
//  Created by Himaja Motheram on 4/8/17.
//  Copyright © 2017 Sriram Motheram. All rights reserved.
//

import UIKit

class DetailViewController:  UIViewController {
    
    
    @IBOutlet var saveButton                :UIBarButtonItem!
    @IBOutlet var taskNameTextField         :UITextField!
    @IBOutlet var taskCompletedSwitch       :UISwitch!
    @IBOutlet var priorityZoneSegControl    :UISegmentedControl!
   
    
    var currentTask  :Task!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       guard let task = currentTask else {
            self.navigationController!.popViewController(animated: true)
            return
        }
           }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
