//
//  ImageViewController.swift
//  DucTran-SnapchatCamera
//
//  Created by Duc Tran on 8/15/17.
//  Copyright © 2017 Duc Tran. All rights reserved.
//

import UIKit

class ImageViewController : UIViewController
{
    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = image
    }
    
    @IBAction func closeButtonDidTap () {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func save(sender: UIButton) {
        guard let imageToSave = image else {
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil, nil)
        dismiss(animated: false, completion: nil)
    }
}



















