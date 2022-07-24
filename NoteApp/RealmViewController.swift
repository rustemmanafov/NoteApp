//
//  RealmViewController.swift
//  NoteApp
//
//  Created by Rustem Manafov on 24.07.22.
//

import UIKit
import RealmSwift

// database realm method

class RealmViewController: UIViewController {
  

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func buttonAct(_ sender: Any) {
        
    }
    
}

extension RealmViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        return cell
        
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
            //self.save(title: text)
        }))
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
}
