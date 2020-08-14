//
//  Squiggle.swift
//  SwiftUI SetGame
//
//  Created by 김수환 on 2020/08/14.
//

import SwiftUI

struct Squiggle: Shape {
    
    func path(in rect: CGRect) -> Path {
        let point1 = CGPoint(x: rect.midX, y: rect.minY + rect.height * 0.1875)
        let point2 = CGPoint(x: rect.minX + rect.width * 0.25, y: rect.minY + rect.height * 0.0625)
        let point3 = CGPoint(x: rect.minX, y: rect.minY + rect.height * 0.625)
        let point4 = CGPoint(x: rect.minX + rect.width * 0.225, y: rect.minY + rect.height * 0.875)
        
        // Mirror 1, 2, 3, 4
        let point5 = CGPoint(x: rect.midX, y: rect.maxY - rect.height * 0.1875)
        let point6 = CGPoint(x: rect.maxX - rect.width * 0.25, y: rect.maxY - rect.height * 0.0625)
        let point7 = CGPoint(x: rect.maxX, y: rect.maxY - rect.height * 0.625)
        let point8 = CGPoint(x: rect.maxX - rect.width * 0.225, y: rect.maxY - rect.height * 0.875)
        
        
        let controlPoint1A = CGPoint(x: rect.minX + rect.width * 0.4375, y: rect.minY + rect.height * 0.125)
        let controlPoint1B = CGPoint(x: rect.minX + rect.width * 0.5625, y: rect.minY + rect.height * 0.25)
        let controlPoint2A = CGPoint(x: rect.minX + rect.width * 0.1625, y: rect.minY + rect.height * 0.0625)
        let controlPoint2B = CGPoint(x: rect.minX + rect.width * 0.35, y: rect.minY + rect.height * 0.0625)
        let controlPoint3A = CGPoint(x: rect.minX, y: rect.minY + rect.height * 1.0375)
        let controlPoint3B = CGPoint(x: rect.minX, y: rect.minY + rect.height * 0.2125)
        let controlPoint4A = CGPoint(x: rect.minX + rect.width * 0.3375, y: rect.minY + rect.height * 0.7125)
        let controlPoint4B = CGPoint(x: rect.minX + rect.width * 0.1125, y: rect.minY + rect.height * 1.0375)
        
        // Mirror 1, 2, 3, 4
        let controlPoint5A = CGPoint(x: rect.maxX - rect.width * 0.4375, y: rect.maxY - rect.height * 0.125)
        let controlPoint5B = CGPoint(x: rect.maxX - rect.width * 0.5625, y: rect.maxY - rect.height * 0.25)
        let controlPoint6A = CGPoint(x: rect.maxX - rect.width * 0.1625, y: rect.maxY - rect.height * 0.0625)
        let controlPoint6B = CGPoint(x: rect.maxX - rect.width * 0.35, y: rect.maxY - rect.height * 0.0625)
        let controlPoint7A = CGPoint(x: rect.maxX, y: rect.maxY - rect.height * 1.0375)
        let controlPoint7B = CGPoint(x: rect.maxX, y: rect.maxY - rect.height * 0.2125)
        let controlPoint8A = CGPoint(x: rect.maxX - rect.width * 0.3375, y: rect.maxY - rect.height * 0.7125)
        let controlPoint8B = CGPoint(x: rect.maxX - rect.width * 0.1125, y: rect.maxY - rect.height * 1.0375)
        
        var path = Path()
        path.move(to: point1)
        path.addCurve(to: point2, control1: controlPoint1A, control2: controlPoint2B)
        path.addCurve(to: point3, control1: controlPoint2A, control2: controlPoint3B)
        path.addCurve(to: point4, control1: controlPoint3A, control2: controlPoint4B)
        path.addCurve(to: point5, control1: controlPoint4A, control2: controlPoint5B)
        path.addCurve(to: point6, control1: controlPoint5A, control2: controlPoint6B)
        path.addCurve(to: point7, control1: controlPoint6A, control2: controlPoint7B)
        path.addCurve(to: point8, control1: controlPoint7A, control2: controlPoint8B)
        path.addCurve(to: point1, control1: controlPoint8A, control2: controlPoint1B)
        return path
    }
    
}

struct Squiggle_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3)
            Squiggle()
                .aspectRatio(2, contentMode: .fit)
        }
        .foregroundColor(.blue)
        .aspectRatio(10 / 16, contentMode: .fit)
        .padding(.all, 10)
    }
}
