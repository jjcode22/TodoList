import UIKit
import CoreData

class ToDoViewController: UITableViewController {
    
    var itemsArray = [TodoItem]()
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(dataFilePath)
        
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
//        managedObjectContext.delete(item)
//        itemsArray.remove(at: indexPath.row)
        item.isDone = !item.isDone
        self.saveData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }


    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen after user clicks on alert
            //Create a NSManagedObject (Row) of the entity(Class) table
            let newItem = TodoItem(context: self.managedObjectContext)
            newItem.title = textField.text!
            newItem.isDone = false
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
        do{
            try managedObjectContext.save()
            print("Succesfully saved data")
   
        }catch {
            print("Error saving context: \(error)")
        }
        tableView.reloadData()
    }
    
    func loadItems(){
        //Fetch all the TodoItem entities(NSManagedObject Array) from the persistentContainer 
        let request : NSFetchRequest<TodoItem> = TodoItem.fetchRequest()
        do {
            itemsArray = try managedObjectContext.fetch(request)
        }catch{
            print("Error fetching from context - CoreData: \(error)")
        }
    }
}


