//
//  listOfToDosTableViewController.swift
//  toDo Swift Version
//
//  Created by Zoe Tse on 13/7/19.
//  Copyright © 2019 Zoe Tse. All rights reserved.
//

import UIKit

class listOfToDosTableViewController: UITableViewController {
    var receivedName = ""
    var todos: [contentsToDos] = []
    
    @IBOutlet weak var navigator: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "\(receivedName)'s To-Do List"
       
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        if let loadedToDos = contentsToDos.loadFromFile() {
            todos = loadedToDos
        }
            
        else {
            todos = contentsToDos.loadSampleData()
            contentsToDos.saveToFile(todos: todos)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todos.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath)
        
        if let cell = cell as? toDoTableViewCell{
            let currentToDo = todos[indexPath.row]
            cell.toDoItem.text = currentToDo.item
            
            let date = currentToDo.date // convert date to string
            let format = DateFormatter()
            format.dateFormat = "yyyy-MM-dd"
            let formattedDate = format.string(from: date)
            
            cell.toDoDate.text = formattedDate
            cell.toDoImage.image = currentToDo.image
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // Delete the row from the data source
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            contentsToDos.saveToFile(todos: todos)
        }
        
        else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let thing = todos.remove(at: fromIndexPath.row)
        todos.insert(thing, at: to.row)
        contentsToDos.saveToFile(todos: todos)
        tableView.reloadData()
    }

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails", let nvc = segue.destination as? detailsViewController, let indexPath = tableView.indexPathForSelectedRow {
            nvc.todo = todos[indexPath.row]
        }
    }
    
    @IBAction func unwindToDos(with segue: UIStoryboardSegue) {
        if segue.identifier == "unwindSave" {
            let source = segue.source as! EditTableViewController
            if source.needNewToDo {
                todos.append(source.todo)
                contentsToDos.saveToFile(todos: todos)
            }
            tableView.reloadData()
        }
    }
}
