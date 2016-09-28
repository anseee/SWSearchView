//
//  ViewController.swift
//  SWSearchViewForSwift
//
//  Created by 박성원 on 2016. 7. 16..
//  Copyright © 2016년 ParkSungWon. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var naviViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    
    weak var searchViewController:SearchViewController!
    var items: [String] = ["i", "like", "swift", "language"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.register(UINib (nibName: "SearchBarCell", bundle: nil), forCellReuseIdentifier: "searchBarCell")
        
        let notificationName = Notification.Name("hideSearchContainerView")
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.hideSearchContainerView), name: notificationName, object: nil)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SearchViewController {
            self.searchViewController = vc
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count + 1// 1 is Search Bar Cell
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            
            let cell:SearchBarCell = self.tableView.dequeueReusableCell(withIdentifier: "searchBarCell")! as! SearchBarCell
            
            return cell
            
        } else {
            
            let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
            
            cell.textLabel?.text = self.items[indexPath.row - 1]  // 1 is Search Bar Cell
            
            return cell
            
        }
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if (indexPath.row == 0) {
            UIView.animate(withDuration: 0.25, animations: {
                self.containerView.alpha = 1
                self.naviViewTopConstraint.constant = -64
                self.searchViewController.searchBar.becomeFirstResponder()
                self.searchViewController.searchBar.setShowsCancelButton(true, animated: true)
                self.view.layoutIfNeeded()
            })
        }
    }

    // MARK: Notifications
    
    func hideSearchContainerView() {
        UIView.animate(withDuration: 0.25, animations: {
            self.containerView.alpha = 0
            self.naviViewTopConstraint.constant = 0
            self.searchViewController.searchBar.resignFirstResponder()
            self.view.layoutIfNeeded()
        })
    }
}

