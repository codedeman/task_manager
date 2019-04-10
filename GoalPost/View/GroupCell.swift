//
//  GroupCell.swift

//  GoalPost
//
//  Created by Kien on 3/15/19.
//  Copyright © 2019 Kien. All rights reserved.


import UIKit

class GroupCell: UITableViewCell {

    @IBOutlet weak var groupTitleLbl: UILabel!
    @IBOutlet weak var groupDescLbl: UILabel!
    @IBOutlet weak var memberCountLbl: UILabel!
    
    func configureCell(title: String, description: String, memberCount: Int) {
        self.groupTitleLbl.text = title
        self.groupDescLbl.text = description
        self.memberCountLbl.text = "\(memberCount) members."
    }
}
