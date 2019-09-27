//
//  Concentration.swift
//  Concentration
//
//  Created by user on 9/10/19.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation

final class Concentration {
    var cards: [Card] = []
    var pairsOfCards = 0
    var flippedCardsIndexes: [Int] = []
    var matchedCards: [Card] = []
    
    init(pairsOfCards: Int) {
        self.pairsOfCards = pairsOfCards
        for identifier in 0..<pairsOfCards {
            let card1 = Card(identifier: identifier)
            let card2 = Card(identifier: identifier)
            cards.append(card1)
            cards.append(card2)
            cards.shuffle()
        }
    }
    
    func chooseCard(at location: Int) -> Card {
        return cards[location]
    }
    
    func resetGame() {
        for card in cards {
            card.isFaceUp = false
            card.isMatched = false
        }
        flippedCardsIndexes = []
        matchedCards = []
        cards.shuffle()
    }
}

