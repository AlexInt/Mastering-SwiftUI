//
//  SwiftUI_Path_Shape.swift
//  SwiftUI-Views
//
//  Created by jimmy on 2021/9/19.
//
/*
 1. Understanding Path and how to draw a line with it
 2. What is the Shape protocol and how to drawing a custom shape by conforming to the protocol
 3. How to draw a pie chart
 4. How to create a progress indication with an open circle
 5. How to draw a donut chart
 */
import SwiftUI

struct SwiftUI_Path_Shape: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(spacing: 25.0) {
                //                BasicDrawPath()
                //
                //                StrokeAndFill()
                //
                //                BasicDrawArc()
                
                //                PieView()
                //PathRect()
                Button(action: {

                }, label: {
                    Text("DomeButton")
                        .font(.system(.title, design: .rounded))
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 250, height: 50)
                        .background(Dome().fill(Color.red))
                })
                PauseIcon()
//                ProgressIndicator()
                DonutChart()
                
            }
            .padding(.top, 50)
        }
        
    }
}

struct SwiftUI_Path_Shape_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUI_Path_Shape()
    }
}

struct DonutChart:View {
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 0.4)
                .stroke(Color(.systemBlue), lineWidth: 80)
                .frame(width: 250, height: 250)
            
            Circle()
                .trim(from: 0.4, to: 0.6)
                .stroke(Color(.systemTeal), lineWidth: 80)
            
            Circle()
                .trim(from: 0.6, to: 0.75)
                .stroke(Color(.systemPurple),lineWidth: 80)
            
            Circle()
                .trim(from: 0.75, to: 1.0)
                .stroke(Color(.systemYellow),lineWidth: 90)
                .overlay(
                    Text("25%")
                        .font(.system(.title, design: .rounded))
                        .bold()
                        .foregroundColor(.white)
                        .offset(x: 80, y: -100)
                )
        }
        
    }
}

struct ProgressIndicator:View {
    private var purpleGradient = LinearGradient(gradient: Gradient(colors: [Color(red: 207/255, green: 150/255, blue: 207/255), Color(red: 107/255, green: 116/255, blue: 179/255)]), startPoint: .trailing, endPoint: .leading)
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(.systemGray6),lineWidth: 20)
            
            
            Circle()
                .trim(from: 0, to: 0.85)
                .stroke(purpleGradient,lineWidth: 20)
                .frame(width: 300, height: 300)
                .overlay(
                    VStack{
                        Text("85%")
                            .font(.system(size: 80, weight: .bold, design: .rounded))
                            .foregroundColor(Color(.systemGray))
                        Text("Complete")
                            .font(.system(.body, design: .rounded))
                            .bold()
                            .foregroundColor(Color(.systemGray))
                    }
                )
        }
        .frame(width: 300, height: 300)
    }
}

/*
 SwiftUI actually comes with several built-in shapes including
 Circle , Rectangle , RoundedRectangle , Ellipse , etc
 */
struct PauseIcon:View {
    var body: some View {
        VStack(spacing:15) {
            Circle()
                .foregroundColor(.green)
                .frame(width: 200, height: 200)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 80, height: 80)
                        .foregroundColor(.white)
                )
            
            
        }
    }
}

struct Dome: Shape {
    func path(in rect: CGRect) -> Path {
//        var path = Path()
//        path.move(to: CGPoint(x: 0, y: 0))
//        path.addQuadCurve(to: CGPoint(x: rect.size.width, y: 0),
//                          control: CGPoint(x: rect.size.width/2, y: -(rect.size.width * 0.1)))
//        path.addRect(CGRect(x: 0, y: 0, width: rect.size.width, height: rect.size.height))
//        return path
        Path() {
            $0.move(to: CGPoint(x: 0, y: 0))
            $0.addQuadCurve(to: CGPoint(x: rect.size.width, y: 0),
                            control: CGPoint(x: rect.size.width/2, y: -(rect.size.width * 0.1)))
            $0.addRect(CGRect(x: 0, y: 0, width: rect.size.width, height: rect.size.height))
        }
    }
}

struct PathRect:View {
    var body: some View {
        //                Path(){
        //                    $0.move(to: CGPoint(x: 30, y: 30))
        //                    $0.addQuadCurve(to: CGPoint(x: 230, y: 30),
        //                                    control: CGPoint(x: 130, y: 0))
        //                    $0.addLine(to: CGPoint(x: 230, y: 70))
        //                    $0.addLine(to: CGPoint(x: 30, y: 70))
        //                }
        //                .fill(Color.green)
        
        Path(){
            $0.move(to: CGPoint(x: 30, y: 30))
            $0.addQuadCurve(to: CGPoint(x: 230, y: 30),
                            control: CGPoint(x: 130, y: 0))
            $0.addRect(CGRect(x: 30, y: 30, width: 200, height: 40))
        }
        .fill(Color.green)
    }
}

/*
 By using addArc , you can easily create a pie chart with different colored segments. All you need to do is overlay different pie segments with ZStack . Each segment has a different values of startAngle and endAngle to compose the chart.
 */
struct PieView: View {
    private var centerPoint: CGPoint = CGPoint(x: 187, y: 187)
    private var radius: CGFloat = 150
    
    var body: some View {
        ZStack {
            Path({ path in
                path.move(to: centerPoint)
                path.addArc(center: centerPoint,
                            radius: radius,
                            startAngle: Angle(degrees: 0), //left
                            endAngle: Angle(degrees: 190),
                            clockwise: true)
            })
            .fill(Color(.systemYellow))
            
            
            Path({ path in
                path.move(to: centerPoint)
                path.addArc(center: centerPoint,
                            radius: radius,
                            startAngle: Angle(degrees: 190),
                            endAngle: Angle(degrees: 110),
                            clockwise: true)
            })
            .fill(Color(.systemTeal))
            
            Path(){
                $0.move(to: centerPoint)
                $0.addArc(center: centerPoint,
                          radius: radius,
                          startAngle: Angle(degrees: 110),
                          endAngle: Angle(degrees: 90), //bottom
                          clockwise: true)
            }
            .fill(Color(.systemBlue))
            
            Path(){
                $0.move(to: centerPoint)
                $0.addArc(center: centerPoint,
                          radius: radius,
                          startAngle: Angle(degrees: 90), //bottom
                          endAngle: Angle(degrees: 360), //left
                          clockwise: true)
            }
            .fill(Color(.systemPurple))
            .offset(x: 20, y: 20)
            
            Path(){
                $0.move(to: centerPoint)
                $0.addArc(center: centerPoint,
                          radius: radius,
                          startAngle: Angle(degrees: 90), //bottom
                          endAngle: Angle(degrees: 360), //left
                          clockwise: true)
                $0.closeSubpath()
            }
            .stroke(Color(red: 52/255, green: 52/255, blue: 122/255),lineWidth: 10)
            .offset(x: 20, y: 20)
            .overlay(
                Text("25%")
                    .font(.system(.largeTitle, design: .rounded))
                    .bold()
                    .foregroundColor(.white)
                    .offset(x: 80, y: 260)
            )
        }
    }
}


struct BasicDrawArc:View {
    var body: some View {
        Path({ path in
            path.move(to: CGPoint(x: 200, y: 360))
            path.addArc(center: CGPoint(x: 200, y: 360),
                        radius: 150,
                        startAngle: Angle(degrees: 0.0),  //left
                        endAngle: Angle(degrees: 90),     //bottom
                        clockwise: true) //left -> top -> right -> bottom
        })
        .fill(Color.green)
    }
}

struct StrokeAndFill:View {
    // The fill and stroke modifiers cannot be used in parallel !!!
    // how to stroke and fill
    var body: some View {
        ZStack {
            Path({ path in
                path.move(to: CGPoint(x: 20, y: 60))
                path.addLine(to: CGPoint(x: 40, y: 60))
                path.addQuadCurve(to: CGPoint(x: 210, y: 60), control: CGPoint(x: 125, y: 0))
                path.addLine(to: CGPoint(x: 230, y: 60))
                path.addLine(to: CGPoint(x: 230, y: 100))
                path.addLine(to: CGPoint(x: 20, y: 100))
            })
            .fill(Color.purple)
            
            Path() { path in
                path.move(to: CGPoint(x: 20, y: 60))
                path.addLine(to: CGPoint(x: 40, y: 60))
                path.addQuadCurve(to: CGPoint(x: 210, y: 60), control: CGPoint(x: 125, y: 0))
                path.addLine(to: CGPoint(x: 230, y: 60))
                path.addLine(to: CGPoint(x: 230, y: 100))
                path.addLine(to: CGPoint(x: 20, y: 100))
                path.closeSubpath()
                
            }
            .stroke(Color.green, lineWidth: 5)
        }
    }
}

struct BasicDrawPath:View {
    var body: some View {
        Path() {
            $0.move(to: CGPoint(x: 20, y: 20))
            $0.addLine(to: CGPoint(x: 300, y: 20))
            $0.addLine(to: CGPoint(x: 300, y: 200))
            $0.addLine(to: CGPoint(x: 20, y: 200))
            $0.closeSubpath()
        }
        //        .fill(Color.green)
        .stroke(Color.orange, lineWidth: 4)
    }
}


