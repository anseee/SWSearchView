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
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.register(UINib (nibName: "SearchBarCell", bundle: nil), forCellReuseIdentifier: "searchBarCell")
        self.dismissButton.addTarget(self, action: #selector(SearchViewController.dismissView), for: .touchUpInside)
    }
    
    //MARK : custom methods
    
    func dismissView() {
        let notificationName = Notification.Name(NOTI_NAME)
        self.searchBar.resignFirstResponder()
        NotificationCenter.default.post(name:notificationName, object: nil)
    }
    
    //MARK: search view delegate and methods
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.shadowView.isHidden = false
        self.searchBar.resignFirstResponder()
        let notificationName = Notification.Name(NOTI_NAME)
        NotificationCenter.default.post(name: notificationName, object: nil)
    }

    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) { // called when text changes (including clear)

        if searchText.characters.count == 0 {
            self.isFiltered = false
        } else { 
            self.shadowView.isHidden = true
            self.isFiltered = true
            self.filteredItems = []
            
            for text in self.items {

                if text.range(of: searchText) != nil {
                   self.filteredItems.append(text)
                }
            }
            
        }
        
        self.tableView.reloadData()
    }
    
    //MARK: uitableview delegate and datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isFiltered {
            return self.filteredItems.count
        } else {
            return self.items.count
        }
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        if self.isFiltered {
            cell.textLabel?.text = self.filteredItems[indexPath.row] // 1 is Search Bar Cell
        } else {
            cell.textLabel?.text = self.items[indexPath.row] // 1 is Search Bar Cell
        }
        
        return cell
    }
}
