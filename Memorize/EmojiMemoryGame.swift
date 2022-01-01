//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Markus Fox on 01.01.22.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    static let emojis: Dictionary = [
        "vehicles": ["🏎", "🚒", "🚕", "🚑", "🏍", "🛴", "🚲", "🛵", "🦼", "🚜"],
        "animals": ["🐒", "🦆", "🦅", "🦉", "🦇", "🐺", "🐗", "🐴", "🐝", "🐛", "🐌", "🐢", "🦂", "🕷", "🦀", "🦐", "🐟", "🐳", "🦈", "🦭", "🐆", "🦍", "🐑", "🐕", "🐓"],
        "hearts": ["❤️", "🧡", "💛", "💚", "🤍", "🖤", "💜", "💙", "🤎", "❤️‍🔥", "💔"]
    ]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in
            emojis["vehicles"]![pairIndex]
        }
    }
        
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    func choose(_ card: MemoryGame<String>.Card) {
//        objectWillChange.send()
        model.choose(card)
    }
}
