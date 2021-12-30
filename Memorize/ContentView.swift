//
//  ContentView.swift
//  Memorize
//
//  Created by Markus Fox on 30.12.21.
//

import SwiftUI

struct ContentView: View {
    var emojis: Array<String> = ["🏎", "🚒", "🚕", "🚑", "🏍", "🛴", "🚲", "🛵", "🦼", "🚜"] // or [String]
    @State var emojiCount: Int = 10
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self, content: { emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    })
                }.foregroundColor(.purple) // default will get passed to all inside Stack
            }
            Spacer()
            HStack {
                remove
                Spacer()
                add
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
            .padding(.all)
    }
    
    var remove: some View {
        Button(action: {
            if emojiCount > 1 {
                emojiCount -= 1
            }
        }, label: {
            Image(systemName: "minus.square")
        })
    }
    
    var add: some View {
        Button(action: {
            if emojiCount < emojis.count {
                emojiCount += 1
            }
        }, label: {
            Image(systemName: "plus.square")
        })
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = false // init overwrites this default
    
    var body: some View {
        ZStack(content: {
            let shape = RoundedRectangle(cornerRadius: 22.0)
            if isFaceUp {
                shape.strokeBorder(lineWidth: 3)
                shape.fill().foregroundColor(.white)
                Text(content).font(.largeTitle)//.foregroundColor(.orange)
            } else {
                shape.fill()
            }
        })
            .onTapGesture {
                isFaceUp = !isFaceUp
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
.previewInterfaceOrientation(.portraitUpsideDown)
//        ContentView()
//            .preferredColorScheme(.light)
    }
}
