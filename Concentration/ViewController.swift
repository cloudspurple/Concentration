//
//  ViewController.swift
//  Concentration
//
//  Created by user on 9/5/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var game = Concentration(pairsOfCards: (cardButtons.count + 1) / 2)
    var emojis = ["👻", "🎃", "👁", "🧠", "🕸", "🗝"].shuffled()
    var emoji: [Int: String] = [:]
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
        updateViewFromModel()
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            let card = game.chooseCard(at: cardNumber)
            
            if !card.isFaceUp, !card.isMatched {
                emoji[card.identifier] = emojis[card.identifier]
                
                switch card.isFaceUp {
                case true:
                    card.isFaceUp = false
                case false:
                    card.isFaceUp = true
                }
                
                if card.isFaceUp {
                    sender.setTitle(emoji[card.identifier], for: UIControl.State.normal)
                    sender.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    game.flippedCardsIndexes.append(cardNumber)
                }
                
                flipCount += 1
            }
        }
        
        if game.matchedCards.count == 12 {
            game.resetGame()
            resetUi()
        }
    }
    
    @IBAction func touchNewGameButton(_ sender: UIButton) {
        game.resetGame()
        resetUi()
    }
    
    
    func updateViewFromModel() {
        if game.flippedCardsIndexes.count == 2 {
            let card1 = game.cards[game.flippedCardsIndexes[0]]
            let card2 = game.cards[game.flippedCardsIndexes[1]]
            
            
            if card1.identifier == card2.identifier {
                game.cards[game.flippedCardsIndexes[0]].isMatched = true
                game.cards[game.flippedCardsIndexes[1]].isMatched = true
                game.cards[game.flippedCardsIndexes[1]].isFaceUp = false
                game.cards[game.flippedCardsIndexes[1]].isFaceUp = false
                game.matchedCards.append(card1)
                game.matchedCards.append(card2)
                cardButtons[game.flippedCardsIndexes[0]].setTitle("", for: UIControl.State.normal)
                cardButtons[game.flippedCardsIndexes[1]].setTitle("", for: UIControl.State.normal)
                cardButtons[game.flippedCardsIndexes[0]].backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                cardButtons[game.flippedCardsIndexes[1]].backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                game.flippedCardsIndexes = []
            } else {
                cardButtons[game.flippedCardsIndexes[0]].setTitle("", for: UIControl.State.normal)
                cardButtons[game.flippedCardsIndexes[1]].setTitle("", for: UIControl.State.normal)
                cardButtons[game.flippedCardsIndexes[0]].backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                cardButtons[game.flippedCardsIndexes[1]].backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                game.cards[game.flippedCardsIndexes[0]].isFaceUp = false
                game.cards[game.flippedCardsIndexes[1]].isFaceUp = false
                game.flippedCardsIndexes = []
            }
        }
    }
    
    func resetUi() {
        for button in cardButtons {
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        }
        flipCount = 0
    }
}




