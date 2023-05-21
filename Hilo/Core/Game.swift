//
//  Game.swift
//  Hilo
//
//  Created by Yaroslav Sedyshev on 18.05.2023.
//

import Foundation

protocol Playable {
    var deck: Deck { get }
    var pot: Int { get set }
    var players: [Player] { get }
    var round: Int { get set }
    
    func intro()
    mutating func play()
}

struct Game: Playable {
    var deck: Deck
    var pot: Int = 0
    var players: [Player]
    var round: Int = 0
    
    init(deck: Deck, players: [Player]) {
        self.deck = deck
        self.players = players
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
                    if !playTurn(dealtCard: dealtCard, previousCard: &previousCard, nextCard: nextCard) {
                        break
                    }
                }
            }
        } while players.haveFunds
    }
}

private extension Game {
    mutating func setupRound() {
        deck = Deck()
        round += 1
        makeStakes(by: 25)
        
        Thread.sleep(forTimeInterval: 2.0)
        
        print()
        print(Strings.roundIntro.format(round))
        print()
        print(Strings.makingStakes)
        print(fundsDescription())
        print(Strings.potStatusText.format(pot))
        print()
        
        Thread.sleep(forTimeInterval: 1.0)
    }
    
    mutating func playTurn(dealtCard: Card, previousCard: inout Card?, nextCard: Card) -> Bool {
        let highOrLow = higherOrLowerSign(previousCard, dealtCard)
        print(Strings.dealtCard.format(dealtCard.description, highOrLow, deck.cards.count))
        
        let guesses = players.makeGuesses(by: dealtCard)
        let losers = players.getLosers(by: guesses, dealtCard: dealtCard, nextCard: nextCard)
        let winners = players.getWinners(by: guesses, dealtCard: dealtCard, nextCard: nextCard)
        let winningIndices = guesses.rightGuessIndices(dealtCard: dealtCard, nextCard: nextCard)
        
        // Print the next card if someone's lost
        if losers.count > 0 {
            print(Strings.nextCard.format(nextCard.description, higherOrLowerSign(dealtCard, nextCard)))
        }
        
        // It's a tie!
        if losers.count == players.count {
            for (index, _) in players.enumerated() {
                players[index].funds += pot / players.count
            }
            
            pot = 0
            print(Strings.tie)
            return false
        }
        
        // We have winners!
        if losers.count >= 1 {
            for index in winningIndices {
                print(Strings.winner.format(players[index].name))
                players[index].funds += pot / winners.count
            }
            
            pot = 0
            return false
        }
  
        previousCard = dealtCard
        print()
        
        return true
    }
    
    func skipTurn(dealtCard: Card, nextCard: Card) {
        print(Strings.dealtCard.format(dealtCard.description, "", deck.cards.count) + Strings.skip)
    }
    
    func fundsDescription() -> String {
        var description: String = ""
        
        for player in players {
            description += "[ " + player.name + ": $" + String(player.funds) + " ]"
        }
        
        return description
    }
    
    mutating func makeStakes(by amount: Int) {
        for (index, _) in players.enumerated() {
            players[index].funds -= amount
            pot += amount
        }
    }
}
