//
//  main.swift
//  Hilo
//
//  Created by Yaroslav Sedyshev on 18.05.2023.
//

let humanPlayer = HumanPlayer(name: "Yaroslav", funds: 25)
let aiPlayer = AIPlayer(name: "CyberShark (AI)", funds: 25)
let deck = Deck()

var game = Game(deck: deck, players: [humanPlayer, aiPlayer])

game.intro()
game.play()
