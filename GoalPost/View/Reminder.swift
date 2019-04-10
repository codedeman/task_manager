//
//  Reminder.swift
//  GoalPost
//
//  Created by Kien on 3/3/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import Foundation
import UIKit

class Reminder: NSObject,NSCoding {
    
    
    var notification:UILocalNotification?
//    var notification:UNNotificationRequest?
    var description1: String
    var time:NSDate
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(description1, forKey:PropertyKey.descriptionKey)
        aCoder.encode(time, forKey: PropertyKey.timeKey)
        aCoder.encode(notification, forKey: PropertyKey.notificationKey)
    }
    
  

    

    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("reminders")

    struct PropertyKey {
        static let descriptionKey = "description"
        static let timeKey = "time"
        static let notificationKey = "notification"
    }
    
    init(description1: String, time: NSDate, notification: UILocalNotification) {
        // set properties
        self.description1 = description1
        self.time = time
        self.notification = notification
        
        super.init()
    }
    
    // Destructor
    deinit {
        // cancel notification
        UIApplication.shared.cancelLocalNotification(self.notification!)
    }
    

    
    required convenience init(coder aDecoder: NSCoder) {
        let description = aDecoder.decodeObject(forKey: PropertyKey.descriptionKey) as! String
        
        // Because photo is an optional property of Meal, use conditional cast.
        let time = aDecoder.decodeObject(forKey: PropertyKey.timeKey) as! NSDate
        
        let notification = aDecoder.decodeObject(forKey: PropertyKey.notificationKey) as! UILocalNotification
        
        self.init(description1: description, time: time, notification: notification)
        // Must call designated initializer.
//        self.init(name: name, time: time, notification: notification)
    }
    
}
