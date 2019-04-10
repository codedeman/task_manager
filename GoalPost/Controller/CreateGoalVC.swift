//
//  CreateGoalVC.swift
//  GoalPost
//
//  Created by Kien on 2/19/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController,UITextViewDelegate {

    var reminders = [Reminder]()
    @IBOutlet var goalTextView: UITextView!
    @IBOutlet var shortTermBtn: UIButton!
    @IBOutlet var longTermBtn: UIButton!
    @IBOutlet var nextBtn: UIButton!
    
  
    var goalType:GoalType = .shortTerm
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.bindToKeyboard()
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()
        goalTextView.delegate =  self
       

    }
    
    
    @IBAction func shortTermButtonWasPressed(_ sender: Any) {
        goalType = .shortTerm
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()
   
    }
    
    @IBAction func longTermButtonWasPressed(_ sender: Any) {
        
//        datePicker.isHidden =  false
        
        goalType = .logTerm
        longTermBtn.setSelectedColor()
        shortTermBtn.setDeselectedColor()
        
        
        
    }
    @IBAction func nextBtnWasPressed(_ sender: Any) {
        

        if goalTextView.text != "" && goalTextView.text != "What is your goal?" {
            guard let finishGoalVC = storyboard?.instantiateViewController(withIdentifier: "FinishGoalVC") as? FinishGoalVC else { return }
            finishGoalVC.initData(description: goalTextView.text!, type: goalType)
            presentingViewController?.presentSecondaryDetail(viewControllerToPresent: finishGoalVC)
        }
//
        
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
    
 
    func textViewDidBeginEditing(_ textView: UITextView) {
        goalTextView.text = ""
        goalTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    func saveReminders() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(reminders, toFile: Reminder.ArchiveURL.path)
        if !isSuccessfulSave {
            print("Failed to save reminders...")
        }
    }
    @IBAction func unwindToReminderList(sender: UIStoryboardSegue) {
//        if let sourceViewController = sender.source as? AddReminderViewController, let reminder = sourceViewController.reminder {
//            
//            _ = NSIndexPath(row: reminders.count, section: 0)
//            reminders.append(reminder)
//            
//        
//        }
//        if let sourceViewController =  sender
    }

    
    

}
