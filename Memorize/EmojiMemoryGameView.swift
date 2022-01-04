//
//  ContentView.swift
//  Memorize
//
//  Created by Markus Fox on 30.12.21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    @State private var emojiCount: Int = 10
    
    var body: some View {
        VStack {
            HStack {
                Text("Memorize \(game.activeTheme.name)")
                Spacer()
                Button(action: {
                    game.newGame()
                }, label: {
                    Image(systemName: "shuffle")
                })
            }.font(.title2)
            Spacer()
            Text("Score: \(game.score)")
            AspectVGrid(items: game.cards, aspectRatio: 2/3, content: { card in
                CardView(card: card)
                    .padding(4)
                    .onTapGesture {
                        game.choose(card)
                    }
            })
            .foregroundStyle(
                LinearGradient(
                    colors: [game.activeTheme.color, .gray],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
        }
        .padding(.all)
    }
}

struct CardView: View {
    let card: EmojiMemoryGame.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(content: {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Pie(startAngle: Angle(degrees: 270), endAngle: Angle(degrees: 30)).padding(5).opacity(0.5)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill()
                }
            })
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width * DrawingConstants.fontScale, size.height * DrawingConstants.fontScale))
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 2
        static let fontScale: CGFloat = 0.65
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
.previewInterfaceOrientation(.portraitUpsideDown)
//        return EmojiMemoryGameView(game: game)
//            .preferredColorScheme(.light)
    }
}
