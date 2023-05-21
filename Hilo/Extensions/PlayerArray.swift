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
}
