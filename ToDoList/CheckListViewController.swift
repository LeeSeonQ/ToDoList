//
//  ChekList.swift
//  ToDoList
//
//  Created by Lee on 2023/08/01.
//
import UIKit

class CheckListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        tableView.deselectRow(at: indexPath, animated: true)
    //    
    //    }
    @IBOutlet weak var checkListTableView: UITableView!
    
    var items: [String] = []
    var isCompleted: [Bool] = []
    
    //    func strikeThrough() -> NSAttributedString {
    //        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: self)
    //        attributeString.addAttribute(NSAttributedString.Key, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
    //
    //    }
    
    
    
    
    
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
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
        //        let isSwitchOn = isCompleted[indexPath.row]
        let isSwitchOn: Bool
        if indexPath.row < isCompleted.count {
            isSwitchOn = isCompleted[indexPath.row]
        } else {
            isSwitchOn = false
        }
        let attributedText = NSMutableAttributedString(string: item)
        if isSwitchOn {
            attributedText.addAttribute(.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedText.length))
            attributedText.addAttribute(.strikethroughColor, value: UIColor.black, range: NSRange(location: 0, length: attributedText.length))
            
        }
        cell.textLabel?.attributedText = attributedText
        
        cell.completeSwitch.isOn = isSwitchOn
        cell.completeSwitch.tag = indexPath.row
        
        return cell
    }
    
    
    @IBAction func completeSwitchTapped(_ sender: UISwitch) {
        if let cell = sender.superview?.superview as? TableViewCell,
           let indexPath = self.checkListTableView.indexPath(for: cell) {
            let rowIndex = indexPath.row
            isCompleted[rowIndex] = sender.isOn
            checkListTableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    
    
    
    
}
    

