//
//  ToDoViewController.swift
//  BSToDo
//
//  Created by Burak SIPCIKOGLU on 17/07/2017.
//  Copyright © 2017 burak. All rights reserved.
//

import UIKit
import RealmSwift
class ToDoViewController: UIViewController {
    //MARK: - Properties
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    
    var realm: Realm!
    override func viewDidLoad() {
        realm = try! Realm()
        datePicker.isHidden = true
        dateLabel.text = String(describing: Date())
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func add() {
        try! realm.write {
            realm.create(ToDoListItem.self, value: ["note": "1231qweqewq", "priority": "", "date" : "", "id": UUID().uuidString], update: true)
        }
    }
    
    @IBAction func datePickerAction(_ sender: Any) {
        dateLabel.text = String(describing: datePicker.date)
    }
    
    @IBAction func dateButtonAction(_ sender: Any) {
        if datePicker.isHidden {
            datePicker.isHidden = false
        }else {
            datePicker.isHidden = true
        }
    }
}
