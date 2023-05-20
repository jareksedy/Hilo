//
//  Game.swift
//  Hilo
//
//  Created by Yaroslav Sedyshev on 18.05.2023.
//

enum Guess: String {
    case hi = "h", lo = "l"
    
    static func random() -> Self {
        return Bool.random() ? .hi : .lo
    }
}

protocol Player {
    var funds: Int { get set }
    func makeGuess(by lastOpenCard: Card) -> Guess
}

struct HumanPlayer: Player {
    var funds: Int = 250
    
    func makeGuess(by lastOpenCard: Card) -> Guess {
        var guess: Guess?
        
        repeat {
            print(Strings.guessPrompt, terminator: " ")
            
            if let input = readLine(), input.count == 1 {
                guess = Guess(rawValue: input.lowercased())
            }
        } while guess == nil
        
        return guess!
    }
}

struct AIPlayer: Player {
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
        
        print(Strings.aiGuess.format(guess!.rawValue))
        return guess!
    }
}

protocol Playable {
    var deck: Deck { get }
    var pot: Int { get set }
    var players: [Player] { get }
    var round: Int { get set }
    
    mutating func play()
}

struct Game: Playable {
    var deck: Deck
    var pot: Int = 0
    var players: [Player]
    var round: Int = 0
    
    mutating func play() {
        while players.haveFunds && players.count > 1 {
            deck = Deck()
            round += 1
            makeStakes(by: 25)
            
            print(Strings.roundIntro.format(round))
            print(Strings.potStatusText.format(pot))
            print()
            
            while let dealtCard = deck.pop(), let nextCard = deck.next() {
                print(Strings.dealtCard.format(dealtCard.description))
                let guesses = players.makeGuesses(by: dealtCard)
                
                print()
            }
        }
    }
    
    mutating private func makeStakes(by amount: Int) {
        for (index, _) in players.enumerated() {
            players[index].funds -= amount
            pot += amount
        }
    }
}

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

//extension Array where Element == Guess {
//    func wrongGuessIndex(dealtCard: Card, nextCard: Card) -> Int? {
//        let nextCardHigher = nextCard > dealtCard
//        for (index, guess) in self.enumerated() {
//            if guess == .hi && nextCardHigher {
//                
//            }
//        }
//        return nil
//    }
//}
