//
//  SpinView.swift
//  Hungry?
//
//  Created by Ed Kraus on 3/20/23.
//

import SwiftUI

struct SpinView: View {
    let slices = ["Slice 1", "Slice 2", "Slice 3", "Slice 4", "Slice 5", "Slice 6"]
       @State private var angle = 0.0
    var body: some View {
        GeometryReader { geometry in
                   ZStack {
                       ForEach(0..<slices.count) { index in
                           Path { path in
                               path.move(to: CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2))
                               path.addArc(center: CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2),
                                           radius: min(geometry.size.width, geometry.size.height) / 2,
                                           startAngle: Angle(degrees: Double(index) * (360.0 / Double(slices.count))),
                                           endAngle: Angle(degrees: Double(index + 1) * (360.0 / Double(slices.count))),
                                           clockwise: false)
                           }
                           .fill(Color(hue: Double(index) / Double(slices.count), saturation: 0.8, brightness: 0.9))
                           .rotationEffect(.degrees(angle + (Double(index) * (360.0 / Double(slices.count)))))
                           Text(slices[index])
                               .font(.title)
                               .rotationEffect(.degrees((Double(index) * (360.0 / Double(slices.count))) + (360.0 / Double(slices.count) / 2)))
                               .rotationEffect(.degrees(angle + (Double(index) * (360.0 / Double(slices.count)))))
                       }
                       .onAppear {
                           withAnimation(Animation.linear(duration: 5.0).repeatForever()) {
                               angle += 360
                           }
                       }
                   }
               }
           }
       }

struct SpinView_Previews: PreviewProvider {
    static var previews: some View {
        SpinView()
    }
}
