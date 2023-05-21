//
//  Player.swift
//  Hilo
//
//  Created by Yaroslav Sedyshev on 21.05.2023.
//

import Foundation

protocol Player {
    var name: String { get set }
    var funds: Int { get set }
    func makeGuess(by lastOpenCard: Card) -> Guess
}

enum AIDifficulty {
    case dumb
    case normal
    case high
}

struct HumanPlayer: Player {
    var name: String
    var funds: Int
    
    init(name: String, funds: Int = 250) {
        self.name = name
        self.funds = funds
    }
    
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
    private var difficulty: AIDifficulty
    
    init(name: String, funds: Int = 250, difficulty: AIDifficulty = .normal) {
        self.name = name
        self.funds = funds
        self.difficulty = difficulty
    }
    
    func makeGuess(by lastOpenCard: Card) -> Guess {
        var guess: Guess?
        
        if difficulty == .dumb {
            guess = Guess.random()
            printGuessing(guess!)
            return guess!
        }
        
        if difficulty == .high {
            switch lastOpenCard.rank {
            case .ace, .two, .three: guess = .hi
            case .king, .queen: guess = .lo
            case .four, .five: guess = Bool.random() ? .hi : Guess.random()
            case .jack, .ten: guess = Bool.random() ? .lo : Guess.random()
            default: guess = Guess.random()
            }
            
            printGuessing(guess!)
            return guess!
        }
        
        switch lastOpenCard.rank {
        case .ace: guess = .hi
        case .king: guess = .lo
        default: guess = Guess.random()
        }
        
        printGuessing(guess!)
        return guess!
    }
    
    private func printGuessing(_ guess: Guess) {
        print(Strings.aiGuess.format(name), terminator: " ")
        Thread.sleep(forTimeInterval: 0.25)
        print(".", terminator: "")
        Thread.sleep(forTimeInterval: 0.25)
        print(".", terminator: "")
        Thread.sleep(forTimeInterval: 0.25)
        print(".", terminator: "")
        Thread.sleep(forTimeInterval: 0.25)
        print(" " + guess.rawValue)
        Thread.sleep(forTimeInterval: 0.5)
    }
}
