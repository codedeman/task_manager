//
//  FinishGoalVC.swift
//  GoalPost
//
//  Created by Kien on 2/20/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit

import CoreData
import UserNotifications
import Firebase


class FinishGoalVC: UIViewController,UITextFieldDelegate {

    @IBOutlet var pointsTextField: UITextField!
    
    @IBOutlet var createGoalBtn: UIButton!
    
    var goalDescription: String!
    var goalType: GoalType!
    var dateComponents = DateComponents()
    
    @IBOutlet var datePicker: UIDatePicker!
    
    func initData(description: String, type: GoalType) {
        self.goalDescription = description
        self.goalType = type
    }
    
    
    @IBAction func datePickerFromValueChanged(_ sender: Any) {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd-MM-yyyy"
//        let time = dateFormatter.string(from: (sender as AnyObject).date)
//        print(" this is new value \(time)")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        datePicker.datePickerMode = .date
//        datePicker.datePickerMode = .time
        createGoalBtn.bindToKeyboard()
        datePicker.isHidden = true
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { (granted, error) in
            
            if granted{
                print("Notification access granted ")
            }
            else{
                
                print(error?.localizedDescription ?? "e ")
            }
        }
    
    }
    

    
    @IBAction func createGoalBtnWasPressed(_ sender: Any) {
        datePicker.datePickerMode = .time
        let date = datePicker.date

        
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
   
        _ = components.minute!
        
        
     

        
//
        if pointsTextField.text != "" {
            self.save { (complete) in
                if complete {
//
                    DataService.instance.uploadPost(withMessage: goalDescription, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: nil, sendComplete: { (isComplete) in

                        if isComplete{

                            self.createGoalBtn.isEnabled  = true
                            self.dismiss(animated: true, completion: nil)

                        }else{
                            self.createGoalBtn.isEnabled  = true
                            print("there are error")

                        }
                    })
//
                }
            }
        }
        

       
        

      
        
//        scheduleNotification(inSeconds: TimeInterval(minute) , completion: { success in
//
//            if success{
//                print("Successfully schedule notification")
//            }
//            else{
//                print("Erro")
//            }
//        })
    
    }
    
    
    @IBAction func remindGoalBtnWasPressed(_ sender: Any) {
        datePicker.isHidden = false
        
//        datePicker.datePickerMode = .date
//        let timer = datePicker.datePickerMode = .time
//
//        print("your variable\(timer)")
    }
    @IBAction func backWasPressed(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
        dismissDetail()

    }
    
    func scheduleNotification(inSeconds:TimeInterval,completion:@escaping (_ Success:Bool)->()) {
        let myImage = "bb"
        guard  let imageUrl = Bundle.main.url(forResource: myImage, withExtension: "gif") else {
            completion(false)
            return
        }
        var attachment:UNNotificationAttachment
        
          attachment = try!UNNotificationAttachment(identifier: "myNotification", url:imageUrl , options: .none)
        //ONLY FOR EXTENSION
    
         let notif = UNMutableNotificationContent()
        notif.categoryIdentifier = "myNotificationCategory"
        notif.title = "New Notification"
        notif.subtitle =  goalType!.rawValue
        notif.body = goalDescription
        notif.attachments  = [attachment]
 
        
        let  notifTrigger =  UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
//                let  notifTrigger =  UNTimeIntervalNotificationTrigger(

        
        let request =  UNNotificationRequest(identifier: "myNotification", content: notif, trigger: notifTrigger)
        
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            
            if error != nil{
                
                print(error!)
                completion(false)
                
            }
            else {
                completion(true)
            }
        })
    }
    
    
    func save(completion: (_ finished: Bool) -> ()) {
      
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let goal = Goal(context: managedContext)
        
        goal.goalDescription = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalCompletionValue = Int32(pointsTextField.text!)!
        goal.goalProgress = Int32(0)
        print("your goal\(goal.goalCompletionValue)")
        
        do {
            try managedContext.save()
            print("Successfully saved data.")
            completion(true)
        } catch {
            debugPrint("Could not save: \(error.localizedDescription)")
            completion(false)
        }
       
    }
    private func textViewDidEndEditing(_ textView: UITextView) {
        pointsTextField.text = ""
        pointsTextField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
