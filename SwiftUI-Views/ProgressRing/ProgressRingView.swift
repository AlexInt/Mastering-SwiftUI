//
//  ProgressRingView.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/11/28.
//

import SwiftUI

struct ProgressRingView: View {
    @Binding var progress: Double
    
    var thickness: CGFloat = 30.0
    var width: CGFloat = 250.0
    
    var gradient = Gradient(colors: [.darkPurple, .lightYellow])
    var startAngle = -90.0
    
    private var radius: Double {
        Double(width / 2)
    }
    
    private var ringTipShadowOffset: CGPoint {
        let shadowPosition = ringTipPosition(progress: progress + 0.01)
        let circlePosition = ringTipPosition(progress: progress)
        return CGPoint(x: shadowPosition.x - circlePosition.x, y: shadowPosition.y - circlePosition.y)
    }
    
    private var tipEndColor: Color {
        gradient.stops[gradient.stops.count - 1].color
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(.systemGray6), lineWidth: thickness)
            
            RingShape(progress: progress, thickness: thickness)
                .fill(AngularGradient(gradient: gradient,
                                      center: .center,
                                      startAngle: .degrees(startAngle),
                                      endAngle: .degrees(360 * progress + startAngle)))
            
            RingTip(progress: progress,
                    startAngle: startAngle,
                    ringRadius: radius)
                .frame(width: thickness, height: thickness)
                .foregroundColor(progress > 0.96 ? tipEndColor : Color.clear)
                .shadow(color: progress > 0.96 ? Color.black.opacity(0.15) : Color.clear, radius: 2, x: ringTipShadowOffset.x, y: ringTipShadowOffset.y)
        }
        .frame(width: width, height: width, alignment: .center)
        .animation(Animation.easeInOut(duration: 1.0))
    }
    
    //for computing the position of the ring tip
    private func ringTipPosition(progress: Double) -> CGPoint {
        let angle = 360 * progress + startAngle
        let angleInRadian = angle * .pi / 180
        
        return CGPoint(x: radius * cos(angleInRadian),
                       y: radius * sin(angleInRadian))
    }
}

struct ProgressRingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProgressRingView(progress: .constant(0.5))
                .previewLayout(.fixed(width: 300, height: 300))
            ProgressRingView(progress: .constant(0.9))
                .previewLayout(.fixed(width: 300, height: 300))
        }
    }
}

struct RingShape: Shape {
    var progress: Double = 0.0
    var thickness: CGFloat = 30.0
    
    var gradient = Gradient(colors: [.darkPurple, .lightYellow])
    var startAngle: Double = -90.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.width / 2.0, y: rect.height / 2.0),
                    radius: min(rect.width, rect.height) / 2.0,
                    startAngle: .degrees(startAngle),
                    endAngle: .degrees(360 * progress + startAngle),
                    clockwise: false)
        
        return path.strokedPath(.init(lineWidth: thickness, lineCap: .round))
    }
    //comform to Animatable,
    //override the default implementation and provide the animatable values.
    var animatableData: Double {
        get { progress }
        set { progress = newValue }
    }
}

struct RingTip: Shape {
    var progress: Double = 0.0
    var startAngle: Double = -90.0
    var ringRadius: Double
    
    /*           O
             .   |
  radius  .      |  y
       . θ       |
     *------------    x = cosθ * radius
         x            y = sinθ * radius
     */
    
    private var position: CGPoint {
        let angle = 360 * progress + startAngle
        let angleInRadian = angle * .pi/180
        return CGPoint(x: ringRadius * cos(angleInRadian),
                       y: ringRadius * sin(angleInRadian))
    }
    
    //for animatable
    var animatableData: Double {
        get { progress }
        set { progress = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        guard progress > 0.0 else {
            return path
        }
        
        let frame = CGRect(x: position.x,
                           y: position.y,
                           width: rect.size.width,
                           height: rect.size.height)
        
        path.addRoundedRect(in: frame, cornerSize: frame.size)
        
        return path
    }
}