//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Markus Fox on 30.12.21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var themeStore = ThemeStore(named: "Emojis")
    
    var body: some Scene {
        WindowGroup {
            ThemeChooser()
                .environmentObject(themeStore)
        }
    }
}
