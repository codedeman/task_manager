//
//  AuthVC.swift
//  GoalPost
//
//  Created by Kien on 3/13/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit

class AuthVC: UIViewController {
    
    
    @IBOutlet var loginFacebookButton: FBSDKLoginButton!
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        if (FBSDKAccessToken.current() != nil) {
            fetchUserProfile()
        }
    }
    
    @IBAction func signInWithEmailBtnWasPressed(_ sender: Any) {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        present(loginVC!, animated: true, completion: nil)
    }
    
    @IBAction func googleSignInBtnWasPressed(_ sender: Any) {
    }
    
    func fetchUserProfile()  {
        
        print("Getting profile")
        print("FB version: \(FBSDKSettings.sdkVersion())")
        print("Tokensssss:  \(String(describing: FBSDKAccessToken.current()?.tokenString))")
        let parameters = ["fields": "email"]
        
        let graphRequest:FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: parameters, httpMethod: "GET")
        
        graphRequest.start { (connection, result, error) -> Void in
          
          
            if error != nil {
                print("Error recieved: \(error.debugDescription)")
                return
            }
            
//            guard let email = result["email"] as! String else {
//                return
//            }
//            print("Email: \(email)")

        }
        
    }
    
    
    @IBAction func facebookSignInWasPressed(_ sender: AnyObject) {
        
        let LoginManager = FBSDKLoginManager()
        
        
        LoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            guard let accessToken = FBSDKAccessToken.current() else {
                print("Failed to get access token")
                return
            }
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            // Perform login by calling Firebase APIs
            Auth.auth().signInAndRetrieveData(with: credential) { (user, error) in
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
                // self.performSegue(withIdentifier: self.signInSegue, sender: nil)
            }
        }
        
    }
    
//    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
//        if let error = error {
//            print(error.localizedDescription)
//            return
//        }
//        // ...
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension AuthVC:FBSDKLoginButtonDelegate{
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if let error = error{
            print(error.localizedDescription)
            return
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("log out")
        
    }
    


}
