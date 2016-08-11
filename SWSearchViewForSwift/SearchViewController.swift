//
//  SearchViewController.swift
//  SWSearchViewForSwift
//
//  Created by 박성원 on 2016. 7. 16..
//  Copyright © 2016년 ParkSungWon. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var dismissButton: UIButton!
    var items: [String] = ["i", "like", "swift", "language"]
    var filteredItems: [String] = []
    let NOTI_NAME = "hideSearchContainerView"
    var isFiltered:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.registerNib(UINib (nibName: "SearchBarCell", bundle: nil), forCellReuseIdentifier: "searchBarCell")
        self.dismissButton .addTarget(self, action: #selector(SearchViewController.dismissView), forControlEvents: .TouchUpInside)
    }
    
    //MARK : custom methods
    
    func dismissView() {
        NSNotificationCenter.defaultCenter().postNotificationName(NOTI_NAME, object: nil)
    }
    
    //MARK: search view delegate and methods
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.shadowView.hidden = false
        NSNotificationCenter.defaultCenter().postNotificationName(NOTI_NAME, object: nil)
    }

    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {

        if searchText.characters.count == 0 {
            self.isFiltered = false
        } else { 
            self.shadowView.hidden = true
            self.isFiltered = true
            self.filteredItems = []
            
            for text in self.items {
                
                if text.rangeOfString(searchText, options:.CaseInsensitiveSearch) != nil {
                    self.filteredItems.append(text)
                }
                
            }
            
        }
        
        self.tableView.reloadData()
    }
    
    //MARK: uitableview delegate and datasource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isFiltered {
            return self.filteredItems.count
        } else {
            return self.items.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        if self.isFiltered {
            cell.textLabel?.text = self.filteredItems[indexPath.row] // 1 is Search Bar Cell
        } else {
            cell.textLabel?.text = self.items[indexPath.row] // 1 is Search Bar Cell
        }
        
        return cell

    }

}
