//
//  main.swift
//  Hilo
//
//  Created by Yaroslav Sedyshev on 18.05.2023.
//

let cyberShark = AIPlayer(name: "CyberShark (AI)", funds: 50)
let dumbBot = AIPlayer(name: "DumbBot (AI)", funds: 50, difficulty: .dumb)
let smartStrategist = AIPlayer(name: "SmartStrategist (AI)", funds: 50, difficulty: .high)
let humanPlayer = HumanPlayer(name: "Yaroslav", funds: 50)

let deck = Deck()
var game = Game(deck: deck, players: [dumbBot, smartStrategist])

game.intro()
game.play()
