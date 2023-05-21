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
    
    init(name: String, funds: Int = 250) {
        self.name = name
        self.funds = funds
    }
    
    func makeGuess(by lastOpenCard: Card) -> Guess {
        var guess: Guess?
        
        switch lastOpenCard.rank {
        case .ace: guess = .hi
        case .king: guess = .lo
        default: guess = Guess.random()
        }
        
        print(Strings.aiGuess.format(name), terminator: " ")
        Thread.sleep(forTimeInterval: 0.5)
        print(".", terminator: "")
        Thread.sleep(forTimeInterval: 0.5)
        print(".", terminator: "")
        Thread.sleep(forTimeInterval: 0.5)
        print(".", terminator: "")
        Thread.sleep(forTimeInterval: 0.5)
        print(" " + guess!.rawValue)
        Thread.sleep(forTimeInterval: 1.0)
        
        return guess!
    }
}
