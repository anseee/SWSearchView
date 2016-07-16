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
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.registerNib(UINib (nibName: "SearchBarCell", bundle: nil), forCellReuseIdentifier: "searchBarCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? SearchViewController {
            self.searchViewController = vc
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count + 1// 1 is Search Bar Cell
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0) {

            let cell:SearchBarCell = self.tableView.dequeueReusableCellWithIdentifier("searchBarCell")! as! SearchBarCell
            
            return cell
            
        } else {

            let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
            
            cell.textLabel?.text = self.items[indexPath.row - 1] // 1 is Search Bar Cell
            
            return cell
            
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row == 0) {
            UIView.animateWithDuration(0.25, animations: {
                self.containerView.alpha = 1
                self.naviViewTopConstraint.constant = -64
                self.searchViewController.searchBar.becomeFirstResponder()
                self.searchViewController.searchBar.setShowsCancelButton(true, animated: true)
                self.view.layoutIfNeeded()
            })
        }
    }

}

