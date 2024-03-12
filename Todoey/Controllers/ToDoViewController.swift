import UIKit
import RealmSwift

class ToDoViewController: UITableViewController{
    
    var todoItems: Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
//        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

    }
    
    //MARK: -  Table view datasource methods
    //Create number of rows in table section using numberOfRowsInSection init
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    //populate the cells in rows using cellForRowAt init
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellForRowAt called")
        //create cell using dequeueReusablecell method using identiefer of prototype cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableTableCell", for: indexPath)
        //index path is the current index the table is on, indexPath.row is the row of the table
        if let item = todoItems?[indexPath.row]{
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
            
        }else{
            cell.textLabel?.text = "No items added."
        }
        
        return cell
    }
    
    //MARK: - TableView Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = todoItems?[indexPath.row]{
            do{
                try realm.write{
                    item.done = !item.done
                    
                }
            }catch{
                print("Error updating todoItem status \(error)")
            }
        }
        tableView.reloadData()

        tableView.deselectRow(at: indexPath, animated: true)
    }


    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen after user clicks on alert
            //Create a NSManagedObject (Row) of the entity(Class) table
            
            if let currentCategory = self.selectedCategory {
                do{
                    try self.realm.write{
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                    
                }catch{
                    print("Error saving new items")
                    
                }
                
            }
            self.tableView.reloadData()
            
            
            print("successfully added \(textField.text!)")
            
            
        }
        alert.addTextField { (alertField) in
            alertField.placeholder = "Create New Item"
            textField = alertField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
//    Fetch all the TodoItem entities(NSManagedObject Array) from the persistentContainer
    func loadItems(){
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
}

//MARK: - Search Bar Extension

extension ToDoViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()


    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}


