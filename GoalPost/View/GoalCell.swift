//
//  GoalCell.swift
//  GoalPost
//
//  Created by Kien on 2/19/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    @IBOutlet var goalDescriptionLbl: UILabel!
    @IBOutlet var goalTypeLbl: UILabel!
    @IBOutlet var goalProgressLbl: UILabel!
    @IBOutlet var completionView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(goal:Goal)  {
        self.goalDescriptionLbl.text = goal.goalDescription
        self.goalTypeLbl.text =  goal.goalType
        self.goalProgressLbl.text = String(describing: goal.goalProgress)
        
        if goal.goalProgress == goal.goalCompletionValue {
            self.completionView.isHidden = false
            print("goal process\(goal.goalCompletionValue)")
        } else {
            self.completionView.isHidden = true
        }
        
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
