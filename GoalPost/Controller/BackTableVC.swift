//
//  BackTableVC.swift
//  GoalPost
//
//  Created by Kien on 3/15/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import Foundation

class BackTableVC:UITableViewController {
    
//    var category:[String] = []
        var calendar = ["your goal today","your goal this week"]

    override func viewDidLoad() {
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calendar.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = calendar[indexPath.row]
        
        
        return cell!
    }
    
}
