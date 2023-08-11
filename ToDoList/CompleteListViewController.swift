//
//  CompleteList.swift
//  ToDoList
//
//  Created by Lee on 2023/08/01.
//

import UIKit

protocol CompleteListViewDelegate: AnyObject {
    func didThrowCompleteItem(_ item: String)
}

class CompleteListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var completeTableView: UITableView!
    
    var completedItems: [String] = []
    

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return completedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "completeCell", for: indexPath)
        let item = completedItems[indexPath.row]
        cell.textLabel?.text = item
         return cell
   
    }
    
    func didThrowCompleteItem(_ item: String) {
        completeTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        completedItems = UserDefaults.standard.stringArray(forKey: "completedItems") ?? []
        completeTableView.reloadData()
        
        
    }
}
