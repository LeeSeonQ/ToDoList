//
//  ChekList.swift
//  ToDoList
//
//  Created by Lee on 2023/08/01.
//
import UIKit

class CheckListViewController: UIViewController {
 
    
    
    
    override func viewDidLoad() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped(_:)))
         navigationItem.rightBarButtonItem = addButton
      }
     @objc func addButtonTapped(_ sender: UIBarButtonItem) {
         
        print("추가 버튼을 누르셨습니다.")
    }
      }


        
    

