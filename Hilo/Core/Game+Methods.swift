//
//  GamePrivate.swift
//  Hilo
//
//  Created by Yaroslav Sedyshev on 21.05.2023.
//

import Foundation

extension Game {
    var fundsDescription: String {
        var description: String = ""
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        formatter.locale = Locale(identifier: "en_US")
        
        for player in players {
            let fundsString = formatter.string(from: NSNumber(value: player.funds))!
            description += "[ " + player.name + ": " + fundsString + " ]"
        }
        
        return description
    }
    
    mutating func setupRound() {
        deck = Deck()
        round += 1
        makeStakes(by: stakeAmount)
        
        Thread.sleep(forTimeInterval: 1.0)
        
        print()
        print(Strings.roundIntro.format(round))
        print()
        print(Strings.makingStakes)
        print(fundsDescription)
        print(Strings.potStatusText.format(pot))
        print()
        
        Thread.sleep(forTimeInterval: 1.0)
    }
    
    mutating func playTurn(dealtCard: Card, previousCard: inout Card?, nextCard: Card) -> Bool {
        print(Strings.dealtCard.format(dealtCard.description, higherOrLowerSign(previousCard, dealtCard), deck.cards.count))
        
        let guesses = players.makeGuesses(by: dealtCard)
        let losers = players.getLosers(by: guesses, dealtCard: dealtCard, nextCard: nextCard)
        let winningIndices = guesses.rightGuessIndices(dealtCard: dealtCard, nextCard: nextCard)
        
        // Print the next card if someone's lost
        if losers.count > 0 {
            print()
            print(Strings.nextCard.format(nextCard.description, higherOrLowerSign(dealtCard, nextCard)))
        }
        
        // It's a tie!
        if losers.count == players.count {
            for (index, _) in players.enumerated() {
                players[index].funds += pot / players.count
            }
            
            pot = 0
            print(Strings.tie)
            Thread.sleep(forTimeInterval: 0.5)
            return false
        }
        
        // We have winners!
        if losers.count >= 1 {
            for index in winningIndices {
                print(Strings.winner.format(players[index].name))
                players[index].funds += pot / (players.count - losers.count)
            }
            
            pot = 0
            Thread.sleep(forTimeInterval: 0.5)
            return false
        }
  
        previousCard = dealtCard
        print()
        
        return true
    }
    
    func skipTurn(dealtCard: Card, nextCard: Card) {
        print(Strings.dealtCard.format(dealtCard.description, "", deck.cards.count) + Strings.skip)
    }
    
    mutating func makeStakes(by amount: Int) {
        for (index, _) in players.enumerated() {
            players[index].funds -= amount
            pot += amount
        }
    }
    
    func announceWinners() {
        var winnersText: String = ""
        let winners = players.filter { $0.funds > 0 }.sorted(by: { $0.funds > $1.funds })
        
        for (index, winner) in winners.enumerated() {
            winnersText += winner.name + ": $" + String(winner.funds)
            
            if index != winners.count - 1 {
                winnersText += ", "
            } else {
                winnersText += "."
            }
        }
        
        print()
        print(Strings.gameOver.format(round, winnersText))
        print()
    }
}
