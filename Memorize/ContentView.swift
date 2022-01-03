//
//  ContentView.swift
//  Memorize
//
//  Created by Markus Fox on 30.12.21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    @State var emojiCount: Int = 10
    
    var body: some View {
        VStack {
            HStack {
                Text("Memorize \(viewModel.activeTheme.name)")
                Spacer()
                Button(action: {
                    viewModel.newGame()
                }, label: {
                    Image(systemName: "shuffle")
                })
            }.font(.title2)
            Spacer()
            Text("Score: \(viewModel.score)")
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: widthThatBestFits(cardCount: emojiCount)))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }.foregroundColor(.purple) // default will get passed to all inside Stack
            }
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
    
//    var vehicles: some View {
//        Button(action: {
//            selectedTheme = "vehicles"
//            emojiCount = Int.random(in: 4...emojis[selectedTheme]!.count-1)
//        }, label: {
//            VStack {
//                Image(systemName: "car")
//                Text("Vehicles").font(.footnote)
//            }
//        })
//    }
//
//    var animals: some View {
//        Button(action: {
//            selectedTheme = "animals"
//            emojiCount = Int.random(in: 4...emojis[selectedTheme]!.count-1)
//        }, label: {
//            VStack {
//                Image(systemName: "hare")
//                Text("Animals").font(.footnote)
//            }
//        })
//    }
//
//    var hearts: some View {
//        Button(action: {
//            selectedTheme = "hearts"
//            emojiCount = Int.random(in: 4...emojis[selectedTheme]!.count-1)
//        }, label: {
//            VStack {
//                Image(systemName: "heart")
//                Text("Hearts").font(.footnote)
//            }
//        })
//    }
    
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack(content: {
            let shape = RoundedRectangle(cornerRadius: 20.0)
            if card.isFaceUp {
                shape.strokeBorder(lineWidth: 3)
                shape.fill().foregroundColor(.white)
                Text(card.content).font(.largeTitle)//.foregroundColor(.orange)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
.previewInterfaceOrientation(.portraitUpsideDown)
//        ContentView()
//            .preferredColorScheme(.light)
    }
}
