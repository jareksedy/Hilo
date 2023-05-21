//
//  main.swift
//  Hilo
//
//  Created by Yaroslav Sedyshev on 18.05.2023.
//

let aiPlayer1 = AIPlayer(name: "CyberShark (AI)", funds: 50)
let aiPlayer2 = AIPlayer(name: "DumbBot (AI)", funds: 50, difficulty: .dumb)
let aiPlayer3 = AIPlayer(name: "SmartStrategist (AI)", funds: 50, difficulty: .high)
let humanPlayer = HumanPlayer(name: "Yaroslav", funds: 50)

let deck = Deck()
var game = Game(deck: deck, players: [aiPlayer1, aiPlayer2, aiPlayer3, humanPlayer])

game.intro()
game.play()
