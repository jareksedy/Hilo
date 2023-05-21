//
//  Player.swift
//  Hilo
//
//  Created by Yaroslav Sedyshev on 21.05.2023.
//

protocol Player {
    var name: String { get set }
    var funds: Int { get set }
    func makeGuess(by lastOpenCard: Card) -> Guess
}

struct HumanPlayer: Player {
    var name: String
    var funds: Int = 250
    
    func makeGuess(by lastOpenCard: Card) -> Guess {
        var guess: Guess?
        
        repeat {
            print(Strings.guessPrompt.format(name), terminator: " ")
            
            if let input = readLine(), input.count == 1 {
                guess = Guess(rawValue: input.lowercased())
            }
            
        } while guess == nil
        
        return guess!
    }
}

struct AIPlayer: Player {
    var name: String
    var funds: Int = 250
    
    func makeGuess(by lastOpenCard: Card) -> Guess {
        var guess: Guess?
        
        if lastOpenCard.rank == .ace {
            guess = .hi
        } else if lastOpenCard.rank == .king {
            guess = .lo
        } else {
            guess = Guess.random()
        }
        
        print(Strings.aiGuess.format(name, guess!.rawValue))
        return guess!
    }
}
