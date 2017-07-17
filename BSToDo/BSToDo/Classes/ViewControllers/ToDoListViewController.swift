//
//  ToDoListViewController.swift
//  BSToDo
//
//  Created by Burak SIPCIKOGLU on 17/07/2017.
//  Copyright © 2017 burak. All rights reserved.
//

import UIKit

class ToDoListViewController: UIViewController {
    //MARK: - Properties
    @IBOutlet weak var listTableView: UITableView!
    
    lazy var searchBar = UISearchBar(frame: CGRect.zero)
    
    var listArray: NSMutableArray = []
    //MARK: - View Cyle
    override func viewDidLoad() {
        setSearchBar()
        navigationItem.titleView = searchBar
        super.viewDidLoad()
        createDummyList()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addNewToDoButtonAction(_ sender: Any) {
    }
    
    @IBAction func segmentControlDidChange(_ sender: Any) {
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
    
    func createDummyList() {
        let first = ToDoListItem()
        first.id = UUID().uuidString
        first.note = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin a luctus nisi. Pellentesque mauris leo, vehicula non bibendum eu, tempor at urna. Praesent sodales elit libero, ac ultrices ligula porttitor dictum. Etiam mattis hendrerit urna nec dignissim. Donec blandit mauris orci, in suscipit dui facilisis quis. Aenean ut pellentesque purus, non faucibus erat. Duis aliquam blandit mauris, ut vulputate nisl dignissim eget. Proin elemen"
        first.priority = 3
        first.date = Date()
        
        let second = ToDoListItem()
        second.id = UUID().uuidString
        second.note = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin a luctus nisi. Pellentesque mauris leo, vehicula non bibendum eu, tempor at urna. Praesent sodales elit libero, ac ultrices ligula porttitor dictum. Etiam mattis hendrerit urna nec dignissim. Donec blandit mauris orci, in suscipit dui facilisis quis. Aenean ut pellentesque purus, non faucibus erat. Duis aliquam blandit mauris, ut vulputate nisl dignissim eget. Proin elemen"
        second.priority = 2
        second.date = Date()
        
        listArray.add(first)
        listArray.add(second)
        listTableView.reloadData()
    }
}

//MARK: - UITableViewDataSource
extension ToDoListViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListTableViewCell", for: indexPath) as! ToDoListTableViewCell
        let item = listArray.object(at: indexPath.row) as! ToDoListItem
//        cell.titleLabel.text = item.title! + String(describing: item.date)
        cell.spotLabel.text = item.note!

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
            //            try! realm.write {
            ////                realm.delete(objectForIndexPath(indexPath: indexPath)!)
            //            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Note", sender: nil)
    }
}

//MARK: - UISearchBarDelegate
extension ToDoListViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if SearchHelper.sharedInstance.searchList.count == 0{
//            loadingIndicator.startAnimating()
//        }else {
//            loadingIndicator.stopAnimating()
//            searchWith(text: searchBar.text!)
//            searchListCollectionView.reloadData()
//        }
//        if searchText.characters.count == 0 {
//            loadingIndicator.stopAnimating()
//        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.resignFirstResponder()
    }
    
    func searchWith(text: String) {
//        let searchBrandList: [SearchBrandItem] = SearchHelper.sharedInstance.searchList[0] as! [SearchBrandItem]
//        let searchModelList: [SearchModelItem] = SearchHelper.sharedInstance.searchList[1] as! [SearchModelItem]
//        let searchAuctionList: [SearchAuctionItem] = SearchHelper.sharedInstance.searchList[2] as! [SearchAuctionItem]
//        
//        brandList = searchBrandList.filter({($0.brandName?.lowercased().contains(text.lowercased()))!})
//        modelList = searchModelList.filter({($0.modelName?.lowercased().contains(text.lowercased()))!})
//        auctionList = searchAuctionList.filter({($0.titleName?.lowercased().contains(text.lowercased()))!})
//        searchListCollectionView.isHidden = false
//        resultNotFoundLabel.isHidden = true
//        if brandList.count == 0 && modelList.count == 0 && auctionList.count == 0 && text != "" {
//            resultNotFoundLabel.isHidden = false
//            resultNotFoundLabel.text = String(format: "\"%@\" için sonuç bulunamadı.", text)
//            searchListCollectionView.isHidden = true
//        }
    }
}
