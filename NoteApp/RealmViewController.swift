//
//  RealmViewController.swift
//  NoteApp
//
//  Created by Rustem Manafov on 24.07.22.
//

import UIKit

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
