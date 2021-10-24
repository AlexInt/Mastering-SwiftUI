//
//  CameraModel.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/10/24.
//

import Foundation
import AVFoundation
import SwiftUI

class CameraModel:  NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    @Published var isTaken = false
    
    @Published var session = AVCaptureSession()
    
    @Published var alert = false
    
    //since were going to read pic data
    @Published var output = AVCapturePhotoOutput()
    
    //preview
    @Published var preview: AVCaptureVideoPreviewLayer!
    
    //pic data
    
    @Published var isSaved = false
    
    @Published var picData = Data(count: 0)
    
    func check() {
        //first checking camera got permission
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setUp()
        case .notDetermined:
            //request for permission
            AVCaptureDevice.requestAccess(for: .video) { status in
                if status {
                    self.setUp()
                }
            }
        case .denied:
            self.alert.toggle()
        default:
            break
        }
    }
    
    /// setting up session
    func setUp() {
        do {
            //setting configs
            self.session.beginConfiguration()
            
            //change for your own, for me iPhone 12 is .builtInDualWideCamera, command + left click to checkout
            guard let device = AVCaptureDevice.default(.builtInDualWideCamera, for: .video, position: .back) else { return }
            let input = try AVCaptureDeviceInput(device: device)
            
            //checking and adding to session
            if self.session.canAddInput(input) {
                self.session.addInput(input)
            }
            
            //same for output
            if self.session.canAddOutput(self.output) {
                self.session.addOutput(self.output)
            }
            self.session.commitConfiguration()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func takePic() {
        DispatchQueue.global(qos: .background).async {
            self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
            self.session.stopRunning()
            
            DispatchQueue.main.async {
                UIImpactFeedbackGenerator(style: .heavy).impactOccurred(intensity: 0.5)
                withAnimation {
                    self.isTaken.toggle()
                }
            }
        }
    }
    
    func reTake() {
        DispatchQueue.global(qos: .background).async {
            self.session.startRunning()
            
            DispatchQueue.main.async {
                UIImpactFeedbackGenerator(style: .medium).impactOccurred(intensity: 0.5)
                withAnimation {
                    self.isTaken.toggle()
                    
                    //clearing
                    self.isSaved = false
                }
            }
        }
    }
    
    func savePic() {
        guard let image = UIImage(data: self.picData) else {
            return
        }
        
        //saving image
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        self.isSaved = true
        print("saved Successfully...")
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard error == nil else {
            return
        }
        
        print("pic taken")
        
        guard let imageData = photo.fileDataRepresentation() else { return }
        
        self.picData = imageData
    }
    
    
}
