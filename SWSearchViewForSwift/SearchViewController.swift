//
//  SearchViewController.swift
//  SWSearchViewForSwift
//
//  Created by 박성원 on 2016. 7. 16..
//  Copyright © 2016년 ParkSungWon. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var dismissButton: UIButton!
    
    let NOTI_NAME = "hideSearchContainerView"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        self.dismissButton .addTarget(self, action: #selector(SearchViewController.dismissView), forControlEvents: .TouchUpInside)
    }
    
    func dismissView() {
        NSNotificationCenter.defaultCenter().postNotificationName(NOTI_NAME, object: nil)
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        NSNotificationCenter.defaultCenter().postNotificationName(NOTI_NAME, object: nil)
    }
    
}
