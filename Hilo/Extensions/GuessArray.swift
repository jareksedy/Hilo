//
//  GuessArray.swift
//  Hilo
//
//  Created by Yaroslav Sedyshev on 21.05.2023.
//

extension Array where Element == Guess {
    func wrongGuessIndices(dealtCard: Card, nextCard: Card) -> [Int] {
        var indices = [Int]()
        
        for (index, guess) in self.enumerated() {
            if (nextCard > dealtCard && guess == .lo) || (nextCard < dealtCard && guess == .hi) {
                indices.append(index)
            }
        }
        
        return indices
    }
    
    func rightGuessIndices(dealtCard: Card, nextCard: Card) -> [Int] {
        var indices = [Int]()
        
        for (index, guess) in self.enumerated() {
            if (nextCard > dealtCard && guess == .hi) || (nextCard < dealtCard && guess == .lo) {
                indices.append(index)
            }
        }
        
        return indices
    }
}
