//
//  CameraView.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/10/24.
//

import SwiftUI
import AVFoundation

struct CameraView: View {
    
    @ObservedObject var camera = CameraModel()
    
    var body: some View {
        ZStack {
            
            //Going to be camera preview
            CameraPreview(camera: camera)
                .ignoresSafeArea(.all, edges: .all)
            
            VStack {
                
                if camera.isTaken {
                    HStack {
                        Spacer()
                        
                        Button(action: camera.reTake) {
                            Image(systemName: "arrow.triangle.2.circlepath.camera")
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                        .padding(.trailing, 10)

                    }
                }
                
                Spacer()
                
                HStack {
                    //if taken showing save and again take button
                    
                    if camera.isTaken {
                        
                        Button(action: {
                            if !camera.isSaved {
                                camera.savePic()
                            }
                        }) {
                            Text(camera.isSaved ? "Saved" : "Save")
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(Color.white)
                                .clipShape(Capsule())
                        }
                        .padding(.leading)
                        
                        Spacer()
                    }
                    else {
                        Button(action: camera.takePic) {
                            ZStack {
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 65, height: 65)
                                
                                Circle()
                                    .stroke(Color.white,lineWidth: 2)
                                    .frame(width: 75, height: 75)
                            }
                        }
                    }
                    
                }
                .frame(height: 75)
            }
            
            
        }
        .onAppear {
            camera.check()
        }
        .alert(isPresented: $camera.alert) {
            Alert(title: Text("Please Enable Camera Access"))
        }
        
    }
}

struct CameraPreview: UIViewRepresentable {
    
    @ObservedObject var camera: CameraModel
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
        camera.preview.frame = view.frame
        
        //choose for your own
        camera.preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(camera.preview)
        
        //starting session
        camera.session.startRunning()
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}
