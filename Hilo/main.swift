//
//  main.swift
//  Hilo
//
//  Created by Yaroslav Sedyshev on 18.05.2023.
//

let aiPlayer = AIPlayer(name: "CyberShark (AI)", funds: 50)
let aiPlayer2 = AIPlayer(name: "AceBot (AI)", funds: 50, difficulty: .dumb)
let deck = Deck()

var game = Game(deck: deck, players: [aiPlayer2, aiPlayer])

game.intro()
game.play()
