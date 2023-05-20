//
//  main.swift
//  Hilo
//
//  Created by Yaroslav Sedyshev on 18.05.2023.
//

import Foundation

let humanPlayer = HumanPlayer()
let aiPlayer = AIPlayer()
var deck = Deck()
var game = Game(deck: deck, players: [humanPlayer, aiPlayer])

game.play()
