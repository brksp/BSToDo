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
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var textView: UITextView!
    
    var realm: Realm!
    var toDoItem: ToDoListItem!
    
    override func viewDidLoad() {
        realm = try! Realm()
        datePicker.isHidden = true
        datePicker.minimumDate = Date()
        dateLabel.text = String(describing: Date())
        handleExistingNote()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleExistingNote() {
        if toDoItem != nil {
            datePicker.date = toDoItem.date!
            textView.text = toDoItem.note!
            segmentControl.selectedSegmentIndex = toDoItem.priority!
        }
    }
    
    func add() {
        try! realm.write {
            realm.create(ToDoListItem.self, value: ["note": "1231qweqewq", "priority": "", "date" : "", "id": UUID().uuidString], update: true)
        }
    }
    
    func update() {
        
    }
    
    @IBAction func addButtonAction(_ sender: Any) {
        if toDoItem != nil {
            update()
        }else {
            add()
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
