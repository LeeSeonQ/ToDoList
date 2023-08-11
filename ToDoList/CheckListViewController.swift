//
//  ChekList.swift
//  ToDoList
//
//  Created by Lee on 2023/08/01.
//
import UIKit



class CheckListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,DetailViewControllerDelegate {
    
    @IBOutlet weak var checking: UIBarButtonItem!
    
    @IBOutlet weak var checkListTableView: UITableView!
    
    
    var items: [String] = []
    var completedItems: [String] = []
    
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    @IBAction func checkingButton(_ sender: UIButton) {
        let completeListVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CompleteListViewController") as! CompleteListViewController
        
        completeListVC.completedItems = UserDefaults.standard.stringArray(forKey: "completedItems") ?? []
        
        self.navigationController?.pushViewController(completeListVC, animated: true)
        
      
        printCompletedItems()
    }
    

    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "새 항목 추가", message: "원하는 List 추가", preferredStyle: .alert)
        
        alertController.addTextField {
            textField in
            textField.placeholder = "텍스트를 입력하시오."
        }
        
        let cancleAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertController.addAction(cancleAction)
        
        let saveAction = UIAlertAction(title: "저장", style: .default) { _ in
            if let textFields = alertController.textFields, let inputText = textFields[0].text, !inputText.isEmpty {
                self.items.append(inputText)
                
                self.checkListTableView.reloadData()
                
                print("저장된 값: \(self.items)")
            }
        }
        alertController.addAction(saveAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let item = items[indexPath.row]
        cell.textLabel?.text = item
        
        return cell
    }
    
    
    @IBAction func completeSwitchTapped(_ sender: UISwitch) {
        if let cell = sender.superview?.superview as? UITableViewCell,
           let indexPath = checkListTableView.indexPath(for: cell) {
            let rowIndex = indexPath.row
            let item = items[rowIndex]
            
            switch sender.isOn {
            case true:
                let attributedString = NSAttributedString(string: item, attributes: [
                    .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                    .strikethroughColor: UIColor.red
                ])
                cell.textLabel?.attributedText = attributedString
                print("\(item) 항목의 스위치가 켜졌습니다")
            default:
                cell.textLabel?.text = item
                print("\(item) 항목의 스위치가 꺼졌습니다")
                
                
                items[rowIndex] = item
                checkListTableView.reloadRows(at: [IndexPath(row: rowIndex, section: 0)], with: .none)
            }
        }
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DS",
           let detailVC = segue.destination as? DetailViewController,
           let indexPath = checkListTableView.indexPathForSelectedRow {
            let selectedItem = items[indexPath.row]
            detailVC.itemText = selectedItem
            detailVC.delegate = self
        }
    }
    
    func didDeleteItem(_ item: String) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
            checkListTableView.reloadData()
        }
    }
    
    func didThrowCompleteItem(_ item: String) {
        if let index = items.firstIndex(of: item) {
            let completedItem = items.remove(at: index)
            completedItems.append(completedItem)
            UserDefaults.standard.set(completedItems, forKey: "completedItems")
            checkListTableView.reloadData()
            
        }
    }

    
  
    func printCompletedItems() {
        let completedItems = UserDefaults.standard.stringArray(forKey: "completedItems") ?? []
        for item in completedItems {
            print(item)
        }
    }
}
