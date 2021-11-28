//
//  SwiftUI_Animation.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/9/20.
//

import SwiftUI

struct SwiftUI_Animation: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: true){
            VStack(spacing: 50.0) {
                HeartAnimation()
                LoadingIndicator(type: .circular)
                LoadingIndicator(type: .linear)
                ProgressView()
                DotLoading()
                
                MorphingButton()
                
                FancyButton()
                //                Spacer()
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.top, 10)
        }
    }
}

struct FancyButton: View {
    @State private var processing = false
    @State private var completed = false
    @State private var loading = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .frame(width: processing ? 250 : 200, height: 60)
                .foregroundColor(completed ? .red : .green)
            
            if !processing {
                Text("Submit")
                    .font(.system(.title, design: .rounded))
                    .bold()
                    .foregroundColor(.white)
                    .transition(.move(edge: .top))
            }
            
            if processing && !completed {
                HStack {
                    Circle()
                        .trim(from: 0, to: 0.9)
                        .stroke(Color.white, lineWidth: 3)
                        .frame(width: 30, height: 30)
                        .rotationEffect(Angle(degrees: loading ? 360 : 0))
                        .animation(Animation.easeOut.repeatForever(autoreverses: false))
                    
                    Text("Processing")
                        .font(.system(.title, design: .rounded))
                        .bold()
                        .foregroundColor(.white)
                }
                .transition(.opacity)
                .onAppear() {
                    self.startProcessing()
                }
                
            }
            
            if completed {
                Text("Done")
                    .font(.system(.title, design: .rounded))
                    .bold()
                    .foregroundColor(.white)
                    .onAppear() {
                        self.endProcessing()
                    }
            }
        }
        .animation(.spring())
        .onTapGesture {
            self.processing.toggle()
            
        }
    }
    
    private func startProcessing() {
        self.loading = true
        
        // Simulate an operation by using DispatchQueue.main.asyncAfter
        // In a real world project, you will perform a task here.
        // When the task finishes, you set the completed status to true
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.completed = true
        }
    }
    
    private func endProcessing() {
        // Reset the button's state
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.processing = false
            self.completed = false
            self.loading = false
        }
    }
}

struct MorphingButton:View {
    @State private var recordBegin = false
    @State private var recording = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: recordBegin ? 30 : 5)
                .frame(width: recordBegin ? 60 : 250, height: 60)
                .foregroundColor(recordBegin ? .red : .green)
                .overlay(
                    Image(systemName: "mic.fill")
                        .font(.title)
                        .foregroundColor(.white)
                        .scaleEffect(recording ? 0.7 : 1)
                )
            
            RoundedRectangle(cornerRadius: recordBegin ? 35 : 10)
                .trim(from: 0, to: recordBegin ? 0.0001 : 1)
                .stroke(lineWidth: 5)
                .frame(width: recordBegin ? 70 : 260, height: 70)
                .foregroundColor(.green)
        }
        .onTapGesture {
            withAnimation(.spring()) {
                self.recordBegin.toggle()
            }
            
            withAnimation(.spring().repeatForever().delay(0.5)) {
                self.recording.toggle()
            }
        }
    }
}

struct DotLoading: View {
    @State private var isLoading = false
    var body: some View {
        HStack {
            ForEach(0...4, id: \.self) { index in
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(.green)
                    .scaleEffect(self.isLoading ? 0 : 1)
                    .animation(.linear(duration: 0.6).repeatForever().delay(0.2 * Double(index)))
            }
        }
        .onAppear(perform: {
            self.isLoading = true
        })
    }
}


struct ProgressView: View {
    @State private var progress: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            Text("\(Int(progress * 100))%")
                .font(.system(.title, design: .rounded))
                .bold()
            
            Circle()
                .stroke(Color(.systemGray5),lineWidth: 10)
                .frame(width: 150, height: 150)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color.green, lineWidth: 10)
                .frame(width: 150, height: 150)
                .rotationEffect(Angle(degrees: -90))
        }
        .onAppear(perform: {
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { t in
                self.progress += 0.05
                print(self.progress)
                if self.progress >= 1.0 {
                    t.invalidate()
                }
            }
        })
    }
}


enum LoadingType {
    case linear
    case circular
}
struct LoadingIndicator: View {
    
    @State private var isLoading = false
    @State var type: LoadingType = .circular
    
    var body: some View {
        ZStack {
            if type == .circular {
                Group {
                    Circle()
                        .stroke(Color(.systemGray5),lineWidth: 14)
                        .frame(width: 100, height: 100, alignment: .center)
                    
                    Circle()
                        .trim(from: 0.0, to: 0.2)
                        .stroke(Color.green, lineWidth: 7)
                        .frame(width: 100, height: 100)
                        .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                    //            .animation(.default.repeatForever(autoreverses: false))
                        .animation(.linear(duration: 1.0).repeatForever(autoreverses: false))
                }
            } else {
                Group {
                    Text("Loading")
                        .font(.system(.body, design: .rounded))
                        .bold()
                        .offset(x: 0, y: -25)
                    
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(Color(.systemGray5), lineWidth: 3)
                        .frame(width: 250, height: 3, alignment: .center)
                    
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(Color.green,lineWidth: 3)
                        .frame(width: 30, height: 3)
                        .offset(x: isLoading ? 110 : -110, y: 0)
                        .animation(.linear(duration: 1).repeatForever(autoreverses: false))
                }
            }
        }
        .onAppear(perform: {
            self.isLoading = true
        })
    }
}


struct HeartAnimation:View {
    @State private var circleColorChanged = false
    @State private var heartColorChanged = false
    @State private var heartSizeChanged = false
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 200, height: 200)
                .foregroundColor(circleColorChanged ? Color(.systemGray5) : .red)
            
            Image(systemName: "heart.fill")
                .foregroundColor(heartColorChanged ? .red : .white)
                .font(.system(size: 100))
                .scaleEffect(heartSizeChanged ? 1.0 : 0.5)
        }
        // implicit animation : add animation modifier to views, e.g down below
        //        .animation(.default)
        //        .animation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.3))
        .onTapGesture {
            //With explicit animation, you can easily control which state you want to animation
            //            withAnimation {
            //                self.circleColorChanged.toggle()
            //                self.heartColorChanged.toggle()
            //                self.heartSizeChanged.toggle()
            //            }
            withAnimation(.spring(response: 0.3, dampingFraction: 0.3, blendDuration: 0.3)) {
                self.circleColorChanged.toggle()
                self.heartColorChanged.toggle()
                self.heartSizeChanged.toggle()
            }
        }
    }
}


struct SwiftUI_Animation_Transition_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUI_Animation()
    }
}
