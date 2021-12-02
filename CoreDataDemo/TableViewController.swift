//
//  TableViewController.swift
//  CoreDataDemo
//
//  Created by Егор Астахов on 02.12.2021.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    var toDoItems: [Task] = []
    
    @IBAction func addTask(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add Task", message: "add new task", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default) { action in
            let textField = alertController.textFields?[0]
            self.saveTask(taskToDo: (textField?.text)!)
//            self.toDoItems.insert((textField?.text)!, at: 0)
            self.tableView.reloadData()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addTextField { textField in
            
        }
        
        alertController.addAction(ok)
        alertController.addAction(cancel)
        present(alertController, animated: true, completion: nil)
        
    }
    
    func saveTask(taskToDo: String) {
        // добрались до файла AppDelegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // получили контекст
        let context = appDelegate.persistentContainer.viewContext
        // создаем сущность
        let entity = NSEntityDescription.entity(forEntityName: "Task", in: context)
        // создаем сам объект который хотим сохранить
        let taskObject = NSManagedObject(entity: entity!, insertInto: context) as! Task
        taskObject.taskToDo = taskToDo
        
        // Сохраняем данный объект в нашем контексте
        do {
            try context.save()
            toDoItems.append(taskObject)
            print("Saved! Good Job!")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // добрались до файла AppDelegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // получили контекст
        let context = appDelegate.persistentContainer.viewContext
        
        // создаем  fetch request
        // делаем запрос по Task сущности
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        do {
            // контекст с помощью запроса обращается к нашей базе данный и просит вернуть все сущности Task
            toDoItems = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let task = toDoItems[indexPath.row]
        cell.textLabel?.text = task.taskToDo

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
