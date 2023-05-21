//
//  Game.swift
//  Hilo
//
//  Created by Yaroslav Sedyshev on 18.05.2023.
//

protocol Playable {
    var deck: Deck { get }
    var pot: Int { get set }
    var players: [Player] { get }
    var round: Int { get set }
    
    mutating func play()
}

struct Game: Playable {
    var deck: Deck
    var pot: Int = 0
    var players: [Player]
    var round: Int = 0
    
    mutating func play() {
        while players.haveFunds && players.count > 1 {
            deck = Deck()
            round += 1
            makeStakes(by: 25)
            
            print(Strings.roundIntro.format(round))
            print(fundsDescription())
            print(Strings.potStatusText.format(pot))
            print()
            
            var previousCard: Card?
            
            while let dealtCard = deck.pop(), let nextCard = deck.next() {
                if dealtCard == nextCard  {
                    skipTurn(dealtCard: dealtCard, nextCard: nextCard)
                } else {
                    playTurn(dealtCard: dealtCard, previousCard: &previousCard, nextCard: nextCard)
                }
            }
        }
    }
    
    mutating private func makeStakes(by amount: Int) {
        for (index, _) in players.enumerated() {
            players[index].funds -= amount
            pot += amount
        }
    }
}
