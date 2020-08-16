//
//  Shading.swift
//  SwiftUI SetGame
//
//  Created by 김수환 on 2020/08/16.
//

import SwiftUI

struct Shading: ViewModifier {
    let shading: SetGame.Card.Shading
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            switch shading {
                case .Solid:
                    content.opacity(1)
                case .Striped:
                    // 줄무늬 두께를 계산
                    let lineWidth = geometry.size.width / CGFloat(numberOfLine - 1) * stripeFillRatio
                    VStripe(numberOfLine: numberOfLine)
                        .stroke(lineWidth: lineWidth)
                        .mask(content)
                case .Open:
                    content.opacity(0)
            }
        }
    }
    
    // MARK: - Drawing Variables
    let numberOfLine = 15   // 줄무늬 수
    let stripeFillRatio: CGFloat = 0.4      // 줄무늬가 배경에서 차지하는 비율
}

extension View {
    func shading(_ shading: SetGame.Card.Shading) -> some View {
        self.modifier(Shading(shading: shading))
    }
}

// Preview
struct Shading_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ZStack {
                Diamond().shading(.Open)
                Diamond().stroke(lineWidth: 5)
            }
            .foregroundColor(.green)
            .aspectRatio(2, contentMode: .fit)
            ZStack {
                Squiggle().shading(.Striped)
                Squiggle().stroke(lineWidth: 5)
            }
            .foregroundColor(.purple)
            .aspectRatio(2, contentMode: .fit)
            ZStack {
                Capsule().shading(.Solid)
                Capsule().stroke(lineWidth: 5)
            }
            .foregroundColor(.red)
            .aspectRatio(2, contentMode: .fit)
        }
        .aspectRatio(10 / 16, contentMode: .fit)
        .padding(/*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
}
