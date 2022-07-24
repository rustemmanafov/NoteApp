//
//  RealmViewController.swift
//  NoteApp
//
//  Created by Rustem Manafov on 24.07.22.
//

import UIKit
import RealmSwift

// database realm method

class ListItem: Object {
    @Persisted var title: String = ""
    @Persisted var index: Int
}

class RealmViewController: UIViewController {
  
    @IBOutlet weak var tableView: UITableView!
    
    var realm = try! Realm()
    var items = [ListItem]()
    let defaultPath = Realm.Configuration.defaultConfiguration.path!
    try NSFileManager.defaultManager().removeItemAtPath(defaultPath)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetch()
        
        //see realm data base
        print("db: \(realm.configuration.fileURL!)")

    }
    
    func fetch() {
        let objects = realm.objects(ListItem.self)
        items.removeAll()
        for object in objects {
            items.append(object)
        }
        tableView.reloadData()
    }
    
    func save(title: String) {
        let item = ListItem()
        item.title = title
        
        try! realm.write({
            realm.add(item)
            fetch()
        })
        
        // second method
//        realm.beginWrite()
//        realm.add(item)
//       try! realm.commitWrite()
    }
    
    func DeleteUserInformation(index: Int){

            realm.beginWrite()

            let list = try! realm.objects(ListItem.self)
            realm.delete(list)

            try! realm.commitWrite()

        }

    @IBAction func buttonAct(_ sender: Any) {
        showAlert()
    }
    
}

extension RealmViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = items[indexPath.row].title
        return cell
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

extension RealmViewController {
    
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
