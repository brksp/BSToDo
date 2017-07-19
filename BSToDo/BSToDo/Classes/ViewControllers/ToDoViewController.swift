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
    @IBOutlet weak var doneButton: UIButton!
    
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
            datePicker.date = toDoItem.value(forKey: "date") as! Date
            textView.text = toDoItem.value(forKey: "note") as! String
            segmentControl.selectedSegmentIndex = (toDoItem.value(forKey: "priority") as! NSNumber).intValue
            dateLabel.text = String(describing: toDoItem.value(forKey: "date")!)
            setDoneButton(title: "Update")
        }else {
            setDoneButton(title: "Add")
            textView.becomeFirstResponder()
        }
    }
    
    func setDoneButton(title: String) {
        doneButton.setTitle(title, for: .normal)
        doneButton.setTitle(title, for: .highlighted)
    }
    
    func add() {
        try! realm.write {
            let note = textView.text ?? ""
            let date = datePicker.date
            let id = UUID().uuidString
            let priority = NSNumber(value: segmentControl.selectedSegmentIndex)
            
            realm.create(ToDoListItem.self, value: ["note": note, "priority": priority, "date" : date, "id": id], update: true)
            let _ = navigationController?.popViewController(animated: true)
        }
    }
    
    func update() {
        try! realm.write {
            let note = textView.text ?? ""
            let date = datePicker.date
            let id = toDoItem.value(forKey: "id") as! String
            let priority = NSNumber(value: segmentControl.selectedSegmentIndex)
            
            realm.create(ToDoListItem.self, value: ["note": note, "priority": priority, "date" : date, "id": id], update: true)
            let _ = navigationController?.popViewController(animated: true)
        }
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
