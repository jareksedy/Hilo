//
//  Game+Helpers.swift
//  Hilo
//
//  Created by Yaroslav Sedyshev on 21.05.2023.
//

extension Game {
    func playTurn(dealtCard: Card, previousCard: inout Card?, nextCard: Card) {
        let higherOrLowerSign = higherOrLowerSign(previousCard, dealtCard)
        print(Strings.dealtCard.format(dealtCard.description, higherOrLowerSign, deck.cards.count))
        let guesses = players.makeGuesses(by: dealtCard)
        
        previousCard = dealtCard
        print()
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
}

private extension Game {
    func higherOrLowerSign(_ previousCard: Card?, _ nextCard: Card) -> String {
        guard let previousCard = previousCard else {
            return ""
        }
        
        if previousCard > nextCard {
            return "[ ↓ ]"
        } else {
            return "[ ↑ ]"
        }
    }
}
