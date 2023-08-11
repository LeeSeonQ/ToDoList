//
//  DetailViewController.swift
//  ToDoList
//
//  Created by Lee on 2023/08/08.
//

import UIKit

protocol DetailViewControllerDelegate: AnyObject {
    func didDeleteItem(_ item: String)
    func didThrowCompleteItem(_ item: String)
}

class DetailViewController: UIViewController {
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var throwCompleteButton: UIButton!
    
    var itemText: String = ""
    
    weak var delegate: DetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        delegate?.didDeleteItem(itemText)
        navigationController?.popViewController(animated: true)
        
        
    }
    
    @IBAction func throwButtonTapped(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.didThrowCompleteItem(itemText)
            navigationController?.popViewController(animated: true)
        } else {
            print("Delegate is nil")
        }
    }
}
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    

