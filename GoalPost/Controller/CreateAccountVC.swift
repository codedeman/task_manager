//
//  CreateAccountVC.swift
//  GoalPost
//
//  Created by Kien on 3/21/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit
import Firebase

class CreateAccountVC: UIViewController {

    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createAcountWasPressed(_ sender: Any) {
        
        AuthService.instance.registerUser(withEmail: self.usernameTxt.text!, andPassword: self.passTxt.text!, userCreationComplete: { (success, registrationError) in
            
            if success{
                let alertController = UIAlertController(title: "Erro", message: "Please check your password and email ", preferredStyle: .actionSheet)
                let canceltAction = UIAlertAction(title: "OK", style: .destructive)
                alertController.addAction(canceltAction)
                self.present(alertController, animated: true, completion: nil)
                
                
//                AuthService.instance.loginUser(withEmail: self.emailField.text!, andPassword: self.passwordField.text!, loginComplete: { (success, nil) in
//                    print("Sucessfully register user")
//                    //                            self.dismiss(animated: true, completion: nil)
//                })
            }else{
                print(String(describing: registrationError?.localizedDescription))
            }
        })
    }
    
    @IBAction func closeBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
