//
//  Game.swift
//  Hilo
//
//  Created by Ярослав on 18.05.2023.
//

enum Prediction: String {
    case hi = "H", lo = "L"
}

protocol Player {
    func makePrediction(by lastOpenCard: Card) -> Prediction
}

struct HumanPlayer: Player {
    func makePrediction(by lastOpenCard: Card) -> Prediction {
        var prediction: Prediction?
        
        repeat {
            print(Strings.prompt.format(lastOpenCard.description), terminator: " ")
            
            if let input = readLine(), input.count == 1 {
                prediction = Prediction(rawValue: input.uppercased())
            }
        } while prediction == nil
        
        return prediction!
    }
}

protocol Playable {
    var deck: Deck { get }
    var players: [Player] { get }
}

struct Game: Playable {
    var deck = Deck()
    var players: [Player]
}
