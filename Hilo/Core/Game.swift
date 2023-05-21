//
//  Game.swift
//  Hilo
//
//  Created by Yaroslav Sedyshev on 18.05.2023.
//

protocol Playable {
    var deck: Deck { get }
    var pot: Int { get }
    var players: [Player] { get }
    var round: Int { get }
    var stakeAmount: Int { get }
    
    func intro()
    mutating func play()
}

struct Game: Playable {
    var deck: Deck
    var pot: Int = 0
    var players: [Player]
    var round: Int = 0
    var stakeAmount: Int
    
    init(deck: Deck, stakeAmount: Int = 25, players: [Player]) {
        self.deck = deck
        self.players = players
        self.stakeAmount = stakeAmount
    }
    
    func intro() {
        print(Strings.gameIntro)
        print()
    }
    
    mutating func play() {
        repeat {
            var previousCard: Card?
            setupRound()
            
            while let dealtCard = deck.pop(), let nextCard = deck.next() {
                if dealtCard == nextCard  {
                    skipTurn(dealtCard: dealtCard, nextCard: nextCard)
                } else {
                    if !playTurn(dealtCard: dealtCard, previousCard: &previousCard, nextCard: nextCard) { break }
                }
            }
        } while players.haveFunds
        
        announceWinners()
    }
}
