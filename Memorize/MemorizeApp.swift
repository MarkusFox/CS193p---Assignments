//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Markus Fox on 30.12.21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
