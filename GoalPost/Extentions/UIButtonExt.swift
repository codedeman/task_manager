//
//  UIButtonExt.swift
//  GoalPost
//
//  Created by Kien on 2/19/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit
extension UIButton{
    func setSelectedColor()  {
        self.backgroundColor = #colorLiteral(red: 1, green: 0.5410594344, blue: 0.5469469428, alpha: 1)
        
    }
    
    
    func setDeselectedColor()  {
        self.backgroundColor = #colorLiteral(red: 1, green: 0.8193475864, blue: 0.7946336875, alpha: 1)
        
    }
    func rounderButton()  {
//        self.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
//        self.clipsToBounds = true
        
        self.layer.shadowColor = #colorLiteral(red: 1, green: 0.5575278401, blue: 0.1083418652, alpha: 1)
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 0.5
        self.layer.cornerRadius = self.frame.width / 2
        
//        self.layer = cornerRadius = 0.5 * self.bounds.size.width
    }
    
}
