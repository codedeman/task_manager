//
//  FirstViewController.swift
//  breakpoint
//
//  Created by Caleb Stultz on 7/22/17.
//  Copyright © 2017 Caleb Stultz. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class FeedVC: UIViewController,NVActivityIndicatorViewable {
    static let activityData = ActivityData()

    @IBOutlet weak var tableView: UITableView!
    
    var messageArray = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        startAnimating()
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now()+3, qos: .unspecified, execute: {
            self.self.startAnimating()
            DataService.instance.getAllFeedMessages { (returnedMessagesArray) in
                self.messageArray = returnedMessagesArray.reversed()
                self.tableView.reloadData()
                if self.messageArray.count > 0{
                    
                    self.tableView.scrollToRow(at: IndexPath(row: self.messageArray.count - 1, section: 0), at: .none, animated: true)
                }
            }
            self.stopAnimating()
            
        })

        
    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//            self.startAnimating()
//            DispatchQueue.main.asyncAfter(deadline: .now()+2, qos: .unspecified, execute: {
//
//                            DataService.instance.getAllFeedMessages { (returnedMessagesArray) in
//                                self.messageArray = returnedMessagesArray.reversed()
//                                self.tableView.reloadData()
//                                if self.messageArray.count > 0{
//
//                                    self.tableView.scrollToRow(at: IndexPath(row: self.messageArray.count - 1, section: 0), at: .none, animated: true)
//                                }
//                            }
//                self.stopAnimating()
//
//            })
//
//
////        }
//
//    }

}

extension FeedVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y > 0{
           tableView.reloadData()
        }else{
            tableView.reloadData()

        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell") as? FeedCell else { return UITableViewCell() }
        let image = UIImage(named: "defaultProfileImage")
        let message = messageArray[indexPath.row]
        let queue =  DispatchQueue(label: "concurentQueue", qos: .background, attributes: DispatchQueue.Attributes.concurrent)
        
            if self.messageArray.count > 10{
                queue.asyncAfter(deadline: .now()+2, qos: .utility, flags: .barrier) {
                    
//                    DispatchQueue.main.async {
                    
                        DataService.instance.getUsername(forUID: message.senderId) { (returnedUsername) in
                            cell.configureCell(profileImage: image!, email: returnedUsername, content: message.content)
                            tableView.reloadData()
                        }
                        
//                    }
                    
                }
                
                
                
            }
            
//        }
     
//        DataService.instance.getUsername(forUID: message.senderId) { (returnedUsername) in
//            cell.configureCell(profileImage: image!, email: returnedUsername, content: message.content)
//        }
        return cell
    }
}
