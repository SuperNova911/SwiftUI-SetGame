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
            shapeView()
                .padding(shapeViewPadding)
                .foregroundColor(shapeColor)
                .transition(.scale(scale: 2))
        }
    }
    
    private func shapeView() -> some View {
        VStack(spacing: shapeSpacing) {
            ForEach(0..<card.numberOfShapes) { _ in
                ZStack {
                    switch card.shape {
                        case .Diamond:
                            Diamond().opacity(shapeOpacity)
                            Diamond().stroke(lineWidth: shapeEdgeWidth)
                        case .Squiggle:
                            Rectangle().opacity(shapeOpacity)
                            Rectangle().stroke(lineWidth: shapeEdgeWidth)
                        case .Oval:
                            Capsule().opacity(shapeOpacity)
                            Capsule().stroke(lineWidth: shapeEdgeWidth)
                    }
                }
                .aspectRatio(shapeAspectRatio, contentMode: .fit)
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
