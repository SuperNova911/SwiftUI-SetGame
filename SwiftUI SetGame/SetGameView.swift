//
//  SetGameView.swift
//  SwiftSetGame
//
//  Created by 김수환 on 2020/08/02.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var gameViewModel: SetGameViewModel
    
    var body: some View {
        GeometryReader { geometry in
            body(for: geometry.size)
        }
    }
    
    private func body(for size: CGSize) -> some View {
        NavigationView {
            VStack {
                Grid(gameViewModel.cards, desiredAspectRatio: cardAspectRatio) { card in
                    CardView(card: card)
                        .aspectRatio(cardAspectRatio , contentMode: .fit)
                        .padding(cardPadding)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                gameViewModel.chooseCard(card: card)
                            }
                        }
                        .transition(AnyTransition.offset(randomOffset(for: size)).combined(with: .scale(scale: 2)))
                }
                
                Button(action: {
                    withAnimation(.easeInOut(duration: flyingDuration)) { gameViewModel.dealMoreCard() }
                }, label: {
                    Text("Deal 3 More Cards").font(.title)
                })
                .disabled(gameViewModel.isDeckEmpty)
            }
            .padding()
            .onAppear { withAnimation(.easeInOut(duration: flyingDuration)) { gameViewModel.startNewGame() }}
            .navigationBarTitle("Set Game", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: { withAnimation(.easeInOut(duration: flyingDuration)) { gameViewModel.startNewGame() }}, label: { Text("New Game") }))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func randomOffset(for size: CGSize) -> CGSize {
        let centerX = size.width / 2
        let centerY = size.height / 2
        let radius = max(size.width, size.height) * 1.5
        let angle = CGFloat.random(in: 0..<360)
        
        let x = centerX + cos(angle * CGFloat.pi / 180) * radius
        let y = centerY + sin(angle * CGFloat.pi / 180) * radius
        return CGSize(width: x, height: y)
    }
    
    // MARK: - Drawing Constants
    
    private let cardAspectRatio: CGFloat = 10 / 16
    private let cardPadding: CGFloat = 10
    private let flyingDuration: Double = 1
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let gameViewModel = SetGameViewModel()
        SetGameView(gameViewModel: gameViewModel)
    }
}
