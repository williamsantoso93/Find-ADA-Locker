//
//  TableDataViewController.swift
//  Find ADA Locker
//
//  Created by William Santoso on 22/09/19.
//  Copyright © 2019 William Santoso. All rights reserved.
//

import UIKit
import CoreData

class TableDataViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var names: [String] = []
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    var dataLocker:
//    var lockerStatuses: [LockerStatus]
//    var lockerStatuses: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "The List"
        

    }

    @IBAction func addButton(_ sender: Any) {
        let alert = UIAlertController(title: "New Name", message: "Add a new name", preferredStyle: .alert)
         
        let saveAction = UIAlertAction(title: "Save", style: .default) {
            [unowned self] action in
                                         
            guard let textField = alert.textFields?.first,
             let nameToSave = textField.text else {
               return
            }
            self.names.append(nameToSave)
            self.tableView.reloadData()
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        alert.addTextField()

        alert.addAction(saveAction)
        alert.addAction(cancelAction)

        present(alert, animated: true)
    }
}

extension TableDataViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = names[indexPath.row]
        return cell

    }
    
    
}
