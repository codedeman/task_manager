//
//  UIControllerExt.swift
//  GoalPost
//
//  Created by Kien on 2/19/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit

extension UIViewController{
    
    func presentDetail(viewControllerToPresent: UIViewController)   {
        
        let transition = CATransition()
        transition.duration = 0.4
//        transition.type =  CATransitionType.path(withComponents: [])
//        transition.subtype = CATransitionSubtype.fromRight
        
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        present(viewControllerToPresent, animated: false, completion: nil)
        
    }
    
    func presentSecondaryDetail(viewControllerToPresent: UIViewController){
        
        let transition = CATransition()
        transition.duration = 0.4
//        transition.type =  CATransitionType.push
//        transition.subtype = CATransitionSubtype.fromRight
        guard presentedViewController != nil else {return }
        presentedViewController?.dismiss(animated: false){
         
            self.view.window?.layer.add(transition, forKey: kCATransition)
            self.present(viewControllerToPresent, animated: false, completion: nil)
            
        }
        
    }
    
    func dismissDetail()  {
        let transition = CATransition()
        transition.duration = 0.3
//        transition.type =  CATransitionType.push
//        transition.subtype = CATransitionSubtype.fromRight
        
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false, completion: nil)
    }
    
    
}


