//
//  InsetTextField.swift
//  GoalPost
//
//  Created by Kien on 3/12/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit

class InsetTextField: UITextField {

    private var textRectOffset:CGFloat =  20
    private var padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    override func awakeFromNib() {
        setupView()
        super.awakeFromNib()
        
    }
    let container = CGRect(x: 0, y: 0, width: 100, height: 100)

    
//    override func textRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: padding)
//    }
//    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: padding)
//    }
//    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
//         return bounds.inset(by: padding)
//    }
    func setupView()  {
        
        let placeholder =  NSAttributedString(string: self.placeholder!, attributes: [NSAttributedString.Key.foregroundColor:#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)])
        self.attributedPlaceholder  =  placeholder
    }
}
