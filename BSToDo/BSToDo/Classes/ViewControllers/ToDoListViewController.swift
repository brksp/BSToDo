//
//  ToDoListViewController.swift
//  BSToDo
//
//  Created by Burak SIPCIKOGLU on 17/07/2017.
//  Copyright © 2017 burak. All rights reserved.
//

import UIKit
import RealmSwift
class ToDoListViewController: UIViewController {
    enum SortType {
        case Priority, Date
    }
    
    //MARK: - Properties
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    lazy var searchBar = UISearchBar(frame: CGRect.zero)
    var realm: Realm!
    var listArray: NSMutableArray = []
    var results = try! Realm().objects(ToDoListItem.self).sorted(byKeyPath: "date")
    var searchedList = try! Realm().objects(ToDoListItem.self).sorted(byKeyPath: "id")
    var isSearching: Bool = false
    //MARK: - View Cyle
    override func viewDidLoad() {
        realm = try! Realm()
        setSearchBar()
        navigationItem.titleView = searchBar
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sortList()
        listTableView.reloadData()
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        removeSelectedStatesOfTableView()
        super.viewDidDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func removeSelectedStatesOfTableView() {
        if let indexPaths = listTableView.indexPathsForSelectedRows {
            for indexPath in indexPaths {
                listTableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
    
    @IBAction func addNewToDoButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "Note", sender: nil)
    }
    
    @IBAction func segmentControlDidChange(_ sender: UISegmentedControl) {
        sortList()
        listTableView.reloadData()
    }
    
    func sortList() {
        if segmentControl.selectedSegmentIndex == SortType.Date.hashValue {
            results = realm.objects(ToDoListItem.self).sorted(byKeyPath: "date", ascending: false)
        }else {
            results = realm.objects(ToDoListItem.self).sorted(byKeyPath: "priority", ascending: false)
        }
    }
    
    
    fileprivate func setSearchBar() {
        searchBar.backgroundColor = UIColor.clear
        searchBar.setBackgroundImage(UIImage(named: "onepx"), for: UIBarPosition(rawValue: 0)!, barMetrics: .default)
        searchBar.setSearchFieldBackgroundImage(UIImage(named: "SearchBg"), for: .normal)
        searchBar.setImage(UIImage(named: "onepx"), for: .search, state: .normal)
        searchBar.setImage(UIImage(named: "onepx"), for: .search, state: .selected)
        searchBar.setImage(UIImage(named: "TextFieldClearButton"), for: .clear, state: .normal)
        searchBar.setImage(UIImage(named: "TextFieldClearButton"), for: .clear, state: .highlighted)
        searchBar.barTintColor = UIColor.white
        searchBar.delegate = self
        for subView in searchBar.subviews {
            for subViewInSubView in subView.subviews {
                if subViewInSubView.isKind(of: UITextField.self) {
                    subViewInSubView.backgroundColor = UIColor.clear
                    (subViewInSubView as! UITextField).font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightLight)
                    let attributeDict = [NSForegroundColorAttributeName: UIColor(white: 255.0/255.0, alpha: 0.6)]
                    (subViewInSubView as! UITextField).attributedPlaceholder = NSAttributedString(string: "Search", attributes: attributeDict)
                    (subViewInSubView as! UITextField).tintColor = UIColor.white
                    (subViewInSubView as! UITextField).textColor = UIColor.white
                }
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Note" {
            let viewController = segue.destination as! ToDoViewController
            if let item = sender as? ToDoListItem {
                viewController.toDoItem = item
            }
        }
    }
}

//MARK: - UITableViewDataSource
extension ToDoListViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return searchedList.count
        }
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListTableViewCell", for: indexPath) as! ToDoListTableViewCell
        let item = isSearching ? searchedList[indexPath.row] : results[indexPath.row]
        cell.titleLabel.text = item.value(forKey: "note")! as? String
        cell.spotLabel.text = String(describing: item.value(forKey: "date")!)
        print("\(indexPath.row) ---  \(String(describing: item.value(forKey: "id")!))")
        
        return cell
    }
}

//MARK: - UITableViewDelegate
extension ToDoListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try! realm.write {
                realm.delete(objectForIndexPath(indexPath: indexPath)!)
                results = realm.objects(ToDoListItem.self).sorted(byKeyPath: "id")
                if (searchBar.text?.characters.count)! > 0 {
                    searchWith(text: searchBar.text!)
                }else {
                    listTableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = results[indexPath.row]
        performSegue(withIdentifier: "Note", sender: item)
    }
    
    func objectForIndexPath(indexPath: IndexPath) -> ToDoListItem? {
        return results[indexPath.row]
    }
}

//MARK: - UISearchBarDelegate
extension ToDoListViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearching = (searchBar.text?.characters.count)! > 0 ? true : false
        searchWith(text: searchBar.text!)
        listTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearching = false
        listTableView.reloadData()
    }
    
    func searchWith(text: String) {
        searchedList = realm.objects(ToDoListItem.self).filter(NSPredicate(format:
            "note contains[c] %@", text))
        
        listTableView.reloadData()
    }
}
