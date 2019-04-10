//
//  UserProfileVC.swift
//  GoalPost
//
//  Created by Kien on 3/13/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit
import Firebase

class UserProfileVC: UIViewController {

    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var emailLbl: UILabel!
    var calendar = ["Today","Week","About US"]
    var imageIcon = ["calendar","calendar","me-tabIcon"]

    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate =  self
        tableView.dataSource =  self
        emailLbl.text = Auth.auth().currentUser?.email

     
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func fetchUser()  {
        
        if Auth.auth().currentUser !=  nil{
            
            guard let uid =  Auth.auth().currentUser?.uid else {return }
            Database.database().reference().child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            
                guard let dict =  snapshot.value else{return}
                
                let user  = CurrentUser(uid: uid, dictionary: (dict as? [String : Any])!)

                self.emailLbl.text =  user.email
            }) { (err) in
                print(err)
            }
            
        }
        
//        Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
//
//            print("snapshot\(snapshot)")
//        }, withCancel: nil)
    }
    
    
    @IBAction func signOutBtnWasPressed(_ sender: Any) {
        
        let logoutPopup = UIAlertController(title: "Logout?", message: "Are you sure you want to logout?", preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: "Logout?", style: .destructive) { (buttonTapped) in
            do {
                try Auth.auth().signOut()
                let authVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthVC") as? AuthVC
                self.present(authVC!, animated: true, completion: nil)
            } catch {
                print(error)
            }
        }
        logoutPopup.addAction(logoutAction)
        present(logoutPopup, animated: true, completion: nil)
        
    }


}

extension UserProfileVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calendar.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! UserProfileCell
        cell.goalLbl.text  = calendar[indexPath.row]
        cell.imageName.image = UIImage(named: imageIcon[indexPath.row])
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            let diagramProcess = self.storyboard?.instantiateViewController(withIdentifier: "Diagram")
            self.present(diagramProcess!, animated: true, completion: nil)
            
        }
        
        if indexPath.row == 1 {
            
            let diagramProcess = self.storyboard?.instantiateViewController(withIdentifier: "Diagram")
            self.present(diagramProcess!, animated: true, completion: nil)
        }
        
        if indexPath.row == 2 {
            
            let aboutUs = self.storyboard?.instantiateViewController(withIdentifier: "AboutUs")
            self.present(aboutUs!, animated: true, completion: nil)
        }
        
        
    }
    
    
}


