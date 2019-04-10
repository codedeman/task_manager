//
//  CurrentUser.swift
//  GoalPost
//
//  Created by Kien on 3/15/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import Foundation

struct CurrentUser {
    
    let uid:String
    let email:String
    let messages:String
    init(uid:String,dictionary:[String:Any]) {
        
        self.uid = uid
        self.email = dictionary["email"] as? String ?? ""
        self.messages =  dictionary["content"] as? String ?? ""
    }
}
