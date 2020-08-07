//
//  Diamond.swift
//  SwiftSetGame
//
//  Created by 김수환 on 2020/08/05.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        let top = CGPoint(x: rect.midX, y: rect.minY)
        let right = CGPoint(x: rect.maxX, y: rect.midY)
        let bottom = CGPoint(x: rect.midX, y: rect.maxY)
        let left = CGPoint(x: rect.minX, y: rect.midY)
        
        var path = Path()
        path.move(to: top)
        path.addLine(to: right)
        path.addLine(to: bottom)
        path.addLine(to: left)
        path.addLine(to: top)
        path.addLine(to: right)    // 시작점이 끊어져 보이는 문제 방지
        return path
    }
}
