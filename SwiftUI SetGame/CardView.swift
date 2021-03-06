//
//  CardView.swift
//  SwiftUI-SetGame
//
//  Created by 김수환 on 2020/08/07.
//

import SwiftUI

struct CardView: View {
    var card: SetGame.Card
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cardCornerRadius).fill(cardBaseColor)
            RoundedRectangle(cornerRadius: cardCornerRadius).fill(cardHighlightColor).opacity(cardHighlightOpacity)
            RoundedRectangle(cornerRadius: cardCornerRadius).stroke(lineWidth: cardEdgeWidth).foregroundColor(cardEdgeColor)
            
            VStack(spacing: shapeSpacing) {
                ForEach(0..<card.numberOfShapes.rawValue) { _ in
                    shapeBody()
                        .aspectRatio(shapeAspectRatio, contentMode: .fit)
                }
            }
            .padding(shapeViewPadding)
            .foregroundColor(shapeColor)
        }
    }
    
    // 카드의 모양과 음영에 맞는 뷰 생성
    private func shapeBody() -> some View {
        ZStack {
            switch card.shape {
                case .Diamond:
                    Diamond().shading(card.shading)
                    Diamond().stroke(lineWidth: shapeEdgeWidth)
                case .Squiggle:
                    Squiggle().shading(card.shading)
                    Squiggle().stroke(lineWidth: shapeEdgeWidth)
                case .Oval:
                    Capsule().shading(card.shading)
                    Capsule().stroke(lineWidth: shapeEdgeWidth)
            }
        }
    }
    
    // MARK: - Drawing variables
    
    private let cardCornerRadius: CGFloat = 10
    private let cardBaseColor: Color = .white
    private let cardHighlightOpacity: Double = 0.2
    private let cardEdgeWidth: CGFloat = 3
    private let shapeViewPadding: CGFloat = 15
    private let shapeSpacing: CGFloat = 15
    private let shapeEdgeWidth: CGFloat = 4
    private let shapeAspectRatio: CGFloat = 2
    
    private var cardHighlightColor: Color {
        switch card.isMatch {
            case .Match:
                return .green
            case .NotMatch:
                return .red
            case .Undetermined:
                return card.isSelected ? .blue : .white
        }
    }
    
    private var cardEdgeColor: Color {
        switch card.isMatch {
            case .Match:
                return .green
            case .NotMatch:
                return .red
            case .Undetermined:
                return card.isSelected ? .blue : .black
        }
    }
    
    private var shapeColor: Color {
        switch card.color {
            case .Red:
                return Color.red
            case .Green:
                return Color.green
            case .Purple:
                return Color.purple
        }
    }
    
    private var shapeOpacity: Double {
        switch card.shading {
            case .Solid:
                return 1
            case .Striped:
                return 0.3
            case .Open:
                return 0
        }
    }
    
}
