//
//  CategoryViewController.swift
//  Todoey
//
//  Created by JJ on 28/02/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryItemsArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()

        
    }
    
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            let newItem = Category(context: self.context)
            newItem.name = textField.text!
            self.categoryItemsArray.append(newItem)
            self.saveData()
            print("successfully added \(textField.text!)")
        }
        alert.addTextField { (alertField) in
            alertField.placeholder = "Create New Category"
            textField = alertField
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - TableView Data source methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryItemsArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let item = categoryItemsArray[indexPath.row]
        cell.textLabel?.text = item.name
        return cell
    }
    
    //MARK: - TableView Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        
        
    }
    
    
    //MARK: - Data Manipulation methods
    
    func saveData() {
        do{
            try context.save()
            print("Succesfully saved category data")
   
        }catch {
            print("Error saving context: \(error)")
        }
        tableView.reloadData()
        
    }
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()){
        do{
            categoryItemsArray = try context.fetch(request)
    
        }catch{
            print("Error loading items : \(error)")
        }
        tableView.reloadData()
    }
}
