//
//  ShadowView.swift
//  GoalPost
//
//  Created by Kien on 3/12/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit

class ShadowView: UIView {

    func setupView()  {
        self.layer.shadowOpacity = 0.75
        self.layer.shadowRadius = 5
        self.layer.shadowColor = UIColor.blue.cgColor
        
    }
    
    

}
