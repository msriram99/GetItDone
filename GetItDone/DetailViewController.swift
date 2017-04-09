//
//  DetailViewController.swift
//  GetItDone
//
//  Created by Himaja Motheram on 4/8/17.
//  Copyright © 2017 Sriram Motheram. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    @IBOutlet internal var saveButton: UIBarButtonItem!
    
    @IBOutlet internal var taskNameTextField: UITextField!
    
    @IBOutlet internal var taskCompletedSwitch: UISwitch!
    
    @IBOutlet internal var priorityZoneSegControl: UISegmentedControl!
   
    @IBOutlet internal var labelDateCreated: UILabel!

    
   
    
    var currentTask: Task?
    var managedContext  :NSManagedObjectContext!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        managedContext = appDelegate.persistentContainer.viewContext
        
        if currentTask == nil {
           showdefault()
        }
        else{
            let task = currentTask
            display(task: task!)
        }
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func savePressed(button: UIBarButtonItem) {
        if let task = currentTask {
            editTask (task: task)
           // print("done")
        } else {
            createTask()
        }
       // self.navigationController!.popViewController(animated: true)
    }
    
    
    func display(task: Task) {
        taskNameTextField.text = task.taskName
        
        let date = task.dateCreated
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        let result = formatter.string(from: date as! Date)
        //labelDateCreated.text  = "\(task.dateCreated)"
        labelDateCreated.text  = result //"\(result)"

        taskCompletedSwitch.isOn = task.taskCompleted
        if(task.priorityZone == "A1")
        { priorityZoneSegControl.selectedSegmentIndex = 0 }
        else if(task.priorityZone == "A2")
        {
            priorityZoneSegControl.selectedSegmentIndex = 1
        }
        else if(task.priorityZone == "B1")
        {
            priorityZoneSegControl.selectedSegmentIndex = 2
        }
        else if(task.priorityZone == "B2")
        {
            priorityZoneSegControl.selectedSegmentIndex = 3
        }
       
      
    }
    
    func setTaskValues(task: Task) {
        task.taskName = taskNameTextField.text
       
        task.taskCompleted = taskCompletedSwitch.isOn
        
        if(priorityZoneSegControl.selectedSegmentIndex == 0)
            
        {
         task.priorityZone = "A1"}
            
        else if(priorityZoneSegControl.selectedSegmentIndex == 1)
        {
            
            task.priorityZone = "A2"
        }
        else if(priorityZoneSegControl.selectedSegmentIndex == 2)
        {
            
            task.priorityZone = "B1"
        }
        else if(priorityZoneSegControl.selectedSegmentIndex == 3)
        {
            
            task.priorityZone = "B2"
        }

      }
    
    func showdefault(){
        
        taskNameTextField.text = "Enter Task Name here"
        labelDateCreated.text  = "\(NSDate())"
        taskCompletedSwitch.isOn = false
        priorityZoneSegControl.selectedSegmentIndex = 0
    
    }

    
    func createTask() {
        let newTask = NSEntityDescription.insertNewObject(forEntityName: "Task", into: managedContext) as! Task
        newTask.dateCreated = NSDate()

        setTaskValues(task: newTask)
        appDelegate.saveContext()
    }
    
    func editTask(task: Task) {
        setTaskValues(task: task)
        appDelegate.saveContext()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
