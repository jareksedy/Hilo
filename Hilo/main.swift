//
//  main.swift
//  Hilo
//
//  Created by Yaroslav Sedyshev on 18.05.2023.
//

import Foundation

let humanPlayer = HumanPlayer(name: "Yaroslav")
let aiPlayer = AIPlayer(name: "CyberShark")
var deck = Deck()
var game = Game(deck: deck, players: [humanPlayer, aiPlayer])

game.play()
