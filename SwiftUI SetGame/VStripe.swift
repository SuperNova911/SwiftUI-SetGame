//
//  VStripe.swift
//  SwiftUI SetGame
//
//  Created by 김수환 on 2020/08/16.
//

import SwiftUI

// 수직으로 정렬된 줄무늬 모양
struct VStripe: Shape {
    // 줄무늬에 그려지는 선의 개수
    let numberOfLine: Int
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        for i in 0..<numberOfLine {
            let xPos = rect.minX + rect.width * (CGFloat(i) / CGFloat(numberOfLine - 1))
            path.move(to: CGPoint(x: xPos, y: rect.minY))
            path.addLine(to: CGPoint(x: xPos, y: rect.maxY))
        }
        return path
    }
}

struct VStripe_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            VStripe(numberOfLine: 15)
                .stroke(lineWidth: 5)
        }
    }
}
