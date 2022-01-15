//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Markus Fox on 01.01.22.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    @Published var theme: Theme {
        didSet {
            newGame()
        }
    }

    @Published private var model: MemoryGame<String>
    
    init(theme: Theme) {
        self.theme = theme
        self.model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        let shuffledEmojis = theme.emojis.shuffled()
        var numberOfPairsOfCards: Int?
        if theme.numberOfPairs <= theme.emojis.count {
            numberOfPairsOfCards = theme.numberOfPairs
        } else {
            numberOfPairsOfCards = theme.emojis.count
        }
        
        return MemoryGame<String>(numberOfPairsOfCards: numberOfPairsOfCards!) { pairIndex in
            shuffledEmojis[pairIndex]
        }
    }
    
    var cards: Array<Card> {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    // MARK: - Intents
    func choose(_ card: Card) {
//        objectWillChange.send()
        model.choose(card)
    }
    
    func newGame() {
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    func shuffle() {
        model.shuffle()
    }
}
