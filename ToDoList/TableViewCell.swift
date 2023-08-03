//
//  TableViewCell.swift
//  ToDoList
//
//  Created by Lee on 2023/08/02.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var completeSwitch: UISwitch!
    

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
