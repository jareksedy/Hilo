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
    func makePrediction(by: Card) -> Prediction
}

struct HumanPlayer: Player {
    func makePrediction(by: Card) -> Prediction {
        if let input = readLine(),
           let prediction = Prediction(rawValue: input.prefix(1).uppercased()) {
            print(prediction.rawValue)
        }
        return .hi
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
