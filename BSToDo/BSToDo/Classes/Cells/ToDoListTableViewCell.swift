//
//  ToDoListTableViewCell.swift
//  BSToDo
//
//  Created by Burak SIPCIKOGLU on 17/07/2017.
//  Copyright © 2017 burak. All rights reserved.
//

import UIKit

class ToDoListTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var spotLabel: UILabel!
    
    @IBOutlet weak var checkBoxButton: UIButton!
    
    @IBAction func checkBoxAction(_ sender: Any) {
        if checkBoxButton.isSelected {
            checkBoxButton.isSelected = false
            titleLabel.alpha = 1
            spotLabel.alpha = 1
        }else {
            checkBoxButton.isSelected = true
            titleLabel.alpha = 0.3
            spotLabel.alpha = 0.3
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
