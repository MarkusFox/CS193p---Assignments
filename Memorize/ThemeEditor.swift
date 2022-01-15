//
//  ThemeEditor.swift
//  Memorize
//
//  Created by Markus Fox on 13.01.22.
//

import SwiftUI

struct ThemeEditor: View {
    @Binding var theme: Theme
    @State var hiddenTrigger = false
    
    // starting from iOS15 we can use DismissAction. There's no more need to use presentationMode.wrappedValue.dismiss().
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Text("Close")
        }
        .padding(.vertical)
        Form {
            nameSection
            removeEmojiSection
            addEmojisSection
            numberOfPairsSection
            colorSection
        }
    }
    
    var nameSection: some View {
        Section(header: Text("Name")) {
            TextField("Name", text: $theme.name)
        }
    }
    
    var numberOfPairsSection: some View {
        Section(header: Text("Card count")) {
            Stepper(value: $theme.numberOfPairs, in: 0...theme.emojis.count) {
                Text("\(theme.numberOfPairs) pairs")
            }
        }
    }
    
    var colorSection: some View {
        Section(header: Text("Color")) {
            ColorPicker("Theme Color", selection: $theme.color)
        }
    }
    
    var removeEmojiSection: some View {
        Section(header: Text("Emojis"), footer: Text("Tap emoji to remove")) {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
                ForEach(theme.emojis, id: \.self) { emoji in
                    Text(emoji)
                        .onTapGesture {
                            withAnimation {
                                theme.emojis.removeAll(where: { String($0) == emoji })
                                self.hiddenTrigger.toggle()
                            }
                        }
                }
            }
            .font(.system(size: 40))
        }
    }
    
    @State private var emojisToAdd = ""
    
    var addEmojisSection: some View {
        Section(header: Text("Add Emojis")) {
            TextField("", text: $emojisToAdd)
                .onChange(of: emojisToAdd) { emojis in
                    addEmojis(emojis)
                    self.hiddenTrigger.toggle()
                }
                .onSubmit {
                    emojisToAdd = ""
                    self.hiddenTrigger.toggle()
                }
        }
    }
    
    func addEmojis(_ emojis: String) {
        withAnimation {
            for emoji in emojis {
                if !theme.emojis.contains(String(emoji)),
                   emoji.isEmoji
                {
                    theme.emojis.append(String(emoji))
                }
            }
        }
    }
}

