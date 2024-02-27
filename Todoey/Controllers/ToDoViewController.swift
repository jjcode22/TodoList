

import UIKit

class ToDoViewController: UITableViewController {
    
    var itemsArray = [TodoItem]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let newItem = TodoItem()
        newItem.title = "Find Mike"
        itemsArray.append(newItem)
        
        let newItem2 = TodoItem()
        newItem2.title = "Buy Eggos"
        itemsArray.append(newItem2)
        
        
        let newItem3 = TodoItem()
        newItem3.title = "Kill the Demigorgon"
        itemsArray.append(newItem3)
        
        loadItems()

        
        
//        if let items = defaults.array(forKey: "ToDoListArray") as? [TodoItem]{
//            itemsArray = items
//        }
        // Do any additional setup after loading the view.
    }
    
    //MARK -  Table view datasource methods
    //Create number of rows in table section using numberOfRowsInSection init
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    //populate the cells in rows using cellForRowAt init
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellForRowAt called")
        //create cell using dequeueReusablecell method using identiefer of prototype cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableTableCell", for: indexPath)
        //index path is the current index the table is on, indexPath.row is the row of the table
        let item = itemsArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.isDone ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = itemsArray[indexPath.row]
        
        item.isDone = !item.isDone
        self.saveData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }


    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen after user clicks on alert
            let newItem = TodoItem()
            newItem.title = textField.text!
            self.itemsArray.append(newItem)
            self.saveData()
            
            print("successfully added \(textField.text!)")
            
            
        }
        alert.addTextField { (alertField) in
            alertField.placeholder = "Create New Item"
            textField = alertField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveData(){
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(itemsArray)
            try data.write(to: dataFilePath!)
        }catch {
            print("Error adding item \(error)")
        }
        tableView.reloadData()
    }
    
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                itemsArray = try decoder.decode([TodoItem].self, from: data)
            }catch {
                print("error decoding item array \(error)")
            }
        }
        
    }
}


