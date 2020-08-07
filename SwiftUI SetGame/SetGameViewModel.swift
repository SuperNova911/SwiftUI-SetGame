//
//  SetGameViewModel.swift
//  SwiftSetGame
//
//  Created by 김수환 on 2020/08/02.
//

import Foundation

class SetGameViewModel: ObservableObject {
    @Published private var game: SetGame = SetGame()
    
    var cards: Array<SetGame.Card> {
        game.cards
    }
    
    var isDeckEmpty: Bool {
        game.isDeckEmpty
    }
    
    
    // MARK: - Indents
    
    func startNewGame() {
        game.startNewGame()
    }
    
    func chooseCard(card: SetGame.Card) {
        game.chooseCard(card: card)
    }
    
    func dealMoreCard() {
        game.dealMoreCard(3)
    }
}
