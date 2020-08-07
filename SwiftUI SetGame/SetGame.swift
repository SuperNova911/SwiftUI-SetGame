//
//  SetGame.swift
//  SwiftSetGame
//
//  Created by 김수환 on 2020/08/02.
//

import Foundation

struct SetGame {
    // 카드 덱
    private var deck = Array<Card>()
    // 현재 보여지고 있는 카드
    private(set) var cards = Array<Card>()
    
    var isDeckEmpty: Bool {
        deck.count == 0
    }
    
    private var selectedCards: Array<Card> {
        cards.filter { card in
            card.isSelected
        }
    }
    
    mutating func startNewGame() {
        deck = createDeck().shuffled()
        cards = Array<Card>()
        
        drawCards(12)
    }
    
    mutating func chooseCard(card: Card) {
        // 이미 3장의 카드가 선택된 상태이면, match의 결과에 따라 새 카드로 교체하거나 선택 해제
        let state: SetGame.Card.MatchState = calculateMatchState(of: selectedCards)
        switch state {
            case .Match:
                replace(cards: selectedCards)
            case .NotMatch:
                deselect(cards: selectedCards)
            default:
                break
        }
        
        if let cardIndex = cards.firstIndex(matching: card) {
            // 선택한 카드의 isSelected를 반전
            cards[cardIndex].isSelected = !cards[cardIndex].isSelected
            
            // 선택한 카드들의 match 상태를 업데이트
            let state = calculateMatchState(of: selectedCards)
            changeMatchState(of: selectedCards, to: state)
        }
    }
    
    // 3장의 카드가 선택되어있고 match 상태이면 새 카드로 교체, 이 외의 경우에는 카드를 count만큼 드로우
    mutating func dealMoreCard(_ count: Int) {
        if calculateMatchState(of: selectedCards) == .Match {
            replace(cards: selectedCards)
        } else {
            drawCards(count)
        }
    }
    
    // 개수, 모양, 색깔, 음영이 모두 다른 81장의 카드 덱 생성
    private func createDeck() -> Array<Card> {
        var cards = Array<Card>()
        var id = 0
        for numberOfShapes in 1...3 {
            for shape in Card.Shape.allCases {
                for color in Card.Color.allCases {
                    for shading in Card.Shading.allCases {
                        let card = Card(id: id, numberOfShapes: numberOfShapes, shape: shape, color: color, shading: shading)
                        id += 1
                        cards.append(card)
                    }
                }
            }
        }
        return cards
    }
    
    private mutating func drawCards(_ count: Int) {
        for _ in 0..<count {
            if let card = deck.popLast() {
                cards.append(card)
            } else {
                break
            }
        }
    }
    
    // Match: 3장의 카드의 각 속성이 모두 같거나 달라야 함
    // Undetermined: 카드 3장을 선택하지 않았기 때문에 Match/NotMatch를 결정할 수 없음
    private func calculateMatchState(of cards: Array<Card>) -> Card.MatchState {
        if cards.count != 3 {
            return .Undetermined
        }
        
        // 카드들의 유니크한 요소들이 1개 또는 3개인지 검사 (1개: 모두 같음, 3개: 모두 다름)
        // 모양 개수 종류 확인
        let uniqueNumberOfShapes = Set(cards.map { card in card.numberOfShapes })
        if (uniqueNumberOfShapes.count == 2) {
            return .NotMatch
        }
        
        // 모양 종류 확인
        let uniqueShapes = Set(cards.map { card in card.shape })
        if (uniqueShapes.count == 2) {
            return .NotMatch
        }
        
        // 색깔 종류 확인
        let uniqueColors = Set(cards.map { card in card.color })
        if uniqueColors.count == 2 {
            return .NotMatch
        }
        
        // 음영 종류 확인
        let uniqueShadings = Set(cards.map { card in card.shading })
        if uniqueShadings.count == 2 {
            return .NotMatch
        }
        
        return .Match
    }
    
    // 입력으로 받은 카드들을 버리고, 덱에 카드가 남아있다면 덱에서 새로 뽑은 카드들로 교체함
    private mutating func replace(cards: Array<Card>) {
        for card in cards {
            if let cardIndex = self.cards.firstIndex(matching: card) {
                if let replaceCard = deck.popLast() {
                    self.cards[cardIndex] = replaceCard
                } else {
                    self.cards.remove(at: cardIndex)
                }
            }
        }
    }
    
    private mutating func deselect(cards: Array<Card>) {
        for card in cards {
            if let cardIndex = self.cards.firstIndex(matching: card) {
                self.cards[cardIndex].isSelected = false
                self.cards[cardIndex].isMatch = .Undetermined
            }
        }
    }
    
    private mutating func changeMatchState(of cards: Array<Card>, to state: Card.MatchState) {
        for card in cards {
            if let cardIndex = self.cards.firstIndex(matching: card) {
                self.cards[cardIndex].isMatch = state
            }
        }
    }
    
    struct Card: Identifiable {
        var id: Int
        
        var isSelected: Bool = false
        var isMatch: MatchState = .Undetermined
        
        let numberOfShapes: Int     // 모양 개수
        let shape: Shape            // 모양
        let color: Color            // 색깔
        let shading: Shading        // 음영
        
        enum MatchState {
            case Match, NotMatch, Undetermined
        }
        
        enum Shape: CaseIterable {
            case Diamond, Squiggle, Oval
        }
        enum Color: CaseIterable {
            case Red, Green, Purple
        }
        enum Shading: CaseIterable {
            case Solid, Striped, Open
        }
    }
}
