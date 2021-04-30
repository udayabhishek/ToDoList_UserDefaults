//
//  ToDoListTableViewController.swift
//  ToDoList
//
//  Created by Uday Kumar Abhishek . (Service Transformation) on 30/04/21.
//

import UIKit

class ToDoListTableViewController: UITableViewController {
    let tableCell = "ToDoItemCell"
    var itemsArray = [Item]()
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let newItem = Item()
        newItem.name = "buy eggs"
        itemsArray.append(newItem)
        
        let newItem1 = Item()
        newItem1.name = "make juice"
        itemsArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.name = "clean room"
        itemsArray.append(newItem2)
        
//        if let item = userDefault.array(forKey: "ToDoListArray") as? [Item] {
//            itemsArray = item
//        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { [self] (action) in
            let item = Item()
            item.name = textField.text ?? "NA"
            self.itemsArray.append(item)
            
//            self.userDefault.set(self.itemsArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add new item"
            textField = alertTextField
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - Table view data source

extension ToDoListTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCell, for: indexPath)
        cell.textLabel?.text = itemsArray[indexPath.row].name
        
        if itemsArray[indexPath.row].isChecked == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        //above 4 lines of code can be written in 1 line
        cell.accessoryType = (itemsArray[indexPath.row].isChecked == true) ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //toggle check mark and it keeps the record for checked data
        
//        if itemsArray[indexPath.row].isChecked == false {
//            itemsArray[indexPath.row].isChecked = true
//        } else {
//            itemsArray[indexPath.row].isChecked = false
//        }
        //below line can also be use for toggling, instead of writing above 4 line of code this one line will be sufficient
        itemsArray[indexPath.row].isChecked = !(itemsArray[indexPath.row].isChecked)
        print(itemsArray[indexPath.row].isChecked)
        //        _ = tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark ? .none : .checkmark
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        //by default row will be select and greyed, to make it back to white color after click
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
