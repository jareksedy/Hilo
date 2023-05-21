//
//  PlayerArray.swift
//  Hilo
//
//  Created by Yaroslav Sedyshev on 21.05.2023.
//

extension Array where Element == Player {
    var haveFunds: Bool {
        for player in self {
            if player.funds <= 0 { return false }
        }
        
        return true
    }
    
    func makeGuesses(by card: Card) -> [Guess] {
        var guesses = [Guess]()
        
        for player in self {
            guesses.append(player.makeGuess(by: card))
        }
        
        return guesses
    }
    
    func getLosers(by guesses: [Guess], dealtCard: Card, nextCard: Card) -> [Player] {
        var tempStorage = [Element]()
        let wrongIndices = guesses.wrongGuessIndices(dealtCard: dealtCard, nextCard: nextCard)
        
        for index in wrongIndices {
            tempStorage.append(self[index])
        }
        
        return tempStorage
    }
}
