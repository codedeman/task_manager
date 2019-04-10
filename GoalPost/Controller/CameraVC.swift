//
//  CameraVC.swift
//  GoalPost
//
//  Created by Kien on 3/23/19.
//  Copyright © 2019 Kien. All rights reserved.
//

import UIKit

import Photos
import AVFoundation


class CameraVC: UIViewController {
    var captureSession = AVCaptureSession()
    
    // which camera input do we want to use
    var backFacingCamera: AVCaptureDevice?
    var frontFacingCamera: AVCaptureDevice?
    var currentDevice: AVCaptureDevice?
    
    // output device
    var stillImageOutput: AVCaptureStillImageOutput?
    var stillImage: UIImage?
    
    // camera preview layer
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    
    // double tap to switch from back to front facing camera
    var toggleCameraGestureRecognizer = UITapGestureRecognizer()
    
    
    @IBOutlet var camerButton: UIButton!
    @IBOutlet var capturePreviewView: UIView!
    @IBOutlet var  toggleCameraButton: UIButton!
    
    override var prefersStatusBarHidden: Bool { return true }

    
    var devices = AVCaptureDevice.devices(for: AVMediaType.video)
    
    


    
override func viewDidAppear(_ animated: Bool) {
        
        
        
}
    override func viewDidLoad() {
        super.viewDidLoad()
        camerButton.rounderButton()
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        let devices = AVCaptureDevice.devices(for: AVMediaType.video)
        for device in devices {
            if device.position == .back {
                backFacingCamera = device
            } else if device.position == .front {
                frontFacingCamera = device
            }
        }
        // default device
        currentDevice = frontFacingCamera
        
        stillImageOutput = AVCaptureStillImageOutput()
        stillImageOutput?.outputSettings = [AVVideoCodecKey : AVVideoCodecJPEG]
        
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentDevice!)
            
            captureSession.addInput(captureDeviceInput)
            captureSession.addOutput(stillImageOutput!)
            
            // set up the camera preview layer
            cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            view.layer.addSublayer(cameraPreviewLayer!)
            cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            cameraPreviewLayer?.frame = view.layer.frame
            
            view.bringSubview(toFront: camerButton)
            
            captureSession.startRunning()
            
            // toggle the camera
//            toggleCameraGestureRecognizer.numberOfTapsRequired = 2
//            toggleCameraGestureRecognizer.addTarget(self, action: #selector(toggleCamera))
//            view.addGestureRecognizer(toggleCameraGestureRecognizer)
        } catch let error {
            print(error)
        }
    }

    
    
    @IBAction func switchCamera(_ sender: Any) {
        
       
    }
    @IBAction func cameraCapture(_ sender: Any) {
        
        let videoConnection = stillImageOutput?.connection(with: AVMediaType.video)
        
        // capture a still image asynchronously
        stillImageOutput?.captureStillImageAsynchronously(from: videoConnection!, completionHandler: { (imageDataBuffer, error) in
            
            if let imageData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: imageDataBuffer!, previewPhotoSampleBuffer: imageDataBuffer!) {
                self.stillImage = UIImage(data: imageData)
                self.performSegue(withIdentifier: "showPhoto", sender: self)
            }
        })
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhoto" {
            let imageViewController = segue.destination as! ImageViewController
            imageViewController.image = self.stillImage
        }
    }
    

}
