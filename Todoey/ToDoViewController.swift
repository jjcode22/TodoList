

import UIKit

class ToDoViewController: UITableViewController {
    
    let itemsArray = ["Find mike","Buy eggos","kill the demigorgon"]

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


}

