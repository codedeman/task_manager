//
//GoalVC.swift
//  GoalPost
//
//  Created by Kien on 2/19/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications
let appDelegate = UIApplication.shared.delegate as? AppDelegate


class GoalVC: UIViewController {
    
    var goals:[Goal] = []
    var goal:Goal?
    
    @IBOutlet var menuButton: UIButton!
    
    @IBOutlet var tableVIew: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("your process\(String(describing: goal?.goalProgress))")
        if self.revealViewController() != nil {
//            menuButton.target =  self.revealViewController()
//            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
    
        
        tableVIew.delegate =  self
        tableVIew.dataSource =  self
        tableVIew.isHidden =  false
//        goal.goalCompletionValue = Int32
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoreDataObjects()
        tableVIew.reloadData()

    
    }
    
   
    
    func fetchCoreDataObjects() {
        self.fetch { (complete) in
            if complete {
                if goals.count >= 1 {
                    tableVIew.isHidden = false
                } else {
                    tableVIew.isHidden = true
                }
            }
        }
    }

    @IBAction func addGoalButtonWasPressed(_ sender: Any) {
        
        guard let creteGoalVC =  storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") else{ return }
        
        presentDetail(viewControllerToPresent: creteGoalVC)
        
        
    }
    
    
}

extension GoalVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else {return UITableViewCell()}
        let goal = goals[indexPath.row]
        
        print("what's wrong\(goal.goalProgress)")
        cell.configureCell(goal: goal)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
    private func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            self.removeGoal(atIndexPath: indexPath)
            self.fetchCoreDataObjects()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let addAction = UITableViewRowAction(style: .normal, title: "ADD 1") { (rowAction, indexPath) in
            self.setProgress(atIndexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
//
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        addAction.backgroundColor = #colorLiteral(red: 0.961445272, green: 0.650790751, blue: 0.1328578591, alpha: 1)
        
        return [deleteAction,addAction]
    }
    
    
    
    
    
}


extension GoalVC{
    
    func setProgress(atIndexPath indexPath:IndexPath)  {
    
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        let chosenGoal  = goals[indexPath.row]
        if chosenGoal.goalProgress < chosenGoal.goalCompletionValue{
            
            chosenGoal.goalProgress =  chosenGoal.goalProgress + 1
        }
        else{
            return
        }
        do{
            try managedContext.save()
                print("Successfully set progress!")
        }catch{
            debugPrint("Could not set progress: \(error.localizedDescription)")

            
        }
    }
//    func setProgress(atIndexPath indexPath: IndexPath) {
//        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
//
//        let chosenGoal = goals[indexPath.row]
//
//        if chosenGoal.goalProgress < chosenGoal.goalCompletionValue {
//            chosenGoal.goalProgress = chosenGoal.goalProgress + 1
//        } else {
//            return
//        }
//
//        do {
//            try managedContext.save()
//            print("Successfully set progress!")
//        } catch {
//            debugPrint("Could not set progress: \(error.localizedDescription)")
//        }
//    }
    
    
    func removeGoal(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return}
        
            managedContext.delete(goals[indexPath.row])
        
        do {
            try managedContext.save()
            print("Successfully removed goal!")
        } catch {
            debugPrint("Could not remove: \(error.localizedDescription)")
        }
    }
    
        func fetch(completion:(_ complete:Bool)->())  {
            
            guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
            
            let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
            
            do {
                goals = try managedContext.fetch(fetchRequest)
                print("Successfully fetched data.")
                print("hello what is this\(goals.count)")

                completion(true)
            } catch {
                debugPrint("Could not fetch: \(error.localizedDescription)")
                completion(false)
            }
  
    }
}
