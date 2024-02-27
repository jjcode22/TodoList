

import UIKit

class ToDoViewController: UITableViewController {
    
    var itemsArray = ["Find mike","Buy eggos","kill the demigorgon"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK -  Table view datasource methods
    //Create number of rows in table section using numberOfRowsInSection init
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    //populate the cells in rows using cellForRowAt init
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //create cell using dequeueReusablecell method using identiefer of prototype cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableTableCell", for: indexPath)
        //index path is the current index the table is on, indexPath.row is the row of the table
        cell.textLabel?.text = itemsArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark ? .none : .checkmark
        tableView.deselectRow(at: indexPath, animated: true)
    }


    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen after user clicks on alert
            self.itemsArray.append(textField.text!)
            print("successfully added \(textField.text!)")
            self.tableView.reloadData()
            
        }
        alert.addTextField { (alertField) in
            alertField.placeholder = "Create New Item"
            textField = alertField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}

