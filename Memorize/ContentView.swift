//
//  ContentView.swift
//  Memorize
//
//  Created by Markus Fox on 30.12.21.
//

import SwiftUI

struct ContentView: View {
    var emojis: Dictionary = [
        "vehicles": ["🏎", "🚒", "🚕", "🚑", "🏍", "🛴", "🚲", "🛵", "🦼", "🚜"],
        "animals": ["🐒", "🦆", "🦅", "🦉", "🦇", "🐺", "🐗", "🐴", "🐝", "🐛", "🐌", "🐢", "🦂", "🕷", "🦀", "🦐", "🐟", "🐳", "🦈", "🦭", "🐆", "🦍", "🐑", "🐕", "🐓"],
        "hearts": ["❤️", "🧡", "💛", "💚", "🤍", "🖤", "💜", "💙", "🤎", "❤️‍🔥", "💔"]
    ]
    
    @State var selectedTheme: String = "vehicles"
    @State var emojiCount: Int = 10
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.title)
            Spacer()
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: widthThatBestFits(cardCount: emojiCount)))]) {
                    ForEach(emojis[selectedTheme]!.shuffled()[0..<emojiCount], id: \.self, content: { emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    })
                }.foregroundColor(.purple) // default will get passed to all inside Stack
            }
            Spacer()
            HStack {
                vehicles
                Spacer()
                animals
                Spacer()
                hearts
            }
            .font(.largeTitle)
            .padding(.horizontal, 30.0)
        }
            .padding(.all)
    }
    
    func widthThatBestFits(cardCount: Int) -> CGFloat {
        if cardCount <= 9 {
            return 80.0
        } else if cardCount > 16 {
            return 50.0
        } else {
            return 60.0
        }
    }
    
    var vehicles: some View {
        Button(action: {
            selectedTheme = "vehicles"
            emojiCount = Int.random(in: 4...emojis[selectedTheme]!.count-1)
        }, label: {
            VStack {
                Image(systemName: "car")
                Text("Vehicles").font(.footnote)
            }
        })
    }
    
    var animals: some View {
        Button(action: {
            selectedTheme = "animals"
            emojiCount = Int.random(in: 4...emojis[selectedTheme]!.count-1)
        }, label: {
            VStack {
                Image(systemName: "hare")
                Text("Animals").font(.footnote)
            }
        })
    }
    
    var hearts: some View {
        Button(action: {
            selectedTheme = "hearts"
            emojiCount = Int.random(in: 4...emojis[selectedTheme]!.count-1)
        }, label: {
            VStack {
                Image(systemName: "heart")
                Text("Hearts").font(.footnote)
            }
        })
    }
    
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true // init overwrites this default
    
    var body: some View {
        ZStack(content: {
            let shape = RoundedRectangle(cornerRadius: 20.0)
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
