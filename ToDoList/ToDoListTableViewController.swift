//
//  ToDoListTableViewController.swift
//  ToDoList
//
//  Created by Uday Kumar Abhishek on 30/04/21.
//

import UIKit

class ToDoListTableViewController: UITableViewController {
    let tableCell = "ToDoItemCell"
    var itemsArray = [Item]()
    let userDefault = UserDefaults.standard
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("TodoList.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //get all the items to display in the list
        getItems()
    }
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { [self] (action) in
            let item = Item()
            item.name = textField.text ?? "NA"
            self.itemsArray.append(item)
//            self.userDefault.set(self.itemsArray, forKey: "ToDoListArray")
            //save data into plist file path
            saveItems()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add new item"
            textField = alertTextField
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
//    MARK: - save and fetch methods
    func saveItems() {
        //using NSEncoder
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemsArray)
            try data.write(to: dataFilePath!)
        } catch  {
            print("error while saving data: \(error)")
        }
        tableView.reloadData()
    }
    
    func getItems() {
        //using NSDecoder
        do {
            let data = try Data(contentsOf: dataFilePath!)
            let decoder = PropertyListDecoder()
            itemsArray = try decoder.decode([Item].self, from: data)
        } catch  {
            print("Error in getting data: \(error)")
        }
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
//        if itemsArray[indexPath.row].isChecked == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
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
        itemsArray[indexPath.row].isChecked = !itemsArray[indexPath.row].isChecked
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
