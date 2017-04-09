//
//  ViewController.swift
//  GetItDone
//
//  Created by Himaja Motheram on 4/8/17.
//  Copyright © 2017 Sriram Motheram. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet var TaskView: UITableView!
    
     var TaskList = [Task](  )
    var managedContext :NSManagedObjectContext!

    
    //var TaskList: [Task] = [ Task("ABell", "04-08-2017", "A1", "True")]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        managedContext = appDelegate.persistentContainer.viewContext

       /* For testing
        let taskItem = NSEntityDescription.insertNewObject(forEntityName: "Task", into: managedContext) as! Task
        taskItem.taskName = "TaskName - 3"
        taskItem.priorityZone = "A1"
        taskItem.dateCreated = NSDate()
        taskItem.taskCompleted = false
       */

        do{
        try managedContext.save()
             }catch let error as NSError {
         print("Could not save. \(error), \(error.userInfo)")
          }

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "segue"{
        let destinationVC = segue.destination as! DetailViewController
        let indexPath = TaskView.indexPathForSelectedRow!
        let currentTask = TaskList[indexPath.row]
        
        destinationVC.currentTask = currentTask
        TaskView.deselectRow(at: indexPath, animated: true)
        
    }
    else if segue.identifier == "seguenew" {
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.currentTask = nil
            
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TaskList = appDelegate.fetchAllTasks()
        TaskView.reloadData()
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskList.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        
        let CurrentTask = TaskList[indexPath.row]
        let TaskComplete : String!
        if CurrentTask.taskCompleted {
            TaskComplete = "Done"
        } else {
            TaskComplete = "Not Done"
        }
       
        let date = CurrentTask.dateCreated
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        let result = formatter.string(from: date as! Date)
        cell.textLabel?.text = "\(CurrentTask.taskName!)  \(result)"

        //cell.textLabel?.text = "\(CurrentTask.taskName!)  \(CurrentTask.dateCreated)"
        cell.detailTextLabel?.text = CurrentTask.priorityZone! + " " + TaskComplete
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let taskToDelete = TaskList[indexPath.row]
            managedContext.delete(taskToDelete)
            appDelegate.saveContext()
            TaskList = appDelegate.fetchAllTasks()
            TaskView.deleteRows(at: [indexPath], with: .automatic)
            tableView.isEditing = false
        }
        }


}

