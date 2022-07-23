//
//  CoreDataViewController.swift
//  NoteApp
//
//  Created by Rustem Manafov on 24.07.22.
//

import UIKit

// database coredata method

class CoreDataViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let context = AppDelegate().persistentContainer.viewContext
    var listItems = [List]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetch()
    }
    
    func fetch() {
        do{
            listItems = try context.fetch(List.fetchRequest())
            listItems.reverse()
            tableView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func save(title: String) {
        let model = List(context: context)
        model.title = title
        do {
            try context.save()
            fetch()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    func delete(index: Int) {
        context.delete(listItems[index])
        do {
            try context.save()
            //fetch()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func buttonAct(_ sender: Any) {
        showAlert()
    }

}

extension CoreDataViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = listItems[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            delete(index: indexPath.row)
            listItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let actionSheet = UIAlertController(title: "Edit Note", message: "", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
            let alert = UIAlertController(title: "Edit Note", message: "", preferredStyle: .alert)
            alert.addTextField { textField in
                textField.placeholder = "Enter here..."
            }
            alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { _ in
                let text = alert.textFields?[0].text ?? ""
                self.delete(index: indexPath.row)
               // self.listItems.reverse()
               // tableView.reloadData()
                self.save(title: text)
            }))
            self.present(alert, animated: true, completion: nil)
        }))
        present(actionSheet, animated: true, completion: nil)

    }
}

extension CoreDataViewController {
    
    func showAlert() {
        let alert = UIAlertController(title: "Add Note", message: "", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Enter here..."
        }
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { _ in
            let text = alert.textFields?[0].text ?? ""
            self.save(title: text)
        }))
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
}
