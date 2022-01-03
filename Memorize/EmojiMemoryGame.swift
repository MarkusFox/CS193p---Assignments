//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Markus Fox on 01.01.22.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    private(set) var activeTheme: Theme
    private var themes: Array<Theme>
    @Published private var model: MemoryGame<String>
    
    init() {
        self.themes = [
            Theme(name: "Vehicles", emojis: ["🏎", "🚒", "🚕", "🚑", "🏍", "🛴", "🚲", "🛵", "🦼", "🚜"], numberOfPairs: 70, color: "gray"),
            Theme(name: "Animals", emojis: ["🐒", "🦆", "🦅", "🦉", "🦇", "🐺", "🐗", "🐴", "🐝", "🐛", "🐌", "🐢", "🦂", "🕷", "🦀", "🦐", "🐟", "🐳", "🦈", "🦭", "🐆", "🦍", "🐑", "🐕", "🐓"], numberOfPairs: 7, color: "green"),
            Theme(name: "Hearts", emojis: ["❤️", "🧡", "💛", "💚", "🤍", "🖤", "💜", "💙", "🤎", "❤️‍🔥", "💔"], numberOfPairs: 5, color: "red"),
            Theme(name: "Flags", emojis: ["🇩🇿", "🇪🇬", "🇦🇷", "🇧🇦", "🇧🇬", "🇩🇰", "🇯🇲", "🇮🇸", "🇶🇦", "🇨🇦", "🇦🇹", "🇷🇺"], numberOfPairs: 8, color: "gray"),
            Theme(name: "Sport", emojis: ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🎱"], numberOfPairs: 6, color: "green"),
            Theme(name: "Smilies", emojis: ["😆", "😂", "😇", "🥰", "😎", "🥳", "😭", "🤬"], numberOfPairs: 30, color: "red")
        ]
        self.activeTheme = self.themes.randomElement()!
        self.model = EmojiMemoryGame.createMemoryGame(theme: activeTheme)
    }
    
    class Theme {
        init(name: String, emojis: Array<String>, numberOfPairs: Int, color: String) {
            self.name = name
            self.emojis = emojis
            self.numberOfPairs = numberOfPairs
            self.color = color
        }
        
        var name: String
        var emojis: Array<String>
        var numberOfPairs: Int
        var color: String
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
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    // MARK: - Intents
    func choose(_ card: MemoryGame<String>.Card) {
//        objectWillChange.send()
        model.choose(card)
    }
    
    func addTheme(theme: Theme) {
        self.themes.append(theme)
    }
    
    func newGame() {
        let newTheme = self.themes.randomElement()!
        self.activeTheme = newTheme
        model = EmojiMemoryGame.createMemoryGame(theme: newTheme)
    }
}
